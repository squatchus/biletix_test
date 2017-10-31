//
//  BTXApiClient.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/30/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define kShouldLogRequests
//#define kShouldLogResponses

#define kShouldUseTestMode

@class BTXFare;

@interface BTXApiClient : NSObject

- (void)startSessionWithLogin:(nonnull NSString *)login
                     password:(nonnull NSString *)password
                   completion:(nonnull void(^)(NSString* _Nullable error))handler;

- (void)getOptimalFaresFrom:(nonnull NSString *)departurePoint
                         to:(nonnull NSString *)arrivalPoint
                         on:(nonnull NSString *)outboundDate
                   returnOn:(nullable NSString *)returnDate
                 adultCount:(nonnull NSNumber *)adultCount
                 completion:(nonnull void(^)(NSArray<BTXFare *>* _Nullable fares, NSString* _Nullable error))handler;

@end
