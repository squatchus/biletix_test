//
//  BTXFare.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/30/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTXFlight;

@interface BTXFare : NSObject

@property (strong, nonatomic, readonly, nonnull) NSDecimalNumber *price;
@property (strong, nonatomic, readonly, nonnull) NSString *currency;
@property (strong, nonatomic, readonly, nonnull) NSString *link;
@property (strong, nonatomic, readonly, nonnull) BTXFlight *outboundFlight;
@property (strong, nonatomic, readonly, nullable) BTXFlight *returnFlight;

/*! @abstract Use initWithPrice:... to init BTXFare. */
- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithPrice:(nonnull NSNumber *)price
                             currency:(nonnull NSString *)currency
                                 link:(nonnull NSString *)link
                       outboundFlight:(nonnull BTXFlight *)outboundFlight
                         returnFlight:(nullable BTXFlight *)returnFlight NS_DESIGNATED_INITIALIZER;

@end
