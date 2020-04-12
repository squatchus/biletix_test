//
//  FaresBuilder.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 09.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import Foundation

class FaresBuilder {

    var fares = [Fare]()
    
    func set(fares: [Fare]) -> FaresBuilder {
        self.fares = fares
        return self
    }
    
    func build() -> FaresViewController {
        let presenter = FaresPresenter()
        let interactor = FaresInteractor(presenter: presenter)
        let delegate = FaresTableDelegate(fares: fares)
        let dataSource = FaresTableDataSource(fares: fares)
        let controller = FaresViewController(interactor: interactor, delegate: delegate, dataSource: dataSource)
        presenter.viewController = controller
        return controller
    }
    
}
