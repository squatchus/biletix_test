//
//  BTXGetOptimalFaresRequest.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <SOAPEngine64/SOAPEngine.h>

@class BTXFare;

@interface BTXGetOptimalFaresRequest : SOAPEngine

- (nonnull instancetype)initWithToken:(nonnull NSString *)token
                                 hash:(nonnull NSString *)hash
                                 from:(nonnull NSString *)departurePoint
                                   to:(nonnull NSString *)arrivalPoint
                           outboundOn:(nonnull NSString *)outboundDate
                             returnOn:(nullable NSString *)returnDate
                           adultCount:(nonnull NSNumber *)adultCount;
;

- (void)postWithSuccess:(nonnull void(^)(NSArray<BTXFare *>* _Nonnull fares))successBlock
                failure:(nonnull void(^)(NSString* _Nullable error))failureBlock;

@end
