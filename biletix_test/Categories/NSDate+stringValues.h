//
//  NSDate+stringValues.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (StringValues)

// returns date from string of format @"dd.MM.yyyy"
+ (NSDate *)dateFromString:(NSString *)dateString;

+ (NSDate *)oneWeekFromNow;
+ (NSDate *)twoWeeksFromNow;

// returns string of format @"HH-mm"
- (NSString *)timeString;
// returns string of format @"dd.MM.yyyy"
- (NSString *)dateString;
// returns string of format @"dd.MM.yyyy HH-mm"
- (NSString *)dateTimeString;

@end

NS_ASSUME_NONNULL_END
