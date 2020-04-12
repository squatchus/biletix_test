//
//  FareCell.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 09.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit

class FareCell: UITableViewCell {

    @IBOutlet weak var outFlightLabel: UILabel!
    @IBOutlet weak var outDepDateLabel: UILabel!
    @IBOutlet weak var outDepAirportTimeLabel: UILabel!
    @IBOutlet weak var outArrDateLabel: UILabel!
    @IBOutlet weak var outArrAirportTimeLabel: UILabel!

    @IBOutlet weak var retFlightLabel: UILabel!
    @IBOutlet weak var retDepDateLabel: UILabel!
    @IBOutlet weak var retDepAirportTimeLabel: UILabel!
    @IBOutlet weak var retArrDateLabel: UILabel!
    @IBOutlet weak var retArrAirportTimeLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!

}
