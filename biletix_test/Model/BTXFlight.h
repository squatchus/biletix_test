//
//  BTXFlight.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/30/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTXFlight : NSObject

@property (strong, nonatomic, readonly, nonnull) NSString *flightNumber;
@property (strong, nonatomic, readonly, nonnull) NSString *departureDate;
@property (strong, nonatomic, readonly, nonnull) NSString *departureTime;
@property (strong, nonatomic, readonly, nonnull) NSString *departureAirport;
@property (strong, nonatomic, readonly, nonnull) NSString *arrivalDate;
@property (strong, nonatomic, readonly, nonnull) NSString *arrivalTime;
@property (strong, nonatomic, readonly, nonnull) NSString *arrivalAirport;
@property (strong, nonatomic, readonly, nonnull) NSString *linkSuffix;

- (nonnull instancetype)initWithNumber:(nonnull NSString *)flightNumber
                         departureDate:(nonnull NSString *)departureDate
                         departureTime:(nonnull NSString *)departureTime
                      departureAirport:(nonnull NSString *)departureAirport
                           arrivalDate:(nonnull NSString *)arrivalDate
                           arrivalTime:(nonnull NSString *)arrivalTime
                        arrivalAirport:(nonnull NSString *)arrivalAirport
                                  link:(nonnull NSString *)link;



@end
