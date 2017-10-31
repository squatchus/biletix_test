//
//  BTXHashGenerator.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTXHashGenerator : NSObject

+ (NSString *)md5HashWithArray:(NSArray<NSString *> *)array;

@end
