//
//  TakeoffTimeData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/14.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TakeoffTimeData : NSObject<NSCoding>

@property int year, month, day, hour, minute;

+(TakeoffTimeData *)dataOfdate:(NSDate *)date;
-(NSDate *)date;

@end
