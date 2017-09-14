//
//  SunMoonPointContents.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/03.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "SunMoonPointComponents.h"

@implementation SunMoonPointComponents
-(id)copyWithZone:(NSZone *)zone {
    
    SunMoonPointComponents *newInstance = [[[self class] allocWithZone:zone] init];
    if (newInstance) {
        
        newInstance.CTM = _CTM;
        newInstance.CTMString = _CTMString;
        newInstance.time = _time;
        newInstance.timeString = _timeString;
        newInstance.lat = _lat;
        newInstance.latString = _latString;
        newInstance.lon = _lon;
        newInstance.lonString = _lonString;
        newInstance.WPT = _WPT;
        newInstance.FL = _FL;
        newInstance.FLString = _FLString;
        newInstance.SunDIR = _SunDIR;
        newInstance.SunALT = _SunALT;
        newInstance.SunSTATUS = _SunSTATUS;
        newInstance.MoonDIR = _MoonDIR;
        newInstance.MoonALT = _MoonALT;
        newInstance.MoonSTATUS = _MoonSTATUS;

    }
    return newInstance;

    
}


// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeDouble:_CTM forKey:@"CTM"];
    [coder encodeObject:_CTMString forKey:@"CTMString"];
    [coder encodeDouble:_time forKey:@"time"];
    [coder encodeObject:_timeString forKey:@"timeString"];
    [coder encodeDouble:_lat forKey:@"lat"];
    [coder encodeObject:_latString forKey:@"latString"];
    [coder encodeDouble:_lon forKey:@"lon"];
    [coder encodeObject:_lonString forKey:@"lonString"];
    [coder encodeObject:_WPT forKey:@"WPT"];
    [coder encodeDouble:_FL forKey:@"FL"];
    [coder encodeObject:_FLString forKey:@"FLString"];
    [coder encodeObject:_SunDIR forKey:@"sunDir"];
    [coder encodeObject:_SunALT forKey:@"sunAlt"];
    [coder encodeObject:_SunSTATUS forKey:@"sunStatus"];
    [coder encodeObject:_MoonDIR forKey:@"moonDir"];
    [coder encodeObject:_MoonALT forKey:@"moonAlt"];
    [coder encodeObject:_MoonSTATUS forKey:@"moonStatus"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _CTM = [coder decodeDoubleForKey:@"CTM"];
        _CTMString = [coder decodeObjectForKey:@"CTMString"];
        _time = [coder decodeDoubleForKey:@"time"];
        _timeString = [coder decodeObjectForKey:@"timeString"];
        _lat = [coder decodeDoubleForKey:@"lat"];
        _latString = [coder decodeObjectForKey:@"latString"];
        _lon = [coder decodeDoubleForKey:@"lon"];
        _lonString = [coder decodeObjectForKey:@"lonString"];
        _WPT = [coder decodeObjectForKey:@"WPT"];
        _FL = [coder decodeDoubleForKey:@"FL"];
        _FLString = [coder decodeObjectForKey:@"FLString"];
        _SunDIR = [coder decodeObjectForKey:@"sunDir"];
        _SunALT = [coder decodeObjectForKey:@"sunAlt"];
        _SunSTATUS = [coder decodeObjectForKey:@"sunStatus"];
        _MoonDIR = [coder decodeObjectForKey:@"moonDir"];
        _MoonALT = [coder decodeObjectForKey:@"moonAlt"];
        _MoonSTATUS = [coder decodeObjectForKey:@"moonStatus"];

    }
    return self;
}

-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        _CTM = 9999;
        _CTMString = @"";
        _time = 9999;
        _timeString = @"";
        _lat = 9999;
        _latString = @"";
        _lon = 9999;
        _lonString = @"";
        _WPT = @"";
        _FL = 9999;
        _FLString = @"";
        _SunDIR = @"";
        _SunALT = @"";
        _SunSTATUS = @"";
        _MoonDIR = @"";
        _MoonALT = @"";
        _MoonSTATUS = @"";
    }

    return self;
    
}


@end
