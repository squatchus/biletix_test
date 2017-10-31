//
//  BTXGetOptimalFaresParser.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTXFare;

@interface BTXGetOptimalFaresParser : NSObject

+ (NSArray <BTXFare *>*)faresFromResponseDict:(NSDictionary *)dict;

@end
