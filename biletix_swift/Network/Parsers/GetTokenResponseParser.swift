//
//  GetTokenResponseParser.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 12.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit

class GetTokenResponseParser {
    
    let dict: Dictionary<AnyHashable, Any>
    
    init(dict: Dictionary<AnyHashable, Any>) {
        self.dict = dict
    }
    
    func parse() -> (Result<String, Error>) {
        let dict = self.dict as NSDictionary
        let value = dict.value(forKeyPath: "Body.StartSessionOutput.session_token")
        if let token = value as? String {
            return .success(token)
        } else {
            return .failure(API.ParsingError.unableToParseToken)
        }
    }
    
}
