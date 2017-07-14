//
//  ATCViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/18.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATCViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property IBOutlet UITableView *titleTableView;
@property IBOutlet UITableView *detailTableView;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@end
