//
//  FaresTableDataSource.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 09.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit

class FaresTableDataSource: NSObject, UITableViewDataSource {

    var fares: [Fare]
    
    init(fares: [Fare]) {
        self.fares = fares
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fares.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FareCell")!
        if let fareCell = cell as? FareCell {
            let fare = fares[indexPath.row]
            fareCell.priceLabel.text = "\(fare.price)\n\(fare.currency)"
            fareCell.outFlightLabel.text = fare.outboundFlight.flightNumber
            fareCell.retFlightLabel.text = fare.returnFlight.flightNumber
            fareCell.outDepDateLabel.text = fare.outboundFlight.departureDate
            fareCell.outArrDateLabel.text = fare.outboundFlight.arrivalDate
            fareCell.retDepDateLabel.text = fare.returnFlight.departureDate
            fareCell.retArrDateLabel.text = fare.returnFlight.arrivalDate
            let outDepPortTime = "\(fare.outboundFlight.departureAirport) \(fare.outboundFlight.departureTime)"
            let outArrPortTime = "\(fare.outboundFlight.arrivalAirport) \(fare.outboundFlight.arrivalTime)"
            let retDepPortTime = "\(fare.returnFlight.departureAirport) \(fare.returnFlight.departureTime)"
            let retArrPortTime = "\(fare.returnFlight.arrivalAirport) \(fare.returnFlight.arrivalTime)"
            fareCell.outDepAirportTimeLabel.text = outDepPortTime
            fareCell.outArrAirportTimeLabel.text = outArrPortTime
            fareCell.retDepAirportTimeLabel.text = retDepPortTime
            fareCell.retArrAirportTimeLabel.text = retArrPortTime
        }
        return cell
    }
    
}
