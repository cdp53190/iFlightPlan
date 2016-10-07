//
//  CourseCalc.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/05.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "CourseCalc.h"

@implementation CourseCalc

static double sind(double d) {return sin(d * M_PI/180);}
static double cosd(double d) {return cos(d * M_PI/180);}
static double tand(double d) {return tan(d * M_PI/180);}
static double asind(double x) {return asin(x) * 180 / M_PI;}
static double acosd(double x) {return acos(x) * 180 / M_PI;}
static double atand(double x) {return atan(x) * 180 / M_PI;}

+(NSArray *)makeCourseArray {
    
    NSMutableArray *returnArray = [NSMutableArray array];
 
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSArray *planArray = [ud objectForKey:@"planArray"];
    
    double oldLat = 9999;
    double oldLon = 9999;
    double oldCTM = 9999;
    double oldFL = 9999;
    
    for (NSDictionary *dic in planArray) {
        
        
        double lat = [CourseCalc convertStringToLat:dic[@"lat"]];
        double lon = [CourseCalc convertStringToLon:dic[@"lon"]];
        int CTM = [CourseCalc convertStringToTime:dic[@"CTM"]];
        NSString *FLString = dic[@"PFL"];
        
        if (oldLat == 9999) {

            NSMutableDictionary *returnDic = [NSMutableDictionary new];

            returnDic[@"CTM"] = [NSNumber numberWithInt:0];
            returnDic[@"CTMString"] = @"0000";
            returnDic[@"TIME"] = [NSNumber numberWithInt:0];
            returnDic[@"TIMEString"] = @"";
            returnDic[@"lat"] = [NSNumber numberWithDouble:lat];
            returnDic[@"latString"] = [CourseCalc convertLatToString:lat];
            returnDic[@"lon"] = [NSNumber numberWithDouble:lon];
            returnDic[@"lonString"] = [CourseCalc convertLonToString:lon];
            returnDic[@"WPT"] = dic[@"waypoint"];
            returnDic[@"FL"] = [NSNumber numberWithDouble:0.0];
            returnDic[@"FLString"] = @"000";
            oldLat = lat;
            oldLon = lon;
            oldCTM = 0;
            oldFL = 0;
            [returnArray addObject:[returnDic copy]];
            
            continue;
        }

        int portionTime =  CTM - oldCTM;
        
        if (portionTime == 0) {

            NSMutableDictionary *returnDic = [NSMutableDictionary new];
            
            returnDic[@"CTM"] = [NSNumber numberWithInt:CTM];
            returnDic[@"CTMString"] = [CourseCalc convertTimeToString:CTM];
            returnDic[@"TIME"] = [NSNumber numberWithInt:0];
            returnDic[@"TIMEString"] = @"";
            returnDic[@"lat"] = [NSNumber numberWithDouble:lat];
            returnDic[@"latString"] = [CourseCalc convertLatToString:lat];
            returnDic[@"lon"] = [NSNumber numberWithDouble:lon];
            returnDic[@"lonString"] = [CourseCalc convertLonToString:lon];
            returnDic[@"WPT"] = dic[@"waypoint"];
            if ([FLString isEqualToString:@"CL"]||[FLString isEqualToString:@"DS"]) {
                returnDic[@"FL"] = [NSNumber numberWithDouble:oldFL];
                returnDic[@"FLString"] = [NSString stringWithFormat:@"%03d",(int)round(oldFL)];
            } else {
                returnDic[@"FL"] = [NSNumber numberWithDouble:oldFL];
                returnDic[@"FLString"] = [NSString stringWithFormat:@"%@0",FLString];
            }
            oldLat = lat;
            oldLon = lon;
            oldCTM = oldCTM;
            oldFL = oldFL;
            
            [returnArray addObject:[returnDic copy]];
            
            continue;
        }
        
        double portionDist = [CourseCalc distanceByDepLat:oldLat
                                                   DepLon:oldLon
                                                   ArrLat:lat
                                                   ArrLon:lon];
        
        double course = [CourseCalc calcCourseByDepLat:oldLat
                                                DepLon:oldLon
                                                ArrLat:lat
                                                ArrLon:lon];

        double speed_NM = portionDist / portionTime;
        
        for (int time = 1; time <= portionTime; time++) {

            NSMutableDictionary *returnDic = [NSMutableDictionary new];
            
            NSArray *nextLatLonCourseArray = [CourseCalc calcNextLatLonWithSpeed:speed_NM
                                                                          depLat:oldLat
                                                                          depLon:oldLon
                                                                          course:course];
            
            int newCTM = oldCTM + time;
            
            lat = ((NSNumber *)nextLatLonCourseArray[0]).doubleValue;
            lon = ((NSNumber *)nextLatLonCourseArray[1]).doubleValue;
            
            returnDic[@"CTM"] = [NSNumber numberWithInt:newCTM];
            returnDic[@"CTMString"] = [CourseCalc convertTimeToString:newCTM];
            returnDic[@"TIME"] = [NSNumber numberWithInt:0];
            returnDic[@"TIMEString"] = @"";
            returnDic[@"lat"] = [NSNumber numberWithDouble:lat];
            returnDic[@"latString"] = [CourseCalc convertLatToString:lat];
            returnDic[@"lon"] = [NSNumber numberWithDouble:lon];
            returnDic[@"lonString"] = [CourseCalc convertLonToString:lon];
            if (time == portionTime) {
                returnDic[@"WPT"] = dic[@"waypoint"];
            } else {
                returnDic[@"WPT"] = @"";
            }
            if ([FLString isEqualToString:@"CL"]) {
                returnDic[@"FL"] = [NSNumber numberWithDouble:oldFL];
                returnDic[@"FLString"] = [NSString stringWithFormat:@"%03d",(int)round(oldFL)];
            } else if([FLString isEqualToString:@"DS"]){
                returnDic[@"FL"] = [NSNumber numberWithDouble:oldFL];
                returnDic[@"FLString"] = [NSString stringWithFormat:@"%03d",(int)round(oldFL)];
            } else {
                returnDic[@"FL"] = [NSNumber numberWithDouble:oldFL];
                returnDic[@"FLString"] = [NSString stringWithFormat:@"%@0",FLString];
            }
            oldLat = lat;
            oldLon = lon;
            course = ((NSNumber *)nextLatLonCourseArray[2]).doubleValue;
            
            [returnArray addObject:[returnDic copy]];
        }
        
        oldCTM = CTM;
        oldFL = oldFL;

        
    }
    
    
    return [returnArray copy];


    
    
}


// set latlon as 23.232323 (N or E = plus, S or W = minus)
+(double)distanceByDepLat:(double)depLat
                   DepLon:(double)depLon
                   ArrLat:(double)arrLat
                   ArrLon:(double)arrLon {
    
    return acosd(sind(depLat) * sind(arrLat) +
                 cosd(depLat) * cosd(arrLat) *
                 cosd(arrLon - depLon)) * 60;
    
    
}

+(double)calcCourseByDepLat:(double)depLat
                     DepLon:(double)depLon
                     ArrLat:(double)arrLat
                     ArrLon:(double)arrLon {
    
    double answer;
    
    if (arrLon == depLon) {
        if (depLat > arrLat) {
            answer = 180;
        } else {
            answer = 0;
        }
    } else if (arrLon - depLon == 180 || arrLon - depLon == -180) {
        if (depLat + arrLat >= 0) {
            answer = 0;
        } else {
            answer = 180;
        }
    } else if (depLat == 0 && arrLat == 0){
        
        if (arrLon > depLon) {
            answer = 90;
        } else {
            answer = 270;
        }
        
    } else {
        
        answer = atand(cosd((depLat - arrLat)/2) /
                       tand((arrLon - depLon)/2) /
                       sind((depLat + arrLat)/2)) +
        atand(sind((depLat - arrLat)/2) /
              tand((arrLon - depLon)/2) /
              cosd((depLat + arrLat)/2));
        
        if (depLat + arrLat < 0) {
            answer += 180;
        }
        
        
        
    }
    
    while (answer < 0) {
        answer += 360;
    }
    
    while (answer >=360) {
        answer -= 360;
    }
    
    return answer;
    
    
}

// @"Nxxxxx"->xx.xxxxxx
+(double)convertStringToLat:(NSString *)string{
    
    double returnValue = 0;
    
    returnValue += [string substringWithRange:NSMakeRange(1, 2)].doubleValue;
    returnValue += [string substringWithRange:NSMakeRange(3, 2)].doubleValue / 60;
    returnValue += [string substringWithRange:NSMakeRange(5, 1)].doubleValue / 600;
    
    if ([string hasPrefix:@"N"]) {
        return returnValue;
    } else if([string hasPrefix:@"S"]){
        return -returnValue;
    }
    
    return 0;
    
}

+(double)convertStringToLon:(NSString *)string{
    
    double returnValue = 0;
    
    returnValue += [string substringWithRange:NSMakeRange(1, 3)].doubleValue;
    returnValue += [string substringWithRange:NSMakeRange(4, 2)].doubleValue / 60;
    returnValue += [string substringWithRange:NSMakeRange(6, 1)].doubleValue / 600;
    
    if ([string hasPrefix:@"E"]) {
        return returnValue;
    } else if([string hasPrefix:@"W"]){
        return -returnValue;
    }
    
    return 0;
    
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

+(int)convertStringToTime:(NSString *)string{
    
    int returnInt = 0;
    
    returnInt += [string substringToIndex:2].intValue * 60;
    returnInt += [string substringFromIndex:2].intValue;
    
    return returnInt;
}

+(NSString *)convertTimeToString:(int)time{
    
    int hour = time / 60;
    int minute = time - (hour * 60);
    
    return [NSString stringWithFormat:@"%02d%02d",hour,minute];
    
}

+(NSArray *)calcNextLatLonWithSpeed:(double)speed
                             depLat:(double)lat
                             depLon:(double)lon
                             course:(double)Course_Degrees {
    
    double newLat, newLon, newCourse;
    
    newLat = asind(sind(speed/60) *
                   cosd(lat) *
                   cosd(Course_Degrees) +
                   cosd(speed/60) *
                   sind(lat));
    
    if (cosd(speed/60) - sind(lat) * sind(newLat) == 0) {
        
        if (Course_Degrees >0 && Course_Degrees < 180) {
            newLon = lon + 90;
        } else {
            newLon = lon + 270;
        }
        
    } else {
        newLon = lon + atand(sind(speed/60) *
                             sind(Course_Degrees) *
                             cosd(lat) /
                             (cosd(speed/60) -
                              sind(lat) *
                              sind(newLat)));
        
    }
    
    
    if (cosd(speed/60) < sind(lat) * sind(newLat)) {
        newLon += 180;
    }
    
    while (newLon <= -180) {
        newLon += 360;
    }
    
    while (newLon > 180) {
        newLon -= 360;
    }
    
    
    
    newCourse = 180 - atand(cosd((lat - newLat)/2) /
                            tand((newLon - lon)/2) /
                            sind((lat + newLat)/2)) +
    atand(sind((lat- newLat)/2) /
          tand((newLon - lon)/2) /
          cosd((lat + newLat)/2));
    
    if (lat + newLat < 0) {
        newCourse += 180;
    }
    
    
    return @[[NSNumber numberWithDouble:newLat],
             [NSNumber numberWithDouble:newLon],
             [NSNumber numberWithDouble:newCourse]];
}


@end
