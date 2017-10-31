//
//  BTXSearchResultsTVC.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/30/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXSearchResultsTVC.h"
#import "BTXFare.h"
#import "BTXFlight.h"
#import "BTXFareTableViewCell.h"

@import SafariServices;

static NSString* const kStoryboardName = @"Main";
static NSString* const kControllerID = @"searchResultsTVC";
static NSString* const kFareCellIdentifier = @"FareCell";

@interface BTXSearchResultsTVC ()

@property (strong, nonatomic, nonnull) NSArray <BTXFare *>* fares;

@end

@implementation BTXSearchResultsTVC

+ (nonnull instancetype)controllerWithFares:(nonnull NSArray <BTXFare *> *)fares {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kStoryboardName bundle:nil];
    BTXSearchResultsTVC *controller = [storyboard instantiateViewControllerWithIdentifier:kControllerID];
    controller.fares = [fares copy];
    return controller;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fares.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BTXFareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFareCellIdentifier forIndexPath:indexPath];

    BTXFare *fare = self.fares[indexPath.row];
    cell.priceLabel.text = [@[fare.price, fare.currency] componentsJoinedByString:@"\n"];
    cell.outFlightLabel.text = fare.outboundFlight.flightNumber;
    cell.retFlightLabel.text = fare.returnFlight.flightNumber;
    cell.outDepDateLabel.text = fare.outboundFlight.departureDate;
    cell.outArrDateLabel.text = fare.outboundFlight.arrivalDate;
    cell.retDepDateLabel.text = fare.returnFlight.departureDate;
    cell.retArrDateLabel.text = fare.returnFlight.arrivalDate;
    NSString *outDepPortTime = [NSString stringWithFormat:@"%@ %@",
                                fare.outboundFlight.departureAirport, fare.outboundFlight.departureTime];
    NSString *outArrPortTime = [NSString stringWithFormat:@"%@ %@",
                                fare.outboundFlight.arrivalAirport, fare.outboundFlight.arrivalTime];
    NSString *retDepPortTime = [NSString stringWithFormat:@"%@ %@",
                                fare.returnFlight.departureAirport, fare.returnFlight.departureTime];
    NSString *retArrPortTime = [NSString stringWithFormat:@"%@ %@",
                                fare.returnFlight.arrivalAirport, fare.returnFlight.arrivalTime];
    cell.outDepAirportTimeLabel.text = outDepPortTime;
    cell.outArrAirportTimeLabel.text = outArrPortTime;
    cell.retDepAirportTimeLabel.text = retDepPortTime;
    cell.retArrAirportTimeLabel.text = retArrPortTime;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.fares.count > indexPath.row) {
        BTXFare *fare = self.fares[indexPath.row];
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:fare.link]];
        [self presentViewController:safariVC animated:YES completion:nil];
    }
}

@end
