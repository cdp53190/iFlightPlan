//
//  SunMoon.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/07.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "SunMoon.h"

@implementation SunMoon


+(NSArray *)makeInitialSunMoonPlanArray {
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSArray *courseArray = [ud objectForKey:@"courseArray"];

    NSMutableArray *returnArray = [NSMutableArray new];
    
    for (NSDictionary *dic in courseArray) {
        NSMutableDictionary *returnDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        returnDic[@"SunDIR"] = @"";
        returnDic[@"SunALT"] = @"";
        returnDic[@"SunSTATUS"] = @"";
        returnDic[@"MoonDIR"] = @"";
        returnDic[@"MoonALT"] = @"";
        returnDic[@"MoonSTATUS"] = @"";
        
        [returnArray addObject:returnDic];        
    }
    
    
    return [returnArray copy];
    
}

+(NSArray *)makeSunMoonPlanArrayWithTakeOffYear:(int)year
                                          month:(int)month
                                            day:(int)day
                                           hour:(int)hour
                                         minute:(int)minute {
    
    NSArray *planArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"sunMoonPlanArray"];
    
    Class classname;
    id obj;
    
    if ([SunMoonCalc2Data existDataOfYear:year]) {
        classname = NSClassFromString(@"SunMoonCalc2");
    } else {
        classname = NSClassFromString(@"SunMoonCalc");
    }

    //classname = NSClassFromString(@"SunMoonCalc");

    
    obj = [[classname alloc]initWithYear:year
                                   month:month
                                     day:day
                                    hour:hour
                                  minute:minute
                                latitude:((NSNumber *)planArray[0][@"lat"]).doubleValue
                               longitude:((NSNumber *)planArray[0][@"lon"]).doubleValue
                                altitude:0];
    
    NSMutableArray *returnArray = [NSMutableArray new];
    
    int time = hour * 60 + minute;
    
    for (NSDictionary *dic in planArray) {
        double hour = floor(time / 60.0);
        double minute = time - (int)hour * 60;
        [obj setHourd:(double)hour];
        [obj setMinuted:(double)minute];
        [obj setLat:((NSNumber *)dic[@"lat"]).doubleValue];
        [obj setLon:((NSNumber *)dic[@"lon"]).doubleValue];
        [obj setAlt:((NSNumber *)dic[@"FL"]).doubleValue * 100.0];
        
        NSMutableDictionary *returnDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        int returnHour = (int)floor(time / 60.0);
        int returnMinute = time - returnHour * 60;
        if (returnHour >= 24) {
            returnHour -= 24;
        }
        returnDic[@"TIME"] = [NSNumber numberWithInt:time];
        returnDic[@"TIMEString"] = [NSString stringWithFormat:@"%02d%02d",returnHour,returnMinute];
        
        [obj calcSun];
        returnDic[@"SunDIR"] = [NSString stringWithFormat:@"%.1f",[obj directionDeg]];
        returnDic[@"SunALT"] = [NSString stringWithFormat:@"%.1f",[obj heightDeg]];
        returnDic[@"SunSTATUS"] = [NSString stringWithFormat:@"%@",[obj status]];

        [obj calcMoon];
        returnDic[@"MoonDIR"] = [NSString stringWithFormat:@"%.1f",[obj directionDeg]];
        returnDic[@"MoonALT"] = [NSString stringWithFormat:@"%.1f",[obj heightDeg]];
        returnDic[@"MoonSTATUS"] = [NSString stringWithFormat:@"%@",[obj status]];
        
        [returnArray addObject:returnDic];
        time++;
    }
    
    return [returnArray copy];
    
}

@end
