//
//  SaveDatas.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/05.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAVLOGLegComponents.h"
#import "SunMoonPointComponents.h"
#import "CoursePointComponents.h"
#import "ATCData.h"
#import "FuelTimeData.h"
#import "WeightData.h"
#import "ETOPSData.h"
#import "OtherData.h"
#import "AlternateData.h"
#import "TakeoffTimeData.h"

@interface SaveDataPackage : NSObject<NSCoding>

@property NSArray<NAVLOGLegComponents *> *planArray, *divertPlanArray;
@property NSArray<SunMoonPointComponents *> *sunMoonPlanArray;
@property NSArray<CoursePointComponents *> *courseArray;
@property TakeoffTimeData *sunMoonTakeoffDate;
@property double moonPhase;
@property ATCData *atcData;
@property FuelTimeData *fuelTimeData;
@property WeightData *weightData;
@property ETOPSData *etopsData;
@property OtherData *otherData;
@property AlternateData *alternateData;

+(void)saveNewPlanWithDataPackage:(SaveDataPackage *)dataPackage;
+(void)savePresentPlanWithPlanNumber:(NSInteger)planNumber;
+(void)loadPlanOfPlanNumber:(NSInteger)planNumber;

+(void)savePresentAllDataWithDataPackage:(SaveDataPackage *)dataPackage;
+(void)savePresentDataWithPlanArray:(NSArray<NAVLOGLegComponents *> *)planArray;
+(void)savePresentDataWithDivertPlanArray:(NSArray<NAVLOGLegComponents *> *)divertPlanArray;
+(void)savePresentDataWithSunMoonPlanArray:(NSArray<SunMoonPointComponents *> *)sunMoonPlanArray;
+(void)savePresentDataWithCourseArray:(NSArray<CoursePointComponents *> *)courseArray;
+(void)savePresentDataWithSunMoonTakeoffDate:(TakeoffTimeData *)sunMoonTakeoffDate;
+(void)savePresentDataWithMoonPhase:(double)moonPhase;
+(void)savePresentDataWithATCData:(ATCData *)atcData;
+(void)savePresentDataWithWeightData:(WeightData *)weightData;
+(void)savePresentDataWithETOPSData:(ETOPSData *)etopsData;
+(void)savePresentDataWithOtherData:(OtherData *)otherData;
+(void)savePresentDataWithAlternateData:(AlternateData *)alternateData;

+(SaveDataPackage *)presentData;
+(NSArray<SaveDataPackage *> *)savedPlanArray;

@end
