//
//  NSDate+stringValues.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (StringValues)

// returns date from string of format @"dd.MM.yyyy"
+ (nonnull NSDate *)dateFromString:(nonnull NSString *)dateString;

// returns string of format @"HH-mm"
- (nonnull NSString *)timeString;
// returns string of format @"dd.MM.yyyy"
- (nonnull NSString *)dateString;
// returns string of format @"dd.MM.yyyy HH-mm"
- (nonnull NSString *)dateTimeString;

@end
