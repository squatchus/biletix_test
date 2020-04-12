//
//  FaresProvider.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 09.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import Foundation

//enum

protocol ProvidesFares {
    func getFares(completion: @escaping ([Fare]?) -> ())
}

class FareProvider: ProvidesFares {
    func getFares(completion: @escaping ([Fare]?) -> ()) {
        completion(nil)
    }
    
    
    
    
}
