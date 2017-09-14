//
//  SunMoon.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/07.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "SunMoon.h"

@implementation SunMoon
{
    NSMutableArray<SunMoonPointComponents *> *planArray;
}

-(instancetype)initWithCourseArray:(NSArray<CoursePointComponents *> *)courseArray{
    self = [super init];
    
    if (self) {
        
        planArray = [NSMutableArray new];
        
        for (CoursePointComponents *courseComps in courseArray) {
            
            SunMoonPointComponents *sunMoonComps = [[SunMoonPointComponents alloc] init];
            
            sunMoonComps.CTM = courseComps.CTM;
            int CTMhour = (int)floor(sunMoonComps.CTM / 60.0);
            int CTMminute = (int)round(sunMoonComps.CTM - (60.0 * (double)CTMhour));
            
            sunMoonComps.CTMString = [NSString stringWithFormat:@"%02d%02d", CTMhour, CTMminute];
            sunMoonComps.time = 9999;
            sunMoonComps.timeString = @"";
            sunMoonComps.latString = [SunMoon convertLatToString:courseComps.lat];
            sunMoonComps.lat = courseComps.lat;
            sunMoonComps.lonString = [SunMoon convertLonToString:courseComps.lon];
            sunMoonComps.lon = courseComps.lon;
            sunMoonComps.WPT = courseComps.WPT;
            sunMoonComps.FLString = [NSString stringWithFormat:@"%d",(int)round(courseComps.FL)];
            sunMoonComps.FL = courseComps.FL;
            sunMoonComps.SunDIR = @"N/A";
            sunMoonComps.SunALT = @"N/A";
            sunMoonComps.SunSTATUS = @"N/A";
            sunMoonComps.MoonDIR = @"N/A";
            sunMoonComps.MoonALT = @"N/A";
            sunMoonComps.MoonSTATUS = @"N/A";
            
            [planArray addObject:[sunMoonComps copy]];
            
            sunMoonComps = [[SunMoonPointComponents alloc] init];

        }
        
    }
    
    return self;
}


+(NSArray<SunMoonPointComponents *> *)makeInitialSunMoonPlanArrayWithCourseArray:(NSArray<CoursePointComponents *> *)courseArray
                                                                     takeoffDate:(NSDate *)takeoffDate{
        
    SunMoon *obj = [[SunMoon alloc] initWithCourseArray:courseArray];
    
    return [obj makeSunMoonPlanArrayWithTakeOffDate:takeoffDate];
    
}

-(NSArray<SunMoonPointComponents *> *)makeSunMoonPlanArrayWithTakeOffDate:(NSDate *)takeOffDate{

    [SaveDataPackage savePresentDataWithSunMoonTakeoffDate:[TakeoffTimeData dataOfdate:takeOffDate]];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger flags;
    NSDateComponents *comps;
    
    flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute;
    
    if (!takeOffDate) {
        takeOffDate = [NSDate date];
    }
    
    comps = [calendar components:flags fromDate:takeOffDate];

    int year = (int)comps.year;
    int month = (int)comps.month;
    int day = (int)comps.day;
    int hour = (int)comps.hour;
    int minute = (int)comps.minute;
    
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
                                latitude:planArray[0].lat
                               longitude:planArray[0].lon
                                altitude:planArray[0].FL * 1000.0];
    
    NSMutableArray<SunMoonPointComponents *> *returnArray = [NSMutableArray new];
    
    double time = hour * 60 + minute;
    
    double oldCTM = 9999.9;
    
    for (SunMoonPointComponents *sunMoonComps in planArray) {
        
        if (oldCTM == sunMoonComps.CTM) {
            time--;
        }
        
        
        double hour = floor(time / 60.0);
        double minute = time - (double)hour * 60.0;
        [obj setHourd:hour];
        [obj setMinuted:minute];
        [obj setLat:sunMoonComps.lat];
        [obj setLon:sunMoonComps.lon];
        [obj setAlt:sunMoonComps.FL * 1000.0];
        
        double returnHour = floor(time / 60.0);
        double returnMinute = time - returnHour * 60.0;
        if (returnHour >= 24) {
            returnHour -= 24;
        }
        sunMoonComps.time = time;
        sunMoonComps.timeString = [NSString stringWithFormat:@"%02d%02d",(int)returnHour,(int)returnMinute];
        
        [obj calcSun];
        NSString *directionStr = [NSString stringWithFormat:@"%.1f",[obj directionDeg]];
        if (directionStr.length == 5) { //xxx.x
            sunMoonComps.SunDIR = directionStr;
        } else if (directionStr.length == 4) { //xx.x
            sunMoonComps.SunDIR = [NSString stringWithFormat:@"0%@",directionStr];
        } else { //x.x
            sunMoonComps.SunDIR = [NSString stringWithFormat:@"00%@",directionStr];
        }
        sunMoonComps.SunALT = [NSString stringWithFormat:@"%.1f",[obj heightDeg]];
        sunMoonComps.SunSTATUS = [NSString stringWithFormat:@"%@",[obj status]];

        [obj calcMoon];
        directionStr = [NSString stringWithFormat:@"%.1f",[obj directionDeg]];
        if (directionStr.length == 5) { //xxx.x
            sunMoonComps.MoonDIR = directionStr;
        } else if (directionStr.length == 4) { //xx.x
            sunMoonComps.MoonDIR = [NSString stringWithFormat:@"0%@",directionStr];
        } else { //x.x
            sunMoonComps.MoonDIR = [NSString stringWithFormat:@"00%@",directionStr];
        }
        sunMoonComps.MoonALT = [NSString stringWithFormat:@"%.1f",[obj heightDeg]];
        sunMoonComps.MoonSTATUS = [NSString stringWithFormat:@"%@",[obj status]];
        
        
        [returnArray addObject:[sunMoonComps copy]];
        time++;
        oldCTM = sunMoonComps.CTM;
    }
    
    return [returnArray copy];
    
}

+(double)moonPhaseWithDate:(NSDate *)date {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger flags;
    NSDateComponents *comps;
    
    flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute;
    
    if (!date) {
        date = [NSDate date];
    }

    
    comps = [calendar components:flags fromDate:date];
    
    int year = (int)comps.year;
    int month = (int)comps.month;
    int day = (int)comps.day;
    int hour = (int)comps.hour;
    int minute = (int)comps.minute;

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


+(NSString *)convertLatToString:(double)lat {
    NSMutableString *returnString = [NSMutableString new];
    
    double tmp = lat;
    
    if (tmp < 0) {
        [returnString appendString:@"S"];
        tmp = - tmp;
    } else {
        [returnString appendString:@"N"];
    }
    
    int tmp1 = (int)floor(tmp);
    int tmp2 = (int)round((tmp - tmp1) * 600);
    
    if (tmp2 == 600) {
        tmp2 = 0;
        tmp1++;
    }
    
    [returnString appendString:[NSString stringWithFormat:@"%02d",tmp1]];
    [returnString appendString:[NSString stringWithFormat:@"%03d",tmp2]];
    
    return [returnString copy];
    
    
}

+(NSString *)convertLonToString:(double)lon {
    NSMutableString *returnString = [NSMutableString new];
    
    double tmp = lon;
    
    if (tmp < 0) {
        [returnString appendString:@"W"];
        tmp = - tmp;
    } else {
        [returnString appendString:@"E"];
    }
    
    int tmp1 = (int)floor(tmp);
    int tmp2 = (int)round((tmp - tmp1) * 600);
    
    if (tmp2 == 600) {
        tmp2 = 0;
        tmp1++;
    }
    
    [returnString appendString:[NSString stringWithFormat:@"%03d",tmp1]];
    [returnString appendString:[NSString stringWithFormat:@"%03d",tmp2]];
    
    return [returnString copy];
    
}

+(NSString *)convertTimeToString:(int)time{
    
    int hour = time / 60;
    int minute = time - (hour * 60);
    
    return [NSString stringWithFormat:@"%02d%02d",hour,minute];
    
}



@end
