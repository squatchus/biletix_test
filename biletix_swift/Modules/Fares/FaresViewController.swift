//
//  FaresViewController.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 08.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit
import SafariServices

protocol FaresDisplayLogic: class {}

protocol FaresRoutingLogic: class {
    func openExternalLink(link: String)
}

class FaresViewController: UITableViewController, FaresDisplayLogic {

    let interactor: FaresBusinessLogic
    let tableDelegate: FaresTableDelegate
    let tableDataSource: FaresTableDataSource
    
    init(interactor: FaresBusinessLogic, delegate: FaresTableDelegate, dataSource: FaresTableDataSource) {
        self.interactor = interactor
        self.tableDelegate = delegate
        self.tableDataSource = dataSource
        super.init(style: .plain)
        self.tableDelegate.routingDelegate = self
        self.title = "Fares"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = tableDelegate
        self.tableView.dataSource = tableDataSource
        self.tableView.rowHeight = 100
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(UINib(nibName: "FareCell", bundle: nil), forCellReuseIdentifier: "FareCell")
    }
}

extension FaresViewController: FaresRoutingLogic {
    func openExternalLink(link: String) {
        let safari = SFSafariViewController(url: link.asURL)
        self.present(safari, animated: true)
    }
}
