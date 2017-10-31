//
//  BTXStartSessionRequest.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXStartSessionRequest.h"
#import "BTXApiConstants.h"

static NSString* const kActionName = @"m:StartSessionInput";

// request params keys
static NSString* const kLoginParamKey = @"m:login";
static NSString* const kPasswordParamKey = @"m:password";
static NSString* const kHashParamKey = @"m:hash";
static NSString* const kDisableHashParamKey = @"m:disable_hash";

// response params keys
static NSString* const kTokenResponseKeyPath = @"Body.StartSessionOutput.session_token";


@implementation BTXStartSessionRequest

- (nonnull instancetype)initWithLogin:(NSString *)login
                     password:(NSString *)password
                         hash:(NSString *)hash
                  disableHash:(BOOL)disable {
    if (self = [super init]) {
        super.responseHeader = YES;
        super.actionAttributes = @{@"xmlns:m" : @"http://www.tais.ru/"};
        
        [super setValue:login forKey:kLoginParamKey];
        [super setValue:password forKey:kPasswordParamKey];
        [super setValue:hash forKey:kHashParamKey];
        if (disable) [super setValue:@"Y" forKey:kDisableHashParamKey];
        
        return self;
    }
    return nil;
}

- (void)postWithSuccess:(nonnull void(^)(NSString* _Nonnull token))successBlock
                failure:(nonnull void(^)(NSString* _Nullable error))failureBlock {
    NSString *url = BTXApiURL;
    [super requestURL:url soapAction:kActionName completeWithDictionary:^(NSInteger statusCode, NSDictionary *dict) {
        NSString *token = nil;
        @try {
            token = [dict valueForKeyPath:kTokenResponseKeyPath];
        } @catch (NSException *exception) {
            failureBlock(BTXErrorMissingToken);
        }
        
        if (statusCode == BTXApiSuccessCode && token) {
            successBlock(token);
        } else {
            failureBlock(BTXErrorFailedByStatusCode);
        }
    } failWithError:^(NSError *error) {
        failureBlock([error localizedDescription]);
    }];
}

@end
