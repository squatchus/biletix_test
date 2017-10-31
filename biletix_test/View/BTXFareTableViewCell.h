//
//  BTXFareTableViewCell.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTXFareTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *outFlightLabel;
@property (weak, nonatomic) IBOutlet UILabel *outDepDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *outDepAirportTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *outArrDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *outArrAirportTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *retFlightLabel;
@property (weak, nonatomic) IBOutlet UILabel *retDepDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retDepAirportTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *retArrDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retArrAirportTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



@end
