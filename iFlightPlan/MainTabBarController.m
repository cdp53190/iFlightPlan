//
//  MainTabBarController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/03.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "MainTabBarController.h"

typedef enum tabList : NSInteger {
    NAVLOG,
    ALTN_NAVLOG,
    Sun_Moon,
    SaveLoad,
    ATC_Plan,
    Preflight
    //Summery
} tabList;

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadPlan];
    
    self.tabBar.items[NAVLOG].title = @"NAVLOG";
    self.tabBar.items[ALTN_NAVLOG].title = @"ALTN-NAVLOG";
    self.tabBar.items[Sun_Moon].title = @"Sun-Moon";
//    self.tabBar.items[Summery].title = @"Summery";
    self.tabBar.items[SaveLoad].title = @"Save&Load";
    self.tabBar.items[ATC_Plan].title = @"ATC-Plan";
    self.tabBar.items[Preflight].title = @"Preflight";
    

    
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
    
    PlanViewController *planVC = self.viewControllers[0];
    PlanViewController *divertPlanVC = self.viewControllers[1];
    SunMoonViewController *sunMoonPlanVC = (SunMoonViewController *)(self.viewControllers[2]);
    
    planVC.cellIdentifier = @"MainNAVLOG";
    divertPlanVC.cellIdentifier = @"DivertNAVLOG";
    sunMoonPlanVC.cellIdentifier = @"SunMoon";
    
    NSArray *columnListArray = @[@{@"title":@"W/T",@"widthPercent":@0.14},
                                 @{@"title":@"FL",@"widthPercent":@0.04},
                                 @{@"title":@"TC",@"widthPercent":@0.04},
                                 @{@"title":@"MC",@"widthPercent":@0.04},
                                 @{@"title":@"Z/END",@"widthPercent":@0.10},
                                 @{@"title":@"AWYFIR",@"widthPercent":@0.10},
                                 @{@"title":@"WPCOORD",@"widthPercent":@0.10},
                                 @{@"title":@"DST",@"widthPercent":@0.04},
                                 @{@"title":@"ZTM",@"widthPercent":@0.04},
                                 @{@"title":@"ETO",@"widthPercent":@0.075},
                                 @{@"title":@"ETO2",@"widthPercent":@0.075},
                                 @{@"title":@"ATO",@"widthPercent":@0.075},
                                 @{@"title":@"CTM",@"widthPercent":@0.065},
                                 @{@"title":@"FRMNG",@"widthPercent":@0.07}];

    
    planVC.columnListArray = columnListArray;
    divertPlanVC.columnListArray = columnListArray;
    
    columnListArray = @[@{@"title":@"CTM",@"widthPercent":@0.065},
                        @{@"title":@"TIME",@"widthPercent":@0.065},
                        @{@"title":@"LAT",@"widthPercent":@0.085},
                        @{@"title":@"LON",@"widthPercent":@0.095},
                        @{@"title":@"WPT",@"widthPercent":@0.18},
                        @{@"title":@"FL",@"widthPercent":@0.04},
                        @{@"title":@"SunDIR",@"widthPercent":@0.075},
                        @{@"title":@"SunALT",@"widthPercent":@0.075},
                        @{@"title":@"SunSTATUS",@"widthPercent":@0.09},
                        @{@"title":@"MoonDIR",@"widthPercent":@0.075},
                        @{@"title":@"MoonALT",@"widthPercent":@0.075},
                        @{@"title":@"MoonSTATUS",@"widthPercent":@0.08}];
    
    sunMoonPlanVC.columnListArray = columnListArray;

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
