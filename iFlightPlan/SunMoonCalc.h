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

@property double year,month,day,hour,minute;
@property double lat,lon,alt, heightDeg, directionDeg;
@property NSString *status;

-(void)calcSun;
-(void)calcMoon;

-(instancetype)initWithYear:(int)year
                      month:(int)month
                        day:(int)day
                       hour:(int)hour
                     minute:(int)minute//UTC
                   latitude:(double)lat//N:+,S:-
                  longitude:(double)lon//E:+,W:-
                   altitude:(int)alt;//m

@end
