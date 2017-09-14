//
//  OtherData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/07.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "OtherData.h"

@implementation OtherData

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_logNumber forKey:@"logNumber"];
    [coder encodeObject:_flightNumber forKey:@"flightNumber"];
    [coder encodeObject:_courseName forKey:@"courseName"];
    [coder encodeObject:_FMCCourse forKey:@"FMCCourse"];
    [coder encodeObject:_aircraftNumber forKey:@"aircraftNumber"];
    [coder encodeObject:_aircraftType forKey:@"aircraftType"];
    [coder encodeObject:_SELCAL forKey:@"SELCAL"];
    [coder encodeObject:_depAPO3 forKey:@"depAPO3"];
    [coder encodeObject:_arrAPO3 forKey:@"arrAPO3"];
    [coder encodeObject:_STD forKey:@"STD"];
    [coder encodeObject:_STA forKey:@"STA"];
    [coder encodeObject:_blockTime forKey:@"blockTime"];
    [coder encodeObject:_timeMargin forKey:@"timeMargin"];
    [coder encodeObject:_GS_MPH forKey:@"GS_MPH"];
    [coder encodeObject:_GS_KMH forKey:@"GS_KMH"];
    [coder encodeObject:_GS_Kt forKey:@"GS_Kt"];
    [coder encodeObject:_averageTAS forKey:@"averageTAS"];
    [coder encodeObject:_windFactor forKey:@"windFactor"];
    [coder encodeObject:_groundDistance forKey:@"groundDistance"];
    [coder encodeObject:_airDistance forKey:@"airDistance"];
    [coder encodeObject:_climbSpeed forKey:@"climbSpeed"];
    [coder encodeObject:_cruiseSpeed forKey:@"cruiseSpeed"];
    [coder encodeObject:_descendSpeed forKey:@"descendSpeed"];
    [coder encodeObject:_initialFL forKey:@"initialFL"];
    [coder encodeObject:_takeoffRunway forKey:@"takeoffRunway"];
    [coder encodeObject:_landingRunway forKey:@"landingRunway"];
    [coder encodeObject:_fuelCorrectionFactor forKey:@"fuelCorrectionFactor"];
    [coder encodeObject:_issueTime forKey:@"issueTime"];
    [coder encodeObject:_MEL forKey:@"MEL"];
    [coder encodeObject:_PIC forKey:@"PIC"];
    [coder encodeObject:_dispatcher forKey:@"dispatcher"];
    [coder encodeObject:_dispatchDate forKey:@"dispatchDate"];
    [coder encodeObject:_dispatchTime forKey:@"dispatchTime"];

    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _logNumber = [coder decodeObjectForKey:@"logNumber"];
        _flightNumber = [coder decodeObjectForKey:@"flightNumber"];
        _courseName = [coder decodeObjectForKey:@"courseName"];
        _FMCCourse = [coder decodeObjectForKey:@"FMCCourse"];
        _aircraftNumber = [coder decodeObjectForKey:@"aircraftNumber"];
        _aircraftType = [coder decodeObjectForKey:@"aircraftType"];
        _SELCAL = [coder decodeObjectForKey:@"SELCAL"];
        _depAPO3 = [coder decodeObjectForKey:@"depAPO3"];
        _arrAPO3 = [coder decodeObjectForKey:@"arrAPO3"];
        _STD = [coder decodeObjectForKey:@"STD"];
        _STA = [coder decodeObjectForKey:@"STA"];
        _blockTime = [coder decodeObjectForKey:@"blockTime"];
        _timeMargin = [coder decodeObjectForKey:@"timeMargin"];
        _GS_MPH = [coder decodeObjectForKey:@"GS_MPH"];
        _GS_KMH = [coder decodeObjectForKey:@"GS_KMH"];
        _GS_Kt = [coder decodeObjectForKey:@"GS_Kt"];
        _averageTAS = [coder decodeObjectForKey:@"averageTAS"];
        _windFactor = [coder decodeObjectForKey:@"windFactor"];
        _groundDistance = [coder decodeObjectForKey:@"groundDistance"];
        _airDistance = [coder decodeObjectForKey:@"airDistance"];
        _climbSpeed = [coder decodeObjectForKey:@"climbSpeed"];
        _cruiseSpeed = [coder decodeObjectForKey:@"cruiseSpeed"];
        _descendSpeed = [coder decodeObjectForKey:@"descendSpeed"];
        _initialFL = [coder decodeObjectForKey:@"initialFL"];
        _takeoffRunway = [coder decodeObjectForKey:@"takeoffRunway"];
        _landingRunway = [coder decodeObjectForKey:@"landingRunway"];
        _fuelCorrectionFactor = [coder decodeObjectForKey:@"fuelCorrectionFactor"];
        _issueTime = [coder decodeObjectForKey:@"issueTime"];
        _MEL = [coder decodeObjectForKey:@"MEL"];
        _PIC = [coder decodeObjectForKey:@"PIC"];
        _dispatcher = [coder decodeObjectForKey:@"dispatcher"];
        _dispatchDate = [coder decodeObjectForKey:@"dispatchDate"];
        _dispatchTime = [coder decodeObjectForKey:@"dispatchTime"];
        
    }
    return self;
}


-(instancetype)init {
    self = [super init];
    if (self) {
        
        _logNumber = @"";
        _flightNumber = @"";
        _courseName = @"";
        _FMCCourse = @"";
        _aircraftNumber = @"";
        _aircraftType = @"";
        _SELCAL = @"";
        _depAPO3 = @"";
        _arrAPO3 = @"";
        _STD = @"";
        _STA = @"";
        _blockTime = @"";
        _timeMargin = @"";
        _GS_MPH = @"";
        _GS_KMH = @"";
        _GS_Kt = @"";
        _averageTAS = @"";
        _windFactor = @"";
        _groundDistance = @"";
        _airDistance = @"";
        _climbSpeed = @"";
        _cruiseSpeed = @"";
        _descendSpeed = @"";
        _initialFL = @"";
        _takeoffRunway = @"";
        _landingRunway = @"";
        _fuelCorrectionFactor = @"";
        _issueTime = @"";
        _MEL = @"";
        _PIC = @"";
        _dispatcher = @"";
        _dispatchDate = @"";
        _dispatchTime = @"";

    }
    
    return self;
}

@end
