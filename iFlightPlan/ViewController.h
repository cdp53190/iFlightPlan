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
#import "PlanHeaderView.h"
#import "PDFReader.h"


@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;
@property (weak, nonatomic) IBOutlet PlanHeaderView *headerView;

@property (weak, nonatomic) IBOutlet UITableView *planTableView;

@property NSArray *columnListArray;

@property NSMutableArray *planArray;

@end

