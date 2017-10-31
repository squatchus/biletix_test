//
//  BTXApiClient.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/30/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXApiClient.h"
#import "BTXXmlFormatter.h"
#import "BTXHashGenerator.h"
#import "BTXStartSessionRequest.h"
#import "BTXGetOptimalFaresRequest.h"

NSString* const kSecret = @"TaisSharedSecret";
NSString* const kTestCredentials = @"[partner]||SOAPTEST";

@interface BTXApiClient () <SOAPEngineDelegate>

@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *sessionToken;
@property (strong, nonatomic) BTXStartSessionRequest *startSessionRequest;
@property (strong, nonatomic) BTXGetOptimalFaresRequest *getOptimalFaresRequest;

@end

@implementation BTXApiClient

- (void)startSessionWithLogin:(nonnull NSString *)login
                     password:(nonnull NSString *)password
                   completion:(void(^)(NSString *error))handler {
    self.login = login;
    self.password = password;
    NSString *hash = [BTXHashGenerator md5HashWithArray:@[login, password, kSecret]];
    BOOL disableHash = NO;
#ifdef kShouldUseTestMode
    login = kTestCredentials;
    password = kTestCredentials;
    hash = kTestCredentials;
    disableHash = YES;
#endif

    [self.startSessionRequest cancel];

    self.startSessionRequest = [[BTXStartSessionRequest alloc] initWithLogin:login password:password hash:hash disableHash:YES];
    self.startSessionRequest.delegate = self;
    
    [self.startSessionRequest postWithSuccess:^(NSString * _Nullable token) {
        self.sessionToken = token;
        handler(nil);
    } failure:^(NSString * _Nullable error) {
        handler(error);
    }];
}

- (void)getOptimalFaresFrom:(nonnull NSString *)departurePoint
                         to:(nonnull NSString *)arrivalPoint
                         on:(nonnull NSString *)outboundDate
                   returnOn:(nullable NSString *)returnDate
                 adultCount:(nonnull NSNumber *)adultCount
                 completion:(nonnull void(^)(NSArray<BTXFare *>* _Nullable fares, NSString* _Nullable error))handler {
    NSString *hash = [BTXHashGenerator md5HashWithArray:@[self.login, self.password, (returnDate ? @"RT" : @"") , departurePoint, arrivalPoint, outboundDate, (returnDate ? returnDate : @""), kSecret]];
#ifdef kShouldUseTestMode
    hash = kTestCredentials;
#endif
    
	[self.getOptimalFaresRequest cancel];
    
    self.getOptimalFaresRequest = [[BTXGetOptimalFaresRequest alloc] initWithToken:self.sessionToken hash:hash from:departurePoint to:arrivalPoint outboundOn:outboundDate returnOn:returnDate adultCount:adultCount];
    self.getOptimalFaresRequest.delegate = self;
    
    [self.getOptimalFaresRequest postWithSuccess:^(NSArray<BTXFare *> * _Nonnull fares) {
        handler(fares, nil);
    } failure:^(NSString * _Nullable error) {
        handler(nil, error);
    }];
}

#pragma mark - SOAPEngine Delegate Methods

- (NSMutableURLRequest*)soapEngine:(SOAPEngine*)soapEngine didBeforeSendingURLRequest:(NSMutableURLRequest*)request {
#ifdef kShouldLogRequests
    NSString *body = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    NSLog(@"\n\n>>> SOAP request:\n\n%@\n...", [BTXXmlFormatter prettyPrinted:body]);
#endif
    return request;
}

- (NSData*)soapEngine:(SOAPEngine*)soapEngine didBeforeParsingResponseData:(NSData*)data {
#ifdef kShouldLogResponses
    NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"\n\n<<< SOAP response:\n\n%@\n...", [BTXXmlFormatter prettyPrinted:body]);
#endif
    return data;
}

@end
