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
    
    SaveDataPackage *dataPackage = [SaveDataPackage presentData];
    
    TakeoffTimeData *takeOffData = dataPackage.sunMoonTakeoffDate;
    NSDate *takeOffDate = [takeOffData date];    

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
        NSDateComponents *compsDate, *compsMinute;
        
        flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
                NSCalendarUnitHour | NSCalendarUnitMinute;
        compsDate = [calendar components:flags fromDate:_datePicker.date];
        compsMinute = [calendar components:flags fromDate:_timePicker.date];
        
        NSMutableString *timeString = [NSMutableString stringWithFormat:@"%02d%02d %02d%02d%04d",
                                       (int)compsMinute.hour,
                                       (int)compsMinute.minute,
                                       (int)compsDate.day,
                                       (int)compsDate.month,
                                       (int)compsDate.year];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [formatter setDateFormat:@"HHmm ddMMyyyy"];

        sunMoonVC.takeoffDate = [formatter dateFromString:timeString];
        
    }



}


@end
