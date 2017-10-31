//
//  BTXFare.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/30/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXFare.h"

@implementation BTXFare

- (nonnull instancetype)initWithPrice:(nonnull NSNumber *)price
                             currency:(nonnull NSString *)currency
                                 link:(nonnull NSString *)link
                       outboundFlight:(nonnull BTXFlight *)outboundFlight
                         returnFlight:(nonnull BTXFlight *)returnFlight {
    if (self = [super init]) {
        _price = price;
        _currency = currency;
        _link = link;
        _outboundFlight = outboundFlight;
        _returnFlight = returnFlight;
        return self;
    }
    return nil;
}

@end
