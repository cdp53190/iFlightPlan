//
//  ETOPSData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/10.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RALTData : NSObject<NSCopying>

@property NSString *APO3, *APO4, *earliestTime, *latestTime, *applyTimeCircle, *actualTimeCircle;

@end

@interface ETPDivertData : NSObject<NSCopying>

@property NSString *point, *ETPfuel, *ETPtime;
@property NSString *ETP_APO3s, *windFactor, *divertFuel, *divertTime, *fuelRemain, *engineNumber, *icingCondition;

@end


@interface ETOPSData : NSObject

@property NSString *ETOPS;
@property NSArray<RALTData *> *RALT;
@property NSArray<ETPDivertData *> *ETPDivert;

@end
