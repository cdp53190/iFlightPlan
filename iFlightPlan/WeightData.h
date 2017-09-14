//
//  WeightData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/10.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeightData : NSObject

@property NSString *structureLimit, *takeoffLimit, *maxLanding, *burnOffFuel, *landingLimit;
@property NSString *maxZeroFuel, *takeoffFuel, *zeroFuelLimit;
@property NSString *maxTakeoffCondition, *maxLandingCondition;
@property NSString *takeoff, *landing, *zeroFuel;
@property NSString *AGTOW_PTOW, *MTXW_TAXI;


@end
