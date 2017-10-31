//
//  BTXHashGenerator.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXHashGenerator.h"
#import <CommonCrypto/CommonDigest.h>

@implementation BTXHashGenerator

+ (NSString *)md5HashWithArray:(NSArray<NSString *> *)array {
    NSString *joined = [array componentsJoinedByString:@""];
    const char* data = [joined UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, (CC_LONG)strlen(data), result);
    NSString *hashFormat = @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X";
    NSString *hash = [NSString stringWithFormat:hashFormat,
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]];
    return hash;
}

@end
