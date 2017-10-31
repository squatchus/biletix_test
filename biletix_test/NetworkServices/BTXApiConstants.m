//
//  BTXApiConstants.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXApiConstants.h"

NSString* const BTXApiURL = @"https://search.biletix.ru/bitrix/components/travelshop/ibe.soap/travelshop_booking.php";

NSInteger const BTXApiSuccessCode = 200;

// client errors
NSString* const BTXErrorMissingToken = @"TOKEN_NOT_FOUND";
NSString* const BTXErrorFailedByStatusCode = @"WRONG_CODE";
NSString* const BTXErrorParsingFailed = @"PARSING_FAILED";
