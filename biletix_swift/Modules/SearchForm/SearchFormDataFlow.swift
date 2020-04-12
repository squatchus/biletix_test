//
//  SearchFormDataFlow.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 11.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import Foundation

enum SearchForm {
    
    struct ViewModel {
        let state: State
    }
    
    enum State {
        case initial
        case loading
        case show(fares: [Fare])
        case faresNotFound(message: String)
        case error(message: String)
    }
    
    struct InitialState {
        var departurePoint: String
        var arrivalPoint: String
        var outboundDate: Date
        var returnDate: Date
        var adultCount: Int
    }
    
}
