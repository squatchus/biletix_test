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
                         returnFlight:(nullable BTXFlight *)returnFlight {
    if (self = [super init]) {
        _price = [NSDecimalNumber decimalNumberWithDecimal:[price decimalValue]];
        _currency = [currency copy];
        _link = [link copy];
        _outboundFlight = outboundFlight;
        _returnFlight = returnFlight;
        return self;
    }
    return nil;
}

@end
