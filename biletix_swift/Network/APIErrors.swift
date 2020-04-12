//
//  APIClientDataFlow.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 11.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import Foundation

enum API {
    enum Error: Swift.Error {
        case error(code: String, description: String?)
        case sessionError(description: String?)
        case unableToGetToken
        case unableToGetFares
        case responseDictIsMissing
        case unknown
        
    }
    enum ParsingError: Swift.Error {
        case unableToParseToken
        case unableToParseFares
    }
}
