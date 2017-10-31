//
//  NSDate+stringValues.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "NSDate+stringValues.h"

@implementation NSDate (StringValues)

+ (NSDateFormatter *)formatterWithFormat:(NSString *)string {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:string];
    return formatter;
}

+ (nonnull NSDate *)dateFromString:(nonnull NSString *)dateString {
    return [[NSDate formatterWithFormat:@"dd.MM.yyyy"] dateFromString:dateString];
}

// returns string of format @"HH-mm"
- (nonnull NSString *)timeString {
    return [[NSDate formatterWithFormat:@"HH-mm"] stringFromDate:self];
}
// returns string of format @"dd.MM.yyyy"
- (nonnull NSString *)dateString {
    return [[NSDate formatterWithFormat:@"dd.MM.yyyy"] stringFromDate:self];
}
// returns string of format @"dd.MM.yyyy HH-mm"
- (nonnull NSString *)dateTimeString {
    return [[NSDate formatterWithFormat:@"dd.MM.yyyy HH-mm"] stringFromDate:self];
}

@end
