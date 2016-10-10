//
//  TakeoffTimePickerViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/08.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "TakeoffTimePickerViewController.h"

@interface TakeoffTimePickerViewController ()

@end

@implementation TakeoffTimePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([segue.identifier isEqualToString:@"doneSegue"]) {
        
        PlanViewController *sunMoonVC = segue.destinationViewController;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger flags;
        NSDateComponents *comps;
        
        flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
                NSCalendarUnitHour | NSCalendarUnitMinute;
        comps = [calendar components:flags fromDate:_datePicker.date];
        
        sunMoonVC.takeoffYear = (int)comps.year;
        sunMoonVC.takeoffMonth = (int)comps.month;
        sunMoonVC.takeoffDay = (int)comps.day;
        sunMoonVC.takeoffHour = (int)comps.hour;
        sunMoonVC.takeoffMinute = (int)comps.minute;
        
    }



}


@end
