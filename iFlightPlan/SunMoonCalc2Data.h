//
//  SunMoonCalc2Data.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/04/04.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SunMoonCalc2Data : NSObject

@property int year;

-(instancetype)initWithYear:(int)year;
+(BOOL) existDataOfYear:(int)year;

+(NSDictionary *)dictionaryOfConstantArrayOfSunByYear:(int)year
                                          tWithDeltaT:(double)t;
+(NSDictionary *)dictionaryOfRbyYear:(int)year
                      tWithoutDeltaT:(double)t;

+(NSDictionary *)dictionaryOfConstantArrayOfMoonByYear:(int)year
                                           tWithDeltaT:(double)t;

+(NSDictionary *)dictionaryOfEbyYear:(int)year
                      tWithoutDeltaT:(double)t;

@end
