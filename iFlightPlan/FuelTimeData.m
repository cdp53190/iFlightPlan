//
//  FuelData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/09.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "FuelTimeData.h"

@implementation FuelTimeComponents

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_fuel forKey:@"fuel"];
    [coder encodeObject:_time forKey:@"time"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _fuel = [coder decodeObjectForKey:@"fuel"];
        _time = [coder decodeObjectForKey:@"time"];
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _time = @"";
        _fuel = @"";
    }
    return self;
}

@end

@implementation FuelTimeData

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {

    [coder encodeObject:_totalReserve forKey:@"totalReserve"];
    [coder encodeObject:_minReserve forKey:@"minReserve"];
    
    [coder encodeObject:_dest forKey:@"dest"];
    [coder encodeObject:_firstAlternate forKey:@"firstAlternate"];
    [coder encodeObject:_contingency forKey:@"contingency"];
    [coder encodeObject:_hold forKey:@"hold"];
    [coder encodeObject:_extra forKey:@"extra"];
    [coder encodeObject:_extra_s forKey:@"extra_s"];
    [coder encodeObject:_extra_e forKey:@"extra_e"];
    [coder encodeObject:_unusable forKey:@"unusable"];
    [coder encodeObject:_takeoff forKey:@"takeoff"];
    [coder encodeObject:_taxiout forKey:@"taxiout"];
    [coder encodeObject:_ramp forKey:@"ramp"];
    [coder encodeObject:_taxiin forKey:@"taxiin"];
    [coder encodeObject:_secondAlternate forKey:@"secondAlternate"];

    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {

        _totalReserve = [coder decodeObjectForKey:@"totalReserve"];
        _minReserve = [coder decodeObjectForKey:@"minReserve"];
        
        _dest = [coder decodeObjectForKey:@"dest"];
        _firstAlternate = [coder decodeObjectForKey:@"firstAlternate"];
        _contingency = [coder decodeObjectForKey:@"contingency"];
        _hold = [coder decodeObjectForKey:@"hold"];
        _extra = [coder decodeObjectForKey:@"extra"];
        _extra_s = [coder decodeObjectForKey:@"extra_s"];
        _extra_e = [coder decodeObjectForKey:@"extra_e"];
        _unusable = [coder decodeObjectForKey:@"unusable"];
        _takeoff = [coder decodeObjectForKey:@"takeoff"];
        _taxiout = [coder decodeObjectForKey:@"taxiout"];
        _ramp = [coder decodeObjectForKey:@"ramp"];
        _taxiin = [coder decodeObjectForKey:@"taxiin"];
        _secondAlternate = [coder decodeObjectForKey:@"secondAlternate"];
        
    }
    return self;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _totalReserve = @"";
        _minReserve = @"";
        
        
        _dest = [[FuelTimeComponents alloc] init];
        _firstAlternate = [[FuelTimeComponents alloc] init];
        _contingency = [[FuelTimeComponents alloc] init];
        _hold = [[FuelTimeComponents alloc] init];
        _extra = [[FuelTimeComponents alloc] init];
        _extra_s = [[FuelTimeComponents alloc] init];
        _extra_e = [[FuelTimeComponents alloc] init];
        _unusable = [[FuelTimeComponents alloc] init];
        _takeoff = [[FuelTimeComponents alloc] init];
        _taxiout = [[FuelTimeComponents alloc] init];
        _ramp = [[FuelTimeComponents alloc] init];
        _taxiin = [[FuelTimeComponents alloc] init];
        _secondAlternate = [[FuelTimeComponents alloc] init];


    }
    
    return self;
}

@end
