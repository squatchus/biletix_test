//
//  NSDate+stringValues.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "NSDate+stringValues.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSDate (StringValues)

+ (NSDateFormatter *)formatterWithFormat:(NSString *)string {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:string];
    return formatter;
}

+ (NSDate *)oneWeekFromNow {
    NSDate *now = NSDate.date;
    NSTimeInterval week = 60*60*24*7;
    return [now dateByAddingTimeInterval:week];
}

+ (NSDate *)twoWeeksFromNow {
    NSDate *now = NSDate.date;
    NSTimeInterval week = 60*60*24*7;
    return [now dateByAddingTimeInterval:(week*2)];
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    return [[NSDate formatterWithFormat:@"dd.MM.yyyy"] dateFromString:dateString];
}

// returns string of format @"HH-mm"
- (NSString *)timeString {
    return [[NSDate formatterWithFormat:@"HH-mm"] stringFromDate:self];
}

// returns string of format @"dd.MM.yyyy"
- (NSString *)dateString {
    return [[NSDate formatterWithFormat:@"dd.MM.yyyy"] stringFromDate:self];
}

// returns string of format @"dd.MM.yyyy HH-mm"
- (NSString *)dateTimeString {
    return [[NSDate formatterWithFormat:@"dd.MM.yyyy HH-mm"] stringFromDate:self];
}

@end

NS_ASSUME_NONNULL_END
