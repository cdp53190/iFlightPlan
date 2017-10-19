//
//  LandmarkPass.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/21.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "LandmarkPass.h"

static double sind(double d) {return sin(d * M_PI/180);}
static double cosd(double d) {return cos(d * M_PI/180);}
static double tand(double d) {return tan(d * M_PI/180);}
static double asind(double x) {return asin(x) * 180 / M_PI;}
static double acosd(double x) {return acos(x) * 180 / M_PI;}
static double atand(double x) {return atan(x) * 180 / M_PI;}

@implementation LandmarkPass
{
    NSArray<CoursePointComponents *> *courseDataArray;
    NSMutableArray<LandmarkPointData *> *landmarkPointArray;
    NSMutableArray<LandmarkLineData *> *landmarkLineArray;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        
        courseDataArray = @[];
        
        landmarkLineArray = [NSMutableArray new];
        landmarkPointArray = [NSMutableArray new];
        
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        landmarkPointArray = [ud objectForKey:@"landmarkPointArray"];
//        landmarkLineArray = [ud objectForKey:@"landmarkLineArray"];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LandmarkLine" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if ([NSJSONSerialization isValidJSONObject:data]){
            return self;
        }
        NSArray *landmarkLineTempArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        path = [[NSBundle mainBundle] pathForResource:@"LandmarkPoint" ofType:@"json"];
        data = [NSData dataWithContentsOfFile:path];
        NSArray *landmarkPointTempArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        [landmarkLineTempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            LandmarkLineData *line = [[LandmarkLineData alloc] init];
            line.name = obj[@"name"];
            NSArray *latlonArray = obj[@"latlonArray"];
            NSMutableArray *returnlatlonArray = [NSMutableArray new];
            [latlonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [returnlatlonArray addObject:@[[NSNumber numberWithDouble:((NSString *)obj[0]).doubleValue],
                                               [NSNumber numberWithDouble:((NSString *)obj[1]).doubleValue]]];
            }];
            line.latlon = returnlatlonArray.copy;
            

            [landmarkLineArray addObject:line.copy];
        }];
        
        
        [landmarkPointTempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            LandmarkPointData *point = [[LandmarkPointData alloc] init];
            point.name = obj[@"name"];
            point.lat = obj[@"lat"];
            point.lon = obj[@"lon"];
            point.detectDistance = obj[@"detectDistance"];
            
            [landmarkPointArray addObject:point.copy];
                        
        }];
        
        
        
    }
    
    return self;
}

-(NSArray<LandmarkPassData *> *)landmarkPassByCourseArray:(NSArray<CoursePointComponents *> *)courseArray {
    
    courseDataArray = courseArray;
    
    NSMutableArray *returnArray = [NSMutableArray new];
    
    NSMutableArray<NSNumber *> *pointRemainDist = [NSMutableArray new];
    NSMutableArray<NSNumber *> *pointRealRemainDist = [NSMutableArray new];
    NSMutableArray<NSNumber *> *pointExistAbeam = [NSMutableArray new];
    
    NSMutableArray<NSMutableArray<NSNumber *> *> *lineRemainDist = [NSMutableArray new];
    NSMutableArray<NSNumber *> *lineExistCross = [NSMutableArray new];
    NSMutableArray<NSMutableArray<NSNumber *> *> *startToEndAndPointSin = [NSMutableArray new];

    [courseDataArray enumerateObjectsUsingBlock:^(CoursePointComponents * _Nonnull comps, NSUInteger idxComps, BOOL * _Nonnull stop) {
        
        if (idxComps <= 12) {
            return;
        }
        
        if (idxComps >= courseDataArray.count - 12) {
            return;
        }
        
        [landmarkPointArray enumerateObjectsUsingBlock:^(LandmarkPointData * _Nonnull pointData, NSUInteger idxData, BOOL * _Nonnull stop) {
            
            if (idxComps == 13) {
                pointRemainDist[idxData] = [NSNumber numberWithDouble:[LandmarkPass distanceByDepLat:comps.lat
                                                                                         DepLon:comps.lon
                                                                                         ArrLat:pointData.lat.doubleValue
                                                                                         ArrLon:pointData.lon.doubleValue]];
                
                
                
                pointRealRemainDist[idxData] = @YES;
                pointExistAbeam[idxData] = @NO;
                return;
            }
            
            if ([pointExistAbeam[idxData] boolValue]) {
                return;
            }
            
            if (pointRemainDist[idxData].doubleValue - comps.distance <= pointData.detectDistance.doubleValue + 20.0) {//20マイルバッファ
                
                double newRemainDist = [LandmarkPass distanceByDepLat:comps.lat
                                                               DepLon:comps.lon
                                                               ArrLat:pointData.lat.doubleValue
                                                               ArrLon:pointData.lon.doubleValue];
                

                if (newRemainDist > pointRemainDist[idxData].doubleValue && pointRealRemainDist[idxData].boolValue) {
                    
                    
                    if (newRemainDist <= pointData.detectDistance.doubleValue) {
                        
                        if (idxComps != 14) {
                            LandmarkPassData *returnPointPass = [[LandmarkPassData alloc] init];
                            
                            returnPointPass.name = pointData.name;
                            returnPointPass.CTM = comps.CTM - 1;
                            
                            if (pointRemainDist[idxData].doubleValue == 0.0) {
                                returnPointPass.direction = @"";
                            } else {
                                double direction = [LandmarkPass calcCourseByDepLat:comps.lat
                                                                             DepLon:comps.lon
                                                                             ArrLat:pointData.lat.doubleValue
                                                                             ArrLon:pointData.lon.doubleValue];
                                

                                if (sind(direction - comps.course) >= 0) {
                                    returnPointPass.direction = @"R";
                                } else {
                                    returnPointPass.direction = @"L";
                                }
                            }
                            
                            returnPointPass.distance = pointRemainDist[idxData].doubleValue;
                            
                            [returnArray addObject:returnPointPass.copy];
                        }


                    }

                    
                    pointExistAbeam[idxData] = @YES;
                    
                    return;
                } else {
                    pointRemainDist[idxData] = [NSNumber numberWithDouble:newRemainDist];
                    pointRealRemainDist[idxData] = @YES;
                }
                
            } else {
                
                pointRemainDist[idxData] = [NSNumber numberWithDouble:pointRemainDist[idxData].doubleValue - comps.distance];
                pointRealRemainDist[idxData] = @NO;
            }
            
            
        }];
        
        [landmarkLineArray enumerateObjectsUsingBlock:^(LandmarkLineData * _Nonnull lineData, NSUInteger idxData, BOOL * _Nonnull stop) {
            if (idxComps == 13) {
                
                lineExistCross[idxData] = @NO;
                lineRemainDist[idxData] = [NSMutableArray new];
                startToEndAndPointSin[idxData] = [NSMutableArray new];
                
                NSInteger lineDataCount = lineData.latlon.count;
                
                for (int i = 0; i <= lineDataCount - 2; i++) {
                    
                    if ([lineExistCross[idxData] boolValue]) {
                        return ;
                    }
                    
                    double startLat = ((NSNumber *)lineData.latlon[i][0]).doubleValue;
                    double startLon = ((NSNumber *)lineData.latlon[i][1]).doubleValue;
                    
                    double endLat = ((NSNumber *)lineData.latlon[i+1][0]).doubleValue;
                    double endLon = ((NSNumber *)lineData.latlon[i+1][1]).doubleValue;
                    
                    double distanceToLine = [[self class] distanceFromLat:comps.lat
                                                                      Lon:comps.lon
                                                             ToLineDepLat:startLat
                                                                   DepLon:startLon
                                                                   ArrLat:endLat
                                                                   ArrLon:endLon];
                    
                    
                    

                    if (distanceToLine < 20.0) {//バッファ20NM
                        
                        double distanceStartToPoint = [[self class] distanceByDepLat:startLat
                                                                              DepLon:startLon
                                                                              ArrLat:comps.lat
                                                                              ArrLon:comps.lon];
                        
                        
                        if (distanceStartToPoint == 0) {
                            
                            LandmarkPassData *returnLinePass = [[LandmarkPassData alloc] init];
                            
                            returnLinePass.name = lineData.name;
                            returnLinePass.CTM = comps.CTM;
                            returnLinePass.direction = @"";
                            returnLinePass.distance = 0.0;
                            
                            [returnArray addObject:returnLinePass.copy];
                            
                            lineRemainDist[idxData][i] = @0;
                            startToEndAndPointSin[idxData][i] = @9999.9;
                            
                            lineExistCross[idxData] = @YES;
                            
                            return;

                        }

                        
                        double distanceStartToEnd = [[self class] distanceByDepLat:startLat
                                                                            DepLon:startLon
                                                                            ArrLat:endLat
                                                                            ArrLon:endLon];
                        

                        double courseStartToPoint = [[self class] calcCourseByDepLat:startLat
                                                                              DepLon:startLon
                                                                              ArrLat:comps.lat
                                                                              ArrLon:comps.lon];
                        

                        double courseStartToEnd = [[self class] calcCourseByDepLat:startLat
                                                                            DepLon:startLon
                                                                            ArrLat:endLat
                                                                            ArrLon:endLon];
                        

                        
                        if (cosd(courseStartToEnd - courseStartToPoint) < 0) {//startより前
                            lineRemainDist[idxData][i] = [NSNumber numberWithDouble:distanceStartToPoint];
                            startToEndAndPointSin[idxData][i] = @9999.9;
                            lineExistCross[idxData] = @NO;
                        } else if (distanceStartToPoint > distanceStartToEnd) {//endより後ろ
                            lineRemainDist[idxData][i] = [NSNumber numberWithDouble:distanceStartToPoint - distanceStartToEnd];
                            startToEndAndPointSin[idxData][i] = @9999.9;
                            lineExistCross[idxData] = @NO;
                        } else {//startとendの間
                            lineRemainDist[idxData][i] = [NSNumber numberWithDouble:distanceToLine];
                            startToEndAndPointSin[idxData][i] = [NSNumber numberWithDouble:sind(courseStartToEnd - courseStartToPoint)];
                            lineExistCross[idxData] = @NO;
                        }
                        
                    } else {
                        lineRemainDist[idxData][i] = [NSNumber numberWithDouble:distanceToLine];
                        startToEndAndPointSin[idxData][i] = @9999.9;
                        lineExistCross[idxData] = @NO;

                    }

                }
                
                return;
            }
            
            if ([lineExistCross[idxData] boolValue]) {
                return;
            }
            
            
            NSInteger lineDataCount = lineData.latlon.count;
            
            for (int i = 0; i <= lineDataCount - 2; i++) {
                
                if (((NSNumber *)lineRemainDist[idxData][i]).doubleValue - comps.distance < 20.0) {//20マイルバッファ
                    
                    double startLat = ((NSNumber *)lineData.latlon[i][0]).doubleValue;
                    double startLon = ((NSNumber *)lineData.latlon[i][1]).doubleValue;
                    
                    double endLat = ((NSNumber *)lineData.latlon[i+1][0]).doubleValue;
                    double endLon = ((NSNumber *)lineData.latlon[i+1][1]).doubleValue;
                    
                    double distanceToLine = [[self class] distanceFromLat:comps.lat
                                                                      Lon:comps.lon
                                                             ToLineDepLat:startLat
                                                                   DepLon:startLon
                                                                   ArrLat:endLat
                                                                   ArrLon:endLon];
                    
                    
                    

                    if (distanceToLine < 20.0) {
                        
                        double distanceStartToPoint = [[self class] distanceByDepLat:startLat
                                                                              DepLon:startLon
                                                                              ArrLat:comps.lat
                                                                              ArrLon:comps.lon];
                        
                        
                        if (distanceStartToPoint == 0) {
                            
                            LandmarkPassData *returnLinePass = [[LandmarkPassData alloc] init];
                            
                            returnLinePass.name = lineData.name;
                            returnLinePass.CTM = comps.CTM;
                            returnLinePass.direction = @"";
                            returnLinePass.distance = 0.0;
                            
                            [returnArray addObject:returnLinePass.copy];
                            
                            lineRemainDist[idxData][i] = @0;
                            lineExistCross[idxData] = @YES;
                            
                            return;
                            
                        }
                        
                        
                        double distanceStartToEnd = [[self class] distanceByDepLat:startLat
                                                                            DepLon:startLon
                                                                            ArrLat:endLat
                                                                            ArrLon:endLon];
                        
                        
                        double courseStartToPoint = [[self class] calcCourseByDepLat:startLat
                                                                              DepLon:startLon
                                                                              ArrLat:comps.lat
                                                                              ArrLon:comps.lon];
                        
                        
                        double courseStartToEnd = [[self class] calcCourseByDepLat:startLat
                                                                            DepLon:startLon
                                                                            ArrLat:endLat
                                                                            ArrLon:endLon];
                        
                        
                        if (cosd(courseStartToEnd - courseStartToPoint) < 0) { //startより前
                            lineRemainDist[idxData][i] = [NSNumber numberWithDouble:distanceStartToPoint];
                            startToEndAndPointSin[idxData][i] = @9999.9;
                        } else if (distanceStartToPoint > distanceStartToEnd) {//endより後ろ
                            lineRemainDist[idxData][i] = [NSNumber numberWithDouble:distanceStartToPoint - distanceStartToEnd];
                            startToEndAndPointSin[idxData][i] = @9999.9;
                        } else {//startとendの間
                            
                            double sinStartToEndAndPoint = sind(courseStartToEnd - courseStartToPoint);
                            
                            
                            if (((NSNumber *)startToEndAndPointSin[idxData][i]).doubleValue * sinStartToEndAndPoint <= 0 &&
                                ((NSNumber *)startToEndAndPointSin[idxData][i]).doubleValue <= 1){
                                
                                /*
                                 NSLog(@"preSin:%.02f nowSin:%.02f dStoP:%.02f dStoE:%.02f idx:%lu CTM:%d",
                                 ((NSNumber *)startToEndAndPointSin[idxData][i]).doubleValue,
                                 sinStartToEndAndPoint,
                                 distanceStartToPoint,
                                 distanceStartToEnd,
                                 (unsigned long)idxComps,
                                 comps.CTM);*/
                                
                                LandmarkPassData *returnLinePass = [[LandmarkPassData alloc] init];
                                
                                returnLinePass.name = lineData.name;
                                returnLinePass.CTM = comps.CTM - 1;
                                returnLinePass.direction = @"";
                                returnLinePass.distance = 0.0;
                                
                                [returnArray addObject:returnLinePass.copy];
                                
                                lineRemainDist[idxData][i] = @0;
                                lineExistCross[idxData] = @YES;
                                
                                return;
                                
                            }
                            
                            
                            startToEndAndPointSin[idxData][i] = [NSNumber numberWithDouble:sinStartToEndAndPoint];
                            
                            lineRemainDist[idxData][i] = [NSNumber numberWithDouble:distanceToLine];
                        }

                    } else {
                        lineRemainDist[idxData][i] = [NSNumber numberWithDouble:distanceToLine];
                    }
 
                } else {
                    lineRemainDist[idxData][i] = [NSNumber numberWithDouble:((NSNumber *)lineRemainDist[idxData][i]).doubleValue - comps.distance];
                }
            }
        
        
        
        }];
        
        
        
    }];
    
    return [returnArray copy];
}

+(double)distanceByDepLat:(double)depLat
                   DepLon:(double)depLon
                   ArrLat:(double)arrLat
                   ArrLon:(double)arrLon {
    
    return fabs(acosd(sind(depLat) * sind(arrLat) +
                      cosd(depLat) * cosd(arrLat) *
                      cosd(arrLon - depLon)) * 60.0);
    
    
}

+(double)distanceFromLat:(double)lat
                     Lon:(double)lon
            ToLineDepLat:(double)depLat
                  DepLon:(double)depLon
                  ArrLat:(double)arrLat
                  ArrLon:(double)arrLon{
    
    double answer;
    
    double distanceFromPointToDep = [[self class] distanceByDepLat:depLat
                                                            DepLon:depLon
                                                            ArrLat:lat
                                                            ArrLon:lon] / 60.0;
    
    double courseFromDepToArr = [[self class] calcCourseByDepLat:depLat
                                                          DepLon:depLon
                                                          ArrLat:arrLat
                                                          ArrLon:arrLon];

    double courseFromDepToPoint = [[self class] calcCourseByDepLat:depLat
                                                            DepLon:depLon
                                                            ArrLat:lat
                                                            ArrLon:lon];
    

    
    answer = sind(distanceFromPointToDep) * sind(courseFromDepToPoint - courseFromDepToArr);
    
    return fabs(asind(answer)) * 60.0;
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

@end
