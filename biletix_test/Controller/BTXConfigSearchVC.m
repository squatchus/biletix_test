//
//  BTXConfigSearchVC.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/28/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXConfigSearchVC.h"
#import "BTXApiClient.h"
#import "BTXApiConstants.h"
#import "BTXSearchResultsTVC.h"
#import "BTXAlertController.h"
#import "NSDate+stringValues.h"

#import <SOAPEngine64/SOAPEngine.h>

NSString* const kDefaultLogin = @"";
NSString* const kDefaultPassword = @"";

@interface BTXConfigSearchVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fromTextField;
@property (weak, nonatomic) IBOutlet UITextField *toTextField;
@property (weak, nonatomic) IBOutlet UIButton *outboundButton;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) UIButton *datePickerButton;
@property (strong, nonatomic) UIColor *defaultBlueColor;

@property (strong, nonatomic, nonnull) BTXApiClient *apiClient;

- (IBAction)onSearchButtonPressed:(UIButton *)sender;
- (IBAction)onDatePickerValueChanged:(UIDatePicker *)sender;

@end

@implementation BTXConfigSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datePicker.minimumDate = [NSDate date];
    self.datePickerButton = self.outboundButton;
    self.defaultBlueColor = [self.returnButton titleColorForState:UIControlStateNormal];
    
    self.apiClient = [BTXApiClient new];
    
    __weak BTXConfigSearchVC *weakSelf = self;
    [self.apiClient startSessionWithLogin:kDefaultLogin password:kDefaultPassword completion:^(NSString *error) {
        if (weakSelf && error) {
            BTXAlertController *alert = [BTXAlertController alertWithTitle:@"Search" message:error cancelTitle:@"Ok"];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (IBAction)onOutboundButtonPressed:(UIButton *)sender {
    [self.fromTextField endEditing:YES];
    [self.toTextField endEditing:YES];
    self.datePickerButton = self.outboundButton;
    [self.outboundButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.returnButton setTitleColor:self.defaultBlueColor forState:UIControlStateNormal];
    [self.datePicker setDate:[NSDate dateFromString:self.outboundButton.titleLabel.text]];
}

- (IBAction)onReturnButtonPressed:(UIButton *)sender {
    [self.fromTextField endEditing:YES];
    [self.toTextField endEditing:YES];
    self.datePickerButton = self.returnButton;
    [self.returnButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.outboundButton setTitleColor:self.defaultBlueColor forState:UIControlStateNormal];
    [self.datePicker setDate:[NSDate dateFromString:self.returnButton.titleLabel.text]];
}

- (IBAction)onDatePickerValueChanged:(UIDatePicker *)sender {
    [self.datePickerButton setTitle:[sender.date dateString] forState:UIControlStateNormal];
}

- (IBAction)onSearchButtonPressed:(UIButton *)sender {
    [self.activityIndicator startAnimating];
    NSString *departurePoint = self.fromTextField.text;
    if (departurePoint.length == 0) {
        departurePoint = self.fromTextField.placeholder;
    }
    NSString *arrivalPoint = self.toTextField.text;
    if (arrivalPoint.length == 0) {
        arrivalPoint = self.toTextField.placeholder;
    }
    
    __weak BTXConfigSearchVC *weakSelf = self;
    
    [self.apiClient getOptimalFaresFrom:departurePoint
                                           to:arrivalPoint
                                           on:self.outboundButton.titleLabel.text
                                     returnOn:self.returnButton.titleLabel.text
                                   adultCount:@(1)
                                   completion:^(NSArray<BTXFare *> * _Nullable fares, NSString * _Nullable error) {
        [weakSelf.activityIndicator stopAnimating];
        if (error) {
            BTXAlertController *alert = [BTXAlertController alertWithTitle:@"Search" message:error cancelTitle:@"Ok"];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        } else {
            BTXSearchResultsTVC *results = [BTXSearchResultsTVC controllerWithFares:fares];
            [weakSelf.navigationController pushViewController:results animated:YES];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
