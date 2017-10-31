//
//  BTXAlertController.h
//  biletix_test
//
//  Created by Sergey Mazulev on 11/1/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTXAlertController : UIAlertController

+ (nonnull instancetype)alertWithTitle:(nonnull NSString *)title
                               message:(nonnull NSString *)message
                           cancelTitle:(nonnull NSString *)cancelTitle;

@end
