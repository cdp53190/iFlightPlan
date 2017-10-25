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

+(NSArray<CoursePointComponents *> *)makeCourseArrayWithPlanArray:(NSArray<NAVLOGLegComponents *> *)planArray {
    
    NSMutableArray<CoursePointComponents *> *returnArray = [NSMutableArray new];
    
    CoursePointComponents *pointComps = [[CoursePointComponents alloc] init];
    
    double oldLat = 9999;
    double oldLon = 9999;
    int oldCTM = 9999;
    double oldFL = 9999;

    int lastExactLevelPointNo = 0;
    double levelChangeStartFL = 0.0;//出発高度は0ftで計算する。データがあればそれをいれてもいい。
    int legNo = -1;
    int pointNo = -1;
    int topOfCruisePointNo = 0;
    BOOL flagDS = NO;
    
    
    for (NAVLOGLegComponents *legComps in planArray) {

        legNo++;
        
        double lat = [CourseCalc convertStringToLat:legComps.latString];
        double lon = [CourseCalc convertStringToLon:legComps.lonString];
        int CTM = [CourseCalc convertStringToTime:legComps.CTM];
        NSString *FLString = legComps.PFL;
        
        //1個目
        if (oldLat == 9999) {

            pointComps.CTM = 0;
            pointComps.lat = lat;
            pointComps.lon = lon;
            pointComps.WPT = legComps.waypoint;
            pointComps.FL = 0.0;
            pointComps.course = 0.0;
            pointComps.distance = 0.0;

            pointNo++;
            [returnArray addObject:[pointComps copy]];
            
            oldLat = lat;
            oldLon = lon;
            oldCTM = 0;
            oldFL = 0;
            
            continue;
            
        }
        
        if (CTM == oldCTM) { //0分レグ
            
            pointComps.CTM = CTM;
            pointComps.lat = lat;
            pointComps.lon = lon;
            pointComps.WPT = legComps.waypoint;
            pointComps.course = [CourseCalc calcCourseByDepLat:oldLat
                                                        DepLon:oldLon
                                                        ArrLat:lat
                                                        ArrLon:lon];
            pointComps.distance = [CourseCalc distanceByDepLat:oldLat
                                                        DepLon:oldLon
                                                        ArrLat:lat
                                                        ArrLon:lon];
            
            if ([FLString isEqualToString:@"CL"]) {
                pointComps.FL = oldFL;
            } else if ([FLString isEqualToString:@"DS"]) {
                pointComps.FL = oldFL;
            } else {
                
                //lastExactLevelPointNo = pointNo + 1;
                //levelChangeStartFL = FLString.doubleValue;
                pointComps.FL = FLString.doubleValue;
            }
            
            pointNo++;
            [returnArray addObject:[pointComps copy]];
            
            oldLat = lat;
            oldLon = lon;
            oldCTM = CTM;
            oldFL = pointComps.FL;
            
        } else {
            int portionTime =  CTM - oldCTM;
            
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
                
                NSArray *nextLatLonCourseArray = [CourseCalc calcNextLatLonWithSpeed:speed_NM
                                                                              depLat:oldLat
                                                                              depLon:oldLon
                                                                              course:course];
                
                int newCTM = oldCTM + time;
                
                lat = ((NSNumber *)nextLatLonCourseArray[0]).doubleValue;
                lon = ((NSNumber *)nextLatLonCourseArray[1]).doubleValue;
                
                pointComps.CTM = newCTM;
                pointComps.lat = lat;
                pointComps.lon = lon;
                pointComps.course = course;
                pointComps.distance = speed_NM;
                
                if (time == portionTime) {
                    pointComps.WPT = legComps.waypoint;
                    pointComps.FL = FLString.doubleValue;
                } else {
                    pointComps.WPT = @"";
                }
                
                if ([FLString isEqualToString:@"CL"]) {
                    pointComps.FL = oldFL;
                } else {
                    
                    if ([FLString isEqualToString:@"DS"]) {
                        flagDS = YES;
                        if (legNo == planArray.count - 1) {
                            pointComps.FL = 0.0;
                        } else {
                            pointComps.FL = oldFL;
                        }
                    } else {
                        pointComps.FL = FLString.doubleValue;
                    }
                    
                }
                
                
                pointNo++;
                [returnArray addObject:[pointComps copy]];
                
                oldLat = lat;
                oldLon = lon;
                course = ((NSNumber *)nextLatLonCourseArray[2]).doubleValue;
                
            }
            
            oldCTM = CTM;
            oldFL = pointComps.FL;
            
        }
        
        if (topOfCruisePointNo != 0 && ![FLString isEqualToString:@"CL"]) {//CLが終了したらそこまでのFLを計算
            
            double newFL = FLString.doubleValue;
            
            double calcdFL = newFL;
            
            int lastExactLevelPointCTM = returnArray[lastExactLevelPointNo].CTM;
            int topOfCruisePointCTM = returnArray[topOfCruisePointNo].CTM;
            
            NSMutableArray<NSNumber *> *FLArray = [NSMutableArray new];
            
            while (calcdFL >= levelChangeStartFL && calcdFL > levelChangeStartFL) {
                
                if (calcdFL > 30) {//30000以上は500fpm
                    calcdFL = calcdFL - 0.5;
                } else if (calcdFL > 10) {//10000以上は1000fpm
                    calcdFL = calcdFL - 1.0;
                } else { //10000以下は2000fpm
                    calcdFL = calcdFL - 2.0;
                }
                
                if (round(calcdFL) <= levelChangeStartFL) {
                    calcdFL = levelChangeStartFL;
                }
                
                [FLArray addObject:[NSNumber numberWithDouble:calcdFL]];
            }
            
            if ((int)FLArray.count > topOfCruisePointCTM - lastExactLevelPointCTM) {//この場合はリニア上昇とするので作り直し
                
                FLArray = [NSMutableArray new];
                newFL = FLString.doubleValue;
                calcdFL = newFL;
                
                double interval;
                if (topOfCruisePointCTM == lastExactLevelPointCTM) {
                    interval = 1.0;
                } else {
                    interval = (newFL - levelChangeStartFL) / (topOfCruisePointCTM - lastExactLevelPointCTM);
                }
                
                while (calcdFL >= levelChangeStartFL && calcdFL > levelChangeStartFL) {
                    calcdFL = calcdFL - interval;
                    
                    if (round(calcdFL) <= levelChangeStartFL) {
                        calcdFL = levelChangeStartFL;
                    }
                    
                    [FLArray addObject:[NSNumber numberWithDouble:calcdFL]];
                    
                }
                
            } else {//この場合はwpt間での上昇開始なのでlastExactLevelPointをリセット
                lastExactLevelPointCTM = topOfCruisePointCTM - (int)FLArray.count;
                
            }
            
            [FLArray insertObject:[NSNumber numberWithDouble:newFL] atIndex:0];
            NSArray<NSNumber *> *finalFLArray = [[FLArray reverseObjectEnumerator]allObjects];
            
            CoursePointComponents *newLegComps = returnArray[topOfCruisePointNo];
            
            while (newLegComps.CTM >= lastExactLevelPointCTM) {
                
                newLegComps.FL = finalFLArray[newLegComps.CTM - lastExactLevelPointCTM].doubleValue;
                
                returnArray[topOfCruisePointNo] = [newLegComps copy];
                
                topOfCruisePointNo--;
                if (topOfCruisePointNo < 0) {
                    newLegComps.CTM = -1;
                } else {
                    newLegComps = returnArray[topOfCruisePointNo];
                }
            }
            
            topOfCruisePointNo = 0;
            oldFL = newFL;
        }
    
        //DSは基本的にT/Dから次の高度が明確なポイントまでリニアに。
        //それが1000fpmより浅くなるなら1000fpmで次の高度まで。
        if ((flagDS && ![FLString isEqualToString:@"DS"]) || legNo == planArray.count - 1) {
            
            
            double newFL;
            if (legNo == planArray.count - 1) {
                newFL = 0.0;
            } else {
                newFL = FLString.doubleValue;
                
            }
            
            int lastExactLevelPointCTM = returnArray[lastExactLevelPointNo].CTM;
            
            double interval;
            if (CTM == lastExactLevelPointCTM) {//0分でLevelChangeということもあったので。
                interval = 1.0;
            } else {
                interval = (levelChangeStartFL - newFL) / (CTM - lastExactLevelPointCTM);
            }
            
            if (interval < 1.0) {
                interval = 1.0;
            }
            
            int tempPointNo = pointNo;
            
            CoursePointComponents *newLegComps = returnArray[tempPointNo];
            
            while (tempPointNo >= lastExactLevelPointNo) {
                
                int interValtime = newLegComps.CTM - lastExactLevelPointCTM;
                newLegComps.FL = levelChangeStartFL - interval * (double)interValtime;
                if (newLegComps.FL < newFL) {
                    newLegComps.FL = newFL;
                }
                
                returnArray[tempPointNo] = [newLegComps copy];
                
                tempPointNo--;
                newLegComps = returnArray[tempPointNo];
            }
            
            levelChangeStartFL = newFL;
            topOfCruisePointNo = 0;
            oldFL = newFL;
            
            flagDS = NO;
            
        }

        if (![FLString isEqualToString:@"CL"] && ![FLString isEqualToString:@"DS"]) {
            lastExactLevelPointNo = pointNo;
            levelChangeStartFL = FLString.doubleValue;
        }


        if ([legComps.waypoint isEqualToString:@"(T/C)"]) {
            topOfCruisePointNo = pointNo;
        } else if ([legComps.waypoint isEqualToString:@"(T/D)"]) {
            flagDS = YES;
            lastExactLevelPointNo = pointNo;
        }

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
    
    if ([string isEqualToString:@""]) {
        return 0;
    }

    
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
    
    if ([string isEqualToString:@""]) {
        return 0;
    }
    
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


+(int)convertStringToTime:(NSString *)string{
    
    int returnInt = 0;
    
    returnInt += [string substringToIndex:2].intValue * 60;
    returnInt += [string substringFromIndex:2].intValue;
    
    return returnInt;
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
