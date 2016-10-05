//
//  MainTabBarController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/03.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    [self loadPlan];

    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(planReload) name:@"planReload" object:nil];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)planReload {
    
    [self loadPlan];
    
    self.selectedIndex = 0;
    
}

-(void)loadPlan {
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"dataDic"];
    if (dic) {
        self.navigationItem.title = dic[@"Flight Number"];
    }
    
    PlanViewController *planVC = self.viewControllers[0];
    PlanViewController *divertPlanVC = self.viewControllers[1];
    
    planVC.cellIdentifier = @"NAVLOG";
    divertPlanVC.cellIdentifier = @"NAVLOG";
    
    NSArray *columnListArray = @[@{@"title":@"W/T",@"widthPercent":@0.15},
                                 @{@"title":@"FL",@"widthPercent":@0.05},
                                 @{@"title":@"TC",@"widthPercent":@0.04},
                                 @{@"title":@"MC",@"widthPercent":@0.04},
                                 @{@"title":@"Z/END",@"widthPercent":@0.10},
                                 @{@"title":@"AWYFIR",@"widthPercent":@0.10},
                                 @{@"title":@"WPCOORD",@"widthPercent":@0.10},
                                 @{@"title":@"DST",@"widthPercent":@0.05},
                                 @{@"title":@"ZTM",@"widthPercent":@0.05},
                                 @{@"title":@"ETO",@"widthPercent":@0.10},
                                 @{@"title":@"ATO",@"widthPercent":@0.10},
                                 @{@"title":@"CTM",@"widthPercent":@0.05},
                                 @{@"title":@"FRMNG",@"widthPercent":@0.07}];

    
    planVC.columnListArray = columnListArray;
    divertPlanVC.columnListArray = columnListArray;
    
    [planVC.planTableView reloadData];
    [divertPlanVC.planTableView reloadData];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    planVC.planArray = [NSMutableArray arrayWithArray:[ud objectForKey:@"planArray"]];
    divertPlanVC.planArray = [NSMutableArray arrayWithArray:[ud objectForKey:@"divertPlanArray"]];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
