//
//  OtherData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/07.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherForcastData.h"

@interface OtherData : NSObject<NSCoding>

@property NSString *logNumber, *flightNumber, *courseName, *FMCCourse, *aircraftNumber, *aircraftType, *SELCAL;
@property NSString *depAPO3, *arrAPO3, *STD, *STA, *blockTime, *timeMargin;
@property NSString *GS_MPH, *GS_KMH, *GS_Kt, *averageTAS, *windFactor, *groundDistance, *airDistance;
@property NSString *climbSpeed, *cruiseSpeed, *descendSpeed, *initialFL;
@property NSString *takeoffRunway, *landingRunway, *fuelCorrectionFactor;
@property NSString *issueTime, *MEL, *PIC, *dispatcher, *dispatchDate, *dispatchTime;
@property NSString *SID,*STAR;
@property WeatherForcastData *forcast;

@end
