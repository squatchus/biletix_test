//
//  FaresDataFlow.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 11.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import Foundation

enum Fares {
    enum Show  {
        struct Request {
            let departurePoint: String
            let arrivalPoint: String
            let outboundDate: Date
            let returnDate: Date
            let adultCount: Int
        }
        struct Response {
            let result: Result<[Fare], Error>
            
            enum Error: Swift.Error {
                case faresNotFound
                case fetchError
            }
        }
    }
    struct ViewModel {
        let fares: [Fare]
    }
}
