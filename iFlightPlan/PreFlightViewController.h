//
//  PreFlightViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/07/21.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteCopy.h"
#import "SELCALPlayer.h"
#import "SaveDataPackage.h"

@interface PreFlightViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property IBOutlet UITableView *legsTableView;
@property IBOutlet UILabel *sunRiseSetLabel;

@end
