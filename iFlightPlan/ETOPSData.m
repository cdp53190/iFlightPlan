//
//  ETOPSData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/10.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "ETOPSData.h"

@implementation RALTData

-(id)copyWithZone:(NSZone *)zone {
    
    RALTData *newInstance = [[[self class] allocWithZone:zone] init];
    if (newInstance) {
        
        newInstance.APO3 = _APO3;
        newInstance.APO4 = _APO4;
        newInstance.earliestTime = _earliestTime;
        newInstance.latestTime = _latestTime;
        newInstance.applyTimeCircle = _applyTimeCircle;
        newInstance.actualTimeCircle = _actualTimeCircle;
        
    }
    return newInstance;
    
    
}

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_APO3 forKey:@"APO3"];
    [coder encodeObject:_APO4 forKey:@"APO4"];
    [coder encodeObject:_earliestTime forKey:@"earliestTime"];
    [coder encodeObject:_latestTime forKey:@"latestTime"];
    [coder encodeObject:_applyTimeCircle forKey:@"applyTimeCircle"];
    [coder encodeObject:_actualTimeCircle forKey:@"actualTimeCircle"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _APO3 = [coder decodeObjectForKey:@"APO3"];
        _APO4 = [coder decodeObjectForKey:@"APO4"];
        _earliestTime = [coder decodeObjectForKey:@"earliestTime"];
        _latestTime = [coder decodeObjectForKey:@"latestTime"];
        _applyTimeCircle = [coder decodeObjectForKey:@"applyTimeCircle"];
        _actualTimeCircle = [coder decodeObjectForKey:@"actualTimeCircle"];

    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _APO3 = @"";
        _APO4 = @"";
        _earliestTime = @"";
        _latestTime = @"";
        _applyTimeCircle = @"";
        _actualTimeCircle = @"";
    }
    return self;
}

@end

@implementation ETPDivertData

-(id)copyWithZone:(NSZone *)zone {
    
    ETPDivertData *newInstance = [[[self class] allocWithZone:zone] init];
    if (newInstance) {
        
        newInstance.point = _point;
        newInstance.ETPfuel = _ETPfuel;
        newInstance.ETPtime = _ETPtime;
        newInstance.ETP_APO3s = _ETP_APO3s;
        newInstance.windFactor = _windFactor;
        newInstance.divertFuel = _divertFuel;
        newInstance.divertTime = _divertTime;
        newInstance.fuelRemain = _fuelRemain;
        newInstance.engineNumber = _engineNumber;
        newInstance.icingCondition = _icingCondition;
        
    }
    return newInstance;
    
    
}

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_point forKey:@"point"];
    [coder encodeObject:_ETPfuel forKey:@"ETPfuel"];
    [coder encodeObject:_ETPtime forKey:@"ETPtime"];
    [coder encodeObject:_ETP_APO3s forKey:@"ETP_APO3s"];
    [coder encodeObject:_windFactor forKey:@"windFactor"];
    [coder encodeObject:_divertFuel forKey:@"divertFuel"];
    [coder encodeObject:_divertTime forKey:@"divertTime"];
    [coder encodeObject:_fuelRemain forKey:@"fuelRemain"];
    [coder encodeObject:_engineNumber forKey:@"engineNumber"];
    [coder encodeObject:_icingCondition forKey:@"icingCondition"];
        
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _point = [coder decodeObjectForKey:@"point"];
        _ETPfuel = [coder decodeObjectForKey:@"ETPfuel"];
        _ETPtime = [coder decodeObjectForKey:@"ETPtime"];
        _ETP_APO3s = [coder decodeObjectForKey:@"ETP_APO3s"];
        _windFactor = [coder decodeObjectForKey:@"windFactor"];
        _divertFuel = [coder decodeObjectForKey:@"divertFuel"];
        _divertTime = [coder decodeObjectForKey:@"divertTime"];
        _fuelRemain = [coder decodeObjectForKey:@"fuelRemain"];
        _engineNumber = [coder decodeObjectForKey:@"engineNumber"];
        _icingCondition = [coder decodeObjectForKey:@"icingCondition"];

    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _point = @"";
        _ETPfuel = @"";
        _ETPtime = @"";
        _ETP_APO3s = @"";
        _windFactor = @"";
        _divertFuel = @"";
        _divertTime = @"";
        _fuelRemain = @"";
        _engineNumber = @"";
        _icingCondition = @"";
    }
    return self;
}

@end

@implementation ETOPSData

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_ETOPS forKey:@"ETOPS"];
    [coder encodeObject:_RALT forKey:@"RALT"];
    [coder encodeObject:_ETPDivert forKey:@"ETPDivert"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _ETOPS = [coder decodeObjectForKey:@"ETOPS"];
        _RALT = [coder decodeObjectForKey:@"RALT"];
        _ETPDivert = [coder decodeObjectForKey:@"ETPDivert"];

    }
    return self;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _ETOPS = @"";
        _RALT = @[];
        _ETPDivert = @[];

    }
    
    return self;
}

@end
