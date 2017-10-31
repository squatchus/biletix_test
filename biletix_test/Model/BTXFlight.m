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
        _flightNumber = [flightNumber copy];
        _departureDate = [departureDate copy];
        _departureTime = [departureTime copy];
        _departureAirport = [departureAirport copy];
        _arrivalDate = [arrivalDate copy];
        _arrivalTime = [arrivalTime copy];
        _arrivalAirport = [arrivalAirport copy];
        _linkSuffix = [link copy];
    }
    return self;
}

@end
