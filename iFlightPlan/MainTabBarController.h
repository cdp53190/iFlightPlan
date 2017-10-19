//
//  MainTabBarController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/03.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanViewController.h"
#import "SunMoonViewController.h"
#import "ProgressViewController.h"

@interface MainTabBarController : UITabBarController

-(void)loadPlan;

@end
