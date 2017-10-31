//
//  BTXConfigSearchVC.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/28/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXConfigSearchVC.h"
#import "BTXApiClient.h"
#import "BTXSearchResultsTVC.h"

@interface BTXConfigSearchVC ()

@property (weak, nonatomic) IBOutlet UITextField *fromTextField;
@property (weak, nonatomic) IBOutlet UITextField *toTextField;
@property (weak, nonatomic) IBOutlet UIButton *outboundButton;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) UIButton *datePickerButton;
@property (strong, nonatomic) UIColor *defaultBlueColor;

@property (nonatomic, strong, nonnull) BTXApiClient *apiClient;


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
    [self.apiClient startSessionWithLogin:@"" password:@"" completion:^(NSString *error) {
        if (error) NSLog(@"Error (can't start session): %@", error);
    }];
}

- (IBAction)onOutboundButtonPressed:(UIButton *)sender {
    self.datePickerButton = self.outboundButton;
    [self.datePickerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.returnButton setTitleColor:self.defaultBlueColor forState:UIControlStateNormal];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    [self.datePicker setDate:[formatter dateFromString:self.datePickerButton.titleLabel.text]];
}

- (IBAction)onReturnButtonPressed:(UIButton *)sender {
    self.datePickerButton = self.returnButton;
    [self.datePickerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.outboundButton setTitleColor:self.defaultBlueColor forState:UIControlStateNormal];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    [self.datePicker setDate:[formatter dateFromString:self.datePickerButton.titleLabel.text]];
}

- (IBAction)onDatePickerValueChanged:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSString *date = [formatter stringFromDate:[sender date]];
    [self.datePickerButton setTitle:date forState:UIControlStateNormal];
}

- (IBAction)onSearchButtonPressed:(UIButton *)sender {
    [self.activityIndicator startAnimating];
    [self.apiClient searchForOptimalFaresFrom:self.fromTextField.text
                                           to:self.toTextField.text
                                           on:self.outboundButton.titleLabel.text
                                     returnOn:self.returnButton.titleLabel.text
                                   adultCount:@(1)
                                   completion:^(NSArray<BTXFare *> * _Nullable fares, NSString * _Nullable error) {
        [self.activityIndicator stopAnimating];
        if (error) NSLog(@"Error (can't get optimal fares): %@", error);
        else {
            BTXSearchResultsTVC *results = [BTXSearchResultsTVC controllerWithFares:fares];
            [self.navigationController pushViewController:results animated:YES];
        }
    }];
}




@end
