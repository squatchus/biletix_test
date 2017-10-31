//
//  BTXStartSessionRequest.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <SOAPEngine64/SOAPEngine.h>

@interface BTXStartSessionRequest : SOAPEngine

- (nonnull instancetype)initWithLogin:(nonnull NSString *)login
                             password:(nonnull NSString *)password
                                 hash:(nonnull NSString *)hash
                          disableHash:(BOOL)disable;

- (void)postWithSuccess:(nonnull void(^)(NSString* _Nonnull token))successBlock
                failure:(nonnull void(^)(NSString* _Nonnull error))failureBlock;

@end
