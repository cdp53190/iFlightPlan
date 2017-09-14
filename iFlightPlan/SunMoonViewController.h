//
//  SunMoonViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/03/25.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "PlanViewController.h"
#import "SunMoon.h"


@interface SunMoonViewController : PlanViewController


@property (weak, nonatomic) IBOutlet UILabel *moonPhaseLabel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *takeoffTimeBtn;

@property (weak, nonatomic) NSDate *takeoffDate;

@end
