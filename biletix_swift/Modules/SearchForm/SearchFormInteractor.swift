//
//  SearchInteractor.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 08.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit

protocol SearchFormBusinessLogic {
    func fetchFares(request: Fares.Show.Request)
}

class SearchFormInteractor: SearchFormBusinessLogic {

    let presenter: SearchFormPresentationLogic
    let provider: ProvidesFares

    init(presenter: SearchFormPresentationLogic, provider: ProvidesFares) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func fetchFares(request: Fares.Show.Request) {
        provider.getFares(request: request) { fares in
            let result: Result<[Fare], Fares.Show.Response.Error>
            if let fares = fares, fares.count > 0 {
                result = .success(fares)
            } else if fares?.count == 0 {
                result = .failure(.faresNotFound)
            } else {
                result = .failure(.fetchError)
            }
            self.presenter.presentFares(response: .init(result: result))
        }
    }
    
}
