//
//  String+Extra.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 08.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import CommonCrypto
import Foundation
import UIKit

extension String {
    var asDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = self
        return formatter
    }
    
    var asDate: Date {
        "dd.MM.yyyy".asDateFormatter.date(from: self)!
    }
    
    var asAlert: UIAlertController {
        let alert = UIAlertController(title: "Attention", message: self, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        return alert
    }
    
    var asURL: URL {
        URL(string: self)!
    }
}
