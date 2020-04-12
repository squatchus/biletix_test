//
//  APITask.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 12.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit
import SOAPEngine64
import OrderedDictionary

class APITask: SOAPEngine {

    let url: String
    let action: APIAction
    var params: OrderedDictionary<APIRequestParamKey, String>
    let completion: (Result<Dictionary<AnyHashable, Any>, Error>)->()
    
    init(url: String, action: APIAction, params: OrderedDictionary<APIRequestParamKey, String>, completion: @escaping (Result<Dictionary<AnyHashable, Any>, Error>)->()) {
        self.url = url
        self.action = action
        self.params = params
        self.completion = completion
        super.init()
        self.responseHeader = true
        self.actionAttributes = ["xmlns:m": "http://www.tais.ru/"]
        for (key, value) in params {
            self.setValue(value, forKey: key.rawValue)
        }
    }
    
    func update(token: String) {
        let key = APIRequestParamKey.sessionToken
        self.params[key] = token
        self.clearValues()
        for (key, value) in params {
            self.setValue(value, forKey: key.rawValue)
        }
    }
    
    func run() {
        self.requestURL(url, soapAction: action.rawValue, completeWithDictionary: { [weak self] (code, dict) in
            if let dict = dict {
                self?.completion(.success(dict))
            } else {
                self?.completion(.failure(API.Error.responseDictIsMissing))
            }
        }) { [weak self] (error) in
            if let error = error {
                self?.completion(.failure(error))
            } else {
                self?.completion(.failure(API.Error.unknown))
            }
        }
    }
    
}
