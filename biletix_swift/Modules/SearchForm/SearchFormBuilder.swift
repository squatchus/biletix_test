//
//  SearchBuilder.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 09.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit

class SearchFormBuilder {

    func build() -> SearchFormViewController {
        let initial = SearchForm.InitialState(departurePoint: "MOW", arrivalPoint: "LED", outboundDate: .oneWeekFromNow, returnDate: .twoWeeksFromNow, adultCount: 1)
        let api = TestAPIClient()
        let provider = FareProvider(apiClient: api)
        let presenter = SearchFormPresenter()
        let interactor = SearchFormInteractor(presenter: presenter, provider: provider)
        let controller = SearchFormViewController(interactor: interactor, initialState: initial)
        presenter.viewController = controller
        return controller
    }
    
}
