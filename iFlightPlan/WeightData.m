//
//  WeightData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/10.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "WeightData.h"

@implementation WeightData

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_structureLimit forKey:@"structureLimit"];
    [coder encodeObject:_takeoffLimit forKey:@"takeoffLimit"];
    [coder encodeObject:_maxLanding forKey:@"maxLanding"];
    [coder encodeObject:_burnOffFuel forKey:@"burnOffFuel"];
    [coder encodeObject:_landingLimit forKey:@"landingLimit"];
    [coder encodeObject:_maxZeroFuel forKey:@"maxZeroFuel"];
    [coder encodeObject:_takeoffFuel forKey:@"takeoffFuel"];
    [coder encodeObject:_zeroFuelLimit forKey:@"zeroFuelLimit"];
    [coder encodeObject:_maxTakeoffCondition forKey:@"maxTakeoffCondition"];
    [coder encodeObject:_maxLandingCondition forKey:@"maxLandingCondition"];
    [coder encodeObject:_takeoff forKey:@"takeoff"];
    [coder encodeObject:_landing forKey:@"landing"];
    [coder encodeObject:_zeroFuel forKey:@"zeroFuel"];
    [coder encodeObject:_AGTOW_PTOW forKey:@"AGTOW_PTOW"];
    [coder encodeObject:_MTXW_TAXI forKey:@"MTXW_TAXI"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _structureLimit = [coder decodeObjectForKey:@"structureLimit"];
        _takeoffLimit = [coder decodeObjectForKey:@"takeoffLimit"];
        _maxLanding = [coder decodeObjectForKey:@"maxLanding"];
        _burnOffFuel = [coder decodeObjectForKey:@"burnOffFuel"];
        _landingLimit = [coder decodeObjectForKey:@"landingLimit"];
        _maxZeroFuel = [coder decodeObjectForKey:@"maxZeroFuel"];
        _takeoffFuel = [coder decodeObjectForKey:@"takeoffFuel"];
        _zeroFuelLimit = [coder decodeObjectForKey:@"zeroFuelLimit"];
        _maxTakeoffCondition = [coder decodeObjectForKey:@"maxTakeoffCondition"];
        _maxLandingCondition = [coder decodeObjectForKey:@"maxLandingCondition"];
        _takeoff = [coder decodeObjectForKey:@"takeoff"];
        _landing = [coder decodeObjectForKey:@"landing"];
        _zeroFuel = [coder decodeObjectForKey:@"zeroFuel"];
        _AGTOW_PTOW = [coder decodeObjectForKey:@"AGTOW_PTOW"];
        _MTXW_TAXI = [coder decodeObjectForKey:@"MTXW_TAXI"];

    }
    return self;
}

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        _structureLimit = @"";
        _takeoffLimit = @"";
        _maxLanding = @"";
        _burnOffFuel = @"";
        _landingLimit = @"";
        _maxZeroFuel = @"";
        _takeoffFuel = @"";
        _zeroFuelLimit = @"";
        _maxTakeoffCondition = @"";
        _maxLandingCondition = @"";
        _takeoff = @"";
        _landing = @"";
        _zeroFuel = @"";
        _AGTOW_PTOW = @"";
        _MTXW_TAXI = @"";
    }
    
    return self;
    
}

@end
