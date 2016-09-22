//
//  SunMoonCalc2.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/04/03.
//  Copyright © 2016年 Another Sky. All rights reserved.
//
/*
 
  海上保安庁海洋情報部の情報から赤緯赤経を計算
 
*/

#import <Foundation/Foundation.h>
#import "SunMoonCalc2Data.h"
#import "SunMoonCalc.h"

@interface SunMoonCalc2 : NSObject

@property  double year,month,day,hour,minute;
@property  double lat,lon,alt, heightDeg, directionDeg;
@property NSString *status;

-(void)calcSun;
-(void)calcMoon;

-(instancetype)initWithYear:(int)aYear
                      month:(int)aMonth
                        day:(int)aDay
                       hour:(int)aHour
                     minute:(int)aMinute//UTC
                   latitude:(double)aLat//N:+,S:-
                  longitude:(double)aLon//E:+,W:-
                   altitude:(int)aAlt;


@end
