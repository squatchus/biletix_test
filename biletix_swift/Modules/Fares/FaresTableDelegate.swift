//
//  FaresTableDelegate.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 09.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit

class FaresTableDelegate: NSObject, UITableViewDelegate {

    weak var routingDelegate: FaresRoutingLogic?
    var fares: [Fare]
    
    init(fares: [Fare]) {
        self.fares = fares
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = fares[indexPath.row].link
        routingDelegate?.openExternalLink(link: link)
    }
    
}
