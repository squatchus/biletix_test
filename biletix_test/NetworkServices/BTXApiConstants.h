//
//  BTXAPIErrorCodes.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/30/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#ifndef BTXAPIErrorCodes_h
#define BTXAPIErrorCodes_h

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString* const BTXApiURL;
FOUNDATION_EXPORT NSInteger const BTXApiSuccessCode;

FOUNDATION_EXPORT NSString* const BTXErrorMissingToken;
FOUNDATION_EXPORT NSString* const BTXErrorFailedByStatusCode;
FOUNDATION_EXPORT NSString* const BTXErrorParsingFailed;

#endif /* BTXAPIErrorCodes_h */
