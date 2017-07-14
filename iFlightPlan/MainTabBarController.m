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
                        @{@"title":@"WPT",@"widthPercent":@0.16},
                        @{@"title":@"FL",@"widthPercent":@0.06},
                        @{@"title":@"SunDIR",@"widthPercent":@0.075},
                        @{@"title":@"SunALT",@"widthPercent":@0.075},
                        @{@"title":@"SunSTATUS",@"widthPercent":@0.09},
                        @{@"title":@"MoonDIR",@"widthPercent":@0.075},
                        @{@"title":@"MoonALT",@"widthPercent":@0.075},
                        @{@"title":@"MoonSTATUS",@"widthPercent":@0.08}];
    
    sunMoonPlanVC.columnListArray = columnListArray;
    
    /*
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    planVC.planArray = [NSMutableArray arrayWithArray:[ud objectForKey:@"planArray"]];
    divertPlanVC.planArray = [NSMutableArray arrayWithArray:[ud objectForKey:@"divertPlanArray"]];
    sunMoonPlanVC.planArray = [NSMutableArray arrayWithArray:[ud objectForKey:@"sunMoonPlanArray"]];

    
    [planVC.planTableView reloadData];
    [divertPlanVC.planTableView reloadData];
    [sunMoonPlanVC.planTableView reloadData];*/

}
/*
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    if(self.selectedIndex == 2){
        self.navigationController.navigationItem;
        UIBarButtonItem *btn =
        [[UIBarButtonItem alloc]
         initWithTitle:@"ぼたん"  // ボタンタイトル名を指定
         style:UIBarButtonItemStylePlain  // スタイルを指定（※下記表参照）
         target:self  // デリゲートのターゲットを指定
         action:@selector(hoge)  // ボタンが押されたときに呼ばれるメソッドを指定
         ];
        
    }
    
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
