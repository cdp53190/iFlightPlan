//
//  ViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/03/23.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlanTableViewCell.h"
#import "SingleLinePlanColumnView.h"
#import "DoubleLinePlanColumnView.h"
#import "TimeEntryViewController.h"
#import "FuelEntryViewController.h"
#import "SaveDataPackage.h"

@interface PlanViewController : UIViewController
<UITableViewDataSource,
UITableViewDelegate,
UIBarPositioningDelegate,
DoubleLinePlanColumnViewDelegate,
TimeEntryViewControllerDelegate,
FuelEntryViewControllerDelegate>



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UITableView *planTableView;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;


@property NSArray *columnListArray;

@property NSMutableArray *planArray;

@property NSString *cellIdentifier;

-(void)drawUnderLine;

@end

