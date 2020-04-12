//
//  Fare.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 09.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import Foundation

struct Fare {
    let price: Decimal
    let currency: String
    let link: String
    let outboundFlight: Flight
    let returnFlight: Flight
}
