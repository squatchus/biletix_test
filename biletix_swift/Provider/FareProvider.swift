//
//  FaresProvider.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 09.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import Foundation

protocol ProvidesFares {
    func getFares(request: Fares.Show.Request, completion: @escaping ([Fare]?) -> ())
}

class FareProvider: ProvidesFares {
    
    let api: APIClient
    
    init (apiClient: APIClient) {
        api = apiClient
    }
    
    func getFares(request: Fares.Show.Request, completion: @escaping ([Fare]?) -> ()) {
        api.getFares(request: request) { (result) in
            switch result {
            case .success(let fares):
                completion(fares)
            case .failure( _):
                completion(nil)
            }
        }
    }
    
}
