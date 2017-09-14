//
//  FuelData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/09.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuelTimeComponents : NSObject

@property NSString *fuel, *time;

@end

@interface FuelTimeData : NSObject

@property NSString *totalReserve, *minReserve;
@property FuelTimeComponents *dest, *firstAlternate, *contingency, *hold, *extra, *extra_s, *extra_e;
@property FuelTimeComponents *unusable, *takeoff, *taxiout, *ramp, *taxiin, *secondAlternate;

@end

