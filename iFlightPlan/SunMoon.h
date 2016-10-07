//
//  SunMoon.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/07.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SunMoonCalc.h"
#import "SunMoonCalc2.h"
#import "SunMoonCalc2Data.h"

@interface SunMoon : NSObject


+(NSArray *)makeInitialSunMoonPlanArray;

+(NSArray *)makeSunMoonPlanArrayWithTakeOffYear:(int)year
                                          month:(int)month
                                            day:(int)day
                                           hour:(int)hour
                                         minute:(int)minute;

@end
