//
//  ViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/03/23.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SunMoonCalc.h"
#import "SunMoonCalc2.h"
#import "SunMoonCalc2Data.h"
#import "PlanTableViewCell.h"
#import "DoubleLinePlanColumnView.h"
#import "PDFReader.h"

@interface PlanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UITableView *planTableView;

@property NSArray *columnListArray;

@property NSMutableArray *planArray;

@property NSString *cellIdentifier;

@end

