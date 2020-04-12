//
//  NSDate+Extra.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 08.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import Foundation

extension Date {

    static var weekInterval: TimeInterval {
        60*60*24*7
    }
    
    static var oneWeekFromNow: Date {
        let now = Date()
        return now.addingTimeInterval(weekInterval)
    }
    
    static var twoWeeksFromNow: Date {
        let now = Date()
        return now.addingTimeInterval(weekInterval*2)
    }
    
    var timeString: String {
        "HH-mm".asDateFormatter.string(from: self)
    }
    
    var dateString: String {
        "dd.MM.yyyy".asDateFormatter.string(from: self)
    }
    
    var dateTimeString: String {
        "dd.MM.yyyy HH-mm".asDateFormatter.string(from: self)
    }
    
}
