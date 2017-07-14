//
//  SunMoonCalc.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/03/23.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

/*
 計算複雑。いろんな座標系がある。
 参考図書：日の出日の入りの計算by長沢工（地人書館）
 カッコ内の数字は上記の本のページです。
 */

#import <Foundation/Foundation.h>

@interface SunMoonCalc : NSObject


@property double yeard,monthd,dayd,hourd,minuted;
@property double lat,lon,alt, heightDeg, directionDeg;
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
                   altitude:(int)aAlt;//feet

-(double)moonPhase;

@end
