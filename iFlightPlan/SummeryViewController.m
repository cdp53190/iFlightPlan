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
{
    SELCALPlayer *selcalPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selcalPlayer = [[SELCALPlayer alloc] init];
    
    

}

-(void)viewWillAppear:(BOOL)animated {
    
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



- (IBAction)pushSELCAL:(UIButton *)sender {
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"dataDic"];
    
    [selcalPlayer playWithSELCALString:dic[@"SELCAL"]];
    
}

- (void)pushRoute:(UIButton *)sender {
    
    RouteCopy *routeCopy = [[RouteCopy alloc]init];
    NSString *routeString = [routeCopy stringOfJeppsenRoute];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    [pasteboard setValue:routeString forPasteboardType:@"public.text"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Route Copied"
                                                                             message:routeString
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {}]];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:^{}];
    
    
}

@end
