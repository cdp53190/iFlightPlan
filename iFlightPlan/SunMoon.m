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
    [ud setObject:[ud objectForKey:@"courseArray"] forKey:@"sunMoonPlanArray"];
    [ud synchronize];
    
    NSMutableString *timeString = [[ud objectForKey:@"dataDic"][@"IssueTime"] mutableCopy];
    
    [timeString insertString:@"20" atIndex:11];
    [timeString deleteCharactersInRange:NSMakeRange(2, 1)];//HHmm ddMMMyyyy
    
    NSString *STDString = [ud objectForKey:@"dataDic"][@"STD"];
    
    NSTimeInterval timeInterval = 0.0;
    if ([STDString intValue] < [timeString intValue]) {
        timeInterval = 60.0 * 60.0 * 24.0;
    }
    
    [timeString replaceCharactersInRange:NSMakeRange(0, 4) withString:STDString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setDateFormat:@"HHmm ddMMMyyyy"];
    
    NSDate *issueTimeDate = [formatter dateFromString:timeString];
    
    NSDate *takeOffDate =  [NSDate dateWithTimeInterval:timeInterval + 60.0 * 20.0 sinceDate:issueTimeDate];//STD+20分=T/O
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger flags;
    NSDateComponents *comps;
    
    flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute;
    
    comps = [calendar components:flags fromDate:takeOffDate];
    
    [ud setObject:[NSNumber numberWithInt:(int)comps.year] forKey:@"sunMoonTakeoffYear"];
    [ud setObject:[NSNumber numberWithInt:(int)comps.month] forKey:@"sunMoonTakeoffMonth"];
    [ud setObject:[NSNumber numberWithInt:(int)comps.day] forKey:@"sunMoonTakeoffDay"];
    [ud setObject:[NSNumber numberWithInt:(int)comps.hour] forKey:@"sunMoonTakeoffHour"];
    [ud setObject:[NSNumber numberWithInt:(int)comps.minute] forKey:@"sunMoonTakeoffMinute"];
    [ud setObject:[NSNumber numberWithDouble:-1.0] forKey:@"moonPhase"];
    [ud synchronize];

    return [SunMoon makeSunMoonPlanArrayWithTakeOffYear:(int)comps.year
                                                  month:(int)comps.month
                                                    day:(int)comps.day
                                                   hour:(int)comps.hour
                                                 minute:(int)comps.minute];
    
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
    
    obj = [[classname alloc]initWithYear:year
                                   month:month
                                     day:day
                                    hour:hour
                                  minute:minute
                                latitude:((NSNumber *)planArray[0][@"lat"]).doubleValue
                               longitude:((NSNumber *)planArray[0][@"lon"]).doubleValue
                                altitude:0.0];
    
    NSMutableArray *returnArray = [NSMutableArray new];
    
    double time = hour * 60 + minute;
    
    NSNumber *oldCTM = @9999.9;
    
    for (NSDictionary *dic in planArray) {
        
        if (oldCTM == dic[@"CTM"]) {
            time--;
        }
        
        
        double hour = floor(time / 60.0);
        double minute = time - (double)hour * 60.0;
        [obj setHourd:hour];
        [obj setMinuted:minute];
        [obj setLat:((NSNumber *)dic[@"lat"]).doubleValue];
        [obj setLon:((NSNumber *)dic[@"lon"]).doubleValue];
        [obj setAlt:((NSNumber *)dic[@"FL"]).doubleValue * 1000.0];

        NSMutableDictionary *returnDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        double returnHour = floor(time / 60.0);
        double returnMinute = time - returnHour * 60.0;
        if (returnHour >= 24) {
            returnHour -= 24;
        }
        returnDic[@"TIME"] = [NSNumber numberWithInt:(int)time];
        returnDic[@"TIMEString"] = [NSString stringWithFormat:@"%02d%02d",(int)returnHour,(int)returnMinute];
        
        [obj calcSun];
        NSString *directionStr = [NSString stringWithFormat:@"%.1f",[obj directionDeg]];
        if (directionStr.length == 5) { //xxx.x
            returnDic[@"SunDIR"] = directionStr;
        } else if (directionStr.length == 4) { //xx.x
            returnDic[@"SunDIR"] = [NSString stringWithFormat:@"0%@",directionStr];
        } else { //x.x
            returnDic[@"SunDIR"] = [NSString stringWithFormat:@"00%@",directionStr];
        }
        returnDic[@"SunALT"] = [NSString stringWithFormat:@"%.1f",[obj heightDeg]];
        returnDic[@"SunSTATUS"] = [NSString stringWithFormat:@"%@",[obj status]];

        [obj calcMoon];
        directionStr = [NSString stringWithFormat:@"%.1f",[obj directionDeg]];
        if (directionStr.length == 5) { //xxx.x
            returnDic[@"MoonDIR"] = directionStr;
        } else if (directionStr.length == 4) { //xx.x
            returnDic[@"MoonDIR"] = [NSString stringWithFormat:@"0%@",directionStr];
        } else { //x.x
            returnDic[@"MoonDIR"] = [NSString stringWithFormat:@"00%@",directionStr];
        }
        returnDic[@"MoonALT"] = [NSString stringWithFormat:@"%.1f",[obj heightDeg]];
        returnDic[@"MoonSTATUS"] = [NSString stringWithFormat:@"%@",[obj status]];
        
        
        [returnArray addObject:returnDic];
        time++;
        oldCTM = dic[@"CTM"];
    }
    
    return [returnArray copy];
    
}

+(double)moonPhaseWithYear:(int)year
                     month:(int)month
                       day:(int)day
                      hour:(int)hour
                    minute:(int)minute{
    
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
                                latitude:0.0
                               longitude:0.0
                                altitude:0];

    
    return [obj moonPhase];
    
}

@end
