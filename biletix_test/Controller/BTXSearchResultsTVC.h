//
//  BTXSearchResultsTVC.h
//  biletix_test
//
//  Created by Sergey Mazulev on 10/30/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTXFare;

@interface BTXSearchResultsTVC : UITableViewController

+ (nonnull instancetype)controllerWithFares:(nonnull NSArray <BTXFare *> *)fares;

@end
