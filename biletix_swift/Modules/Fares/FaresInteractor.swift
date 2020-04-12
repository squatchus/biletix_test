//
//  FaresInteractor.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 09.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit

protocol FaresBusinessLogic {}

class FaresInteractor: FaresBusinessLogic {
    
    let presenter: FaresPresenter
    
    init(presenter: FaresPresenter) {
        self.presenter = presenter
    }

}
