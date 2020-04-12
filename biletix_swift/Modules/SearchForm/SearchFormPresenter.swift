//
//  SearchPresenter.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 08.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit

protocol SearchFormPresentationLogic {
    func presentFares(response: Fares.Show.Response)
}

class SearchFormPresenter: SearchFormPresentationLogic {

    weak var viewController: SearchFormDisplayLogic?
    
    func presentFares(response: Fares.Show.Response) {
        var viewModel: SearchForm.ViewModel
        let notFoundMessage = "Fares not found"
        let errorMessage = "Unable to fetch fares"
        switch response.result {
        case .failure(let error):
            if error == .fetchError {
                viewModel = .init(state: .error(message: errorMessage))
            } else { // if error == .faresNotFound
                viewModel = .init(state: .faresNotFound(message: notFoundMessage))
            }
        case .success(let fares):
            viewModel = .init(state: .show(fares: fares))
        }
        viewController?.display(viewModel: viewModel)
    }
}
