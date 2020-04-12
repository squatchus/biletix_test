//
//  APIClient.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 11.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit
import SOAPEngine64
import OrderedDictionary

enum APIAction: String {
    case getToken = "m:StartSessionInput"
    case getFares = "m:GetOptimalFaresInput"
}

enum APIRequestParamKey: String {
    case login = "m:login"
    case password = "m:password"
    case hash = "m:hash"
    case disableHash = "m:disable_hash"
    case sessionToken = "m:session_token"
    case departurePoint = "m:departure_point"
    case arrivalPoint = "m:arrival_point"
    case outboundDate = "m:outbound_date"
    case returnDate = "m:return_date"
    case owrt = "m:owrt"
    case adultCount = "m:adult_count"
    case directOnly = "m:direct_only"
}

typealias GetFaresRequest = Fares.Show.Request

typealias GetTokenCompletion = (Result<String, Error>)->()
typealias GetFaresCompletion = (Result<[Fare], Error>)->()

protocol APIClient {
    func getFares(request:GetFaresRequest, completion: @escaping GetFaresCompletion)
}

class TestAPIClient: NSObject, APIClient {
    
    let url = "https://search.biletix.ru/bitrix/components/travelshop/ibe.soap/travelshop_booking.php"
    let testCredential = "[partner]||SOAPTEST"
    let secret = "TaisSharedSecret"
    var token: String?
    
    func getToken(completion: @escaping GetTokenCompletion) {
        let params: OrderedDictionary<APIRequestParamKey, String> = [
            .login: testCredential,
            .password: testCredential,
            .hash: testCredential,
            .disableHash: "Y",
        ]
        let task = APITask(url: url, action: .getToken, params: params) { (result) in
            switch result {
            case .success(let dict):
                let parser = GetTokenResponseParser(dict: dict)
                completion(parser.parse())
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.delegate = self
        task.run()
    }
    
    func getFares(request:Fares.Show.Request, completion: @escaping GetFaresCompletion) {
        let params: OrderedDictionary<APIRequestParamKey, String> = [
            .sessionToken: self.token ?? "",
            .owrt: "RT",
            .departurePoint: request.departurePoint,
            .arrivalPoint: request.arrivalPoint,
            .outboundDate: request.outboundDate.dateString,
            .returnDate: request.returnDate.dateString,
            .adultCount: "\(request.adultCount)",
            .directOnly: "Y",
            .hash: testCredential,
        ]
        let task = APITask(url: url, action: .getFares, params: params) { (result) in
            switch result {
            case .success(let dict):
                let parser = GetFaresResponseParser(dict: dict)
                DispatchQueue.main.async {
                    completion(parser.parse())
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.delegate = self
        self.execute(task: task)
    }
    
    func execute(task: APITask) {
        let executeAfterTokenUpdate = {
            self.getToken { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    self.token = token
                    task.update(token: token)
                    self.execute(task: task)
                case .failure(let error):
                    task.completion(.failure(error))
                }
            }
        }
        
        if token != nil {
            task.run()
        } else {
            executeAfterTokenUpdate()
        }
    }
}

extension TestAPIClient: SOAPEngineDelegate {
    func soapEngine(_ soapEngine: SOAPEngine!, didBeforeSending request: NSMutableURLRequest!) -> NSMutableURLRequest! {
        let body = String(data: request.httpBody!, encoding: .utf8)!
        let pretty = BTXXmlFormatter.prettyPrinted(body)!
        print("\n\n>>> SOAP request:\n\n\(pretty)\n...")
        return request
    }
    
    func soapEngine(_ soapEngine: SOAPEngine!, didBeforeParsingResponseData data: Data!) -> Data! {
        let body = String(data: data, encoding: .utf8)!
        let pretty = BTXXmlFormatter.prettyPrinted(body)!
        print("\n\n<<< SOAP response:\n\n\(pretty)\n...")
        return data
    }
}
