//
//  SummeryViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/09/23.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "SummeryViewController.h"

@interface SummeryViewController ()

@end

@implementation SummeryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults objectForKey:@"dataDic"];
    
    _mainTextView.text = [NSString stringWithFormat:@"%@",dic];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
