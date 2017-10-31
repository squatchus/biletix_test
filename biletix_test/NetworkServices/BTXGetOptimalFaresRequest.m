//
//  BTXGetOptimalFaresRequest.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXGetOptimalFaresRequest.h"
#import "BTXApiConstants.h"
#import "BTXGetOptimalFaresParser.h"

static NSString* const kActionName = @"m:GetOptimalFaresInput";

// request params keys
static NSString* const kTokenParamKey = @"m:session_token";
static NSString *const kHashParamKey = @"m:hash";
static NSString *const kDeparturePointParamKey = @"m:departure_point";
static NSString *const kArrivalPointParamKey = @"m:arrival_point";
static NSString *const kOutboundDateParamKey = @"m:outbound_date";
static NSString *const kReturnDateParamKey = @"m:return_date";
static NSString *const kOwrtParamKey = @"m:owrt";
static NSString *const kAdultCountParamKey = @"m:adult_count";
static NSString *const kDirectOnlyParamKey = @"m:direct_only";

// response params keys
static NSString *const kCurrencyResponseKeyPath = @"Body.GetOptimalFaresOutput.currency";


@implementation BTXGetOptimalFaresRequest

- (nonnull instancetype)initWithToken:(nonnull NSString *)token
                                 hash:(nonnull NSString *)hash
                                 from:(nonnull NSString *)departurePoint
                                   to:(nonnull NSString *)arrivalPoint
                           outboundOn:(nonnull NSDate *)outboundDate
                             returnOn:(nullable NSDate *)returnDate
                           adultCount:(nonnull NSNumber *)adultCount {
    if (self = [super init]) {
        super.responseHeader = YES;
        super.actionAttributes = @{@"xmlns:m" : @"http://www.tais.ru/"};
        NSDictionary *params = @{ kTokenParamKey: token,
                                  kOwrtParamKey: (returnDate ? @"RT" : @""),
                                  kDeparturePointParamKey: departurePoint,
                                  kArrivalPointParamKey: arrivalPoint,
                                  kOutboundDateParamKey: outboundDate,
                                  kReturnDateParamKey: returnDate,
                                  kAdultCountParamKey: adultCount,
                                  kDirectOnlyParamKey: @"Y",
                                  kHashParamKey: hash };
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) { [super setValue:obj forKey:key]; }];
        return self;
    }
    return nil;
}

- (void)postWithSuccess:(nonnull void(^)(NSArray<BTXFare *>* _Nonnull fares))successBlock
                failure:(nonnull void(^)(NSString* _Nullable error))failureBlock {
    NSString *url = BTXApiURL;
    [super requestURL:url soapAction:kActionName completeWithDictionary:^(NSInteger statusCode, NSDictionary *dict) {
        NSArray *fares = [BTXGetOptimalFaresParser faresFromResponseDict:dict];
        if (statusCode == BTXApiSuccessCode && fares)
            successBlock(fares);
        else if (!fares)
            failureBlock(BTXErrorParsingFailed);
        else
            failureBlock(BTXErrorFailedByStatusCode);
    } failWithError:^(NSError *error) {
        failureBlock([error localizedDescription]);
    }];
}


@end
