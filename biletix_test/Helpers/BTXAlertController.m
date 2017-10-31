//
//  BTXAlertController.m
//  biletix_test
//
//  Created by Sergey Mazulev on 11/1/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXAlertController.h"

@implementation BTXAlertController

+ (nonnull instancetype)alertWithTitle:(nonnull NSString *)title
                               message:(nonnull NSString *)message
                           cancelTitle:(nonnull NSString *)cancelTitle {
    BTXAlertController * alert = [BTXAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okButton];
    return alert;
}

@end
