//
//  SaveLoadViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/08/29.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveLoadTableViewCell.h"
#import "SaveDataPackage.h"

@interface SaveLoadViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property IBOutlet UITableView *tableView;
@property IBOutlet UIBarButtonItem *editBtn;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;


@end
