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
    
    _datePicker.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    _timePicker.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierISO8601];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setDateFormat:@"yyyyMMddHHmm"];
    
    
    NSDate *takeOffDate = [formatter dateFromString:[NSString stringWithFormat:@"%04d%02d%02d%02d%02d",
                                                     [[ud objectForKey:@"sunMoonTakeoffYear"] intValue],
                                                     [[ud objectForKey:@"sunMoonTakeoffMonth"] intValue],
                                                     [[ud objectForKey:@"sunMoonTakeoffDay"] intValue],
                                                     [[ud objectForKey:@"sunMoonTakeoffHour"] intValue],
                                                     [[ud objectForKey:@"sunMoonTakeoffMinute"] intValue]]];
    
    
/*    NSDate *now = [NSDate dateWithTimeIntervalSinceNow: -[[NSTimeZone systemTimeZone] secondsFromGMT]];
        _datePicker.date = now;
        _timePicker.date = now;
*/
    _datePicker.date = takeOffDate;
    _timePicker.date = takeOffDate;
    
    
    
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
        
        SunMoonViewController *sunMoonVC = segue.destinationViewController;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSUInteger flags;
        NSDateComponents *comps;
        
        flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
                NSCalendarUnitHour | NSCalendarUnitMinute;
        comps = [calendar components:flags fromDate:_datePicker.date];
        
        sunMoonVC.takeoffYear = (int)comps.year;
        sunMoonVC.takeoffMonth = (int)comps.month;
        sunMoonVC.takeoffDay = (int)comps.day;
        
        comps = [calendar components:flags fromDate:_timePicker.date];
        sunMoonVC.takeoffHour = (int)comps.hour;
        sunMoonVC.takeoffMinute = (int)comps.minute;
        
    }



}


@end
