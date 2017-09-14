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
#import "SaveDataPackage.h"

@interface SunMoon : NSObject

-(instancetype)initWithCourseArray:(NSArray<CoursePointComponents *> *)courseArray;

+(NSArray<SunMoonPointComponents *> *)makeInitialSunMoonPlanArrayWithCourseArray:(NSArray<CoursePointComponents *> *)courseArray
                                                                     takeoffDate:(NSDate *)takeoffDate;

-(NSArray<SunMoonPointComponents *> *)makeSunMoonPlanArrayWithTakeOffDate:(NSDate *)takeoffDate;

+(double)moonPhaseWithDate:(NSDate *)date;



@end
