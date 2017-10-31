//
//  BTXFlight.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/30/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXFlight.h"

@implementation BTXFlight

- (nonnull instancetype)initWithNumber:(nonnull NSString *)flightNumber
                         departureDate:(nonnull NSString *)departureDate
                         departureTime:(nonnull NSString *)departureTime
                      departureAirport:(nonnull NSString *)departureAirport
                           arrivalDate:(nonnull NSString *)arrivalDate
                           arrivalTime:(nonnull NSString *)arrivalTime
                        arrivalAirport:(nonnull NSString *)arrivalAirport
                                  link:(nonnull NSString *)link {
    if (self = [super init]) {
        _flightNumber = flightNumber;
        _departureDate = departureDate;
        _departureTime = departureTime;
        _departureAirport = departureAirport;
        _arrivalDate = arrivalDate;
        _arrivalTime = arrivalTime;
        _arrivalAirport = arrivalAirport;
        _linkSuffix = link;
    }
    return self;
}

@end
