//
//  SaveDatas.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/05.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "SaveDataPackage.h"

@implementation SaveDataPackage

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_planArray forKey:@"planArray"];
    [coder encodeObject:_divertPlanArray forKey:@"divertPlanArray"];
    [coder encodeObject:_sunMoonPlanArray forKey:@"sunMoonPlanArray"];
    [coder encodeObject:_courseArray forKey:@"courseArray"];
    [coder encodeObject:_sunMoonTakeoffDate forKey:@"sunMoonTakeoffDate"];
    [coder encodeDouble:_moonPhase forKey:@"moonPhase"];
    [coder encodeObject:_atcData forKey:@"atcData"];
    [coder encodeObject:_fuelTimeData forKey:@"fuelTimeData"];
    [coder encodeObject:_weightData forKey:@"weightData"];
    [coder encodeObject:_etopsData forKey:@"etopsData"];
    [coder encodeObject:_otherData forKey:@"otherData"];
    [coder encodeObject:_alternateData forKey:@"alternateData"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _planArray = [coder decodeObjectForKey:@"planArray"];
        _divertPlanArray = [coder decodeObjectForKey:@"divertPlanArray"];
        _sunMoonPlanArray = [coder decodeObjectForKey:@"sunMoonPlanArray"];
        _courseArray = [coder decodeObjectForKey:@"courseArray"];
        _sunMoonTakeoffDate = [coder decodeObjectForKey:@"sunMoonTakeoffDate"];
        _moonPhase = [coder decodeDoubleForKey:@"moonPhase"];
        _atcData = [coder decodeObjectForKey:@"atcData"];
        _fuelTimeData = [coder decodeObjectForKey:@"fuelTimeData"];
        _weightData = [coder decodeObjectForKey:@"weightData"];
        _etopsData = [coder decodeObjectForKey:@"etopsData"];
        _otherData = [coder decodeObjectForKey:@"otherData"];
        _alternateData = [coder decodeObjectForKey:@"alternateData"];

    }
    return self;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        _planArray = @[];
        _divertPlanArray = @[];
        _sunMoonPlanArray = @[];
        _courseArray = @[];
        _sunMoonTakeoffDate = [[TakeoffTimeData alloc] init];
        _moonPhase = -1.0;
        _atcData = [[ATCData alloc] init];
        _fuelTimeData = [[FuelTimeData alloc] init];
        _weightData = [[WeightData alloc] init];
        _etopsData = [[ETOPSData alloc] init];
        _otherData = [[OtherData alloc] init];
        _alternateData = [[AlternateData alloc] init];
    }
      
    return self;
}

+(void)saveNewPlanWithDataPackage:(SaveDataPackage *)dataPackage {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if (![ud objectForKey:@"savedPlanArray"]) {
        [ud setObject:[NSData new] forKey:@"savedPlanArray"];
        [ud synchronize];
    }
    
    
    NSMutableArray<SaveDataPackage *> *savedPlanArray = [NSMutableArray arrayWithArray:[SaveDataPackage savedPlanArray]];
    
    [savedPlanArray insertObject:dataPackage atIndex:0];
    
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:savedPlanArray] forKey:@"savedPlanArray"];
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud setObject:@0 forKey:@"planNumber"];
    [ud synchronize];
    
}

+(void)savePresentPlanWithPlanNumber:(NSInteger)planNumber{
    
    SaveDataPackage *presentData = [SaveDataPackage presentData];
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if(![ud objectForKey:@"savedPlanArray"]) {
        [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:@[]] forKey:@"savedPlanArray"];
        [ud synchronize];
    }
    
    NSMutableArray<SaveDataPackage *> *savedPlanArray = [NSMutableArray arrayWithArray:[SaveDataPackage savedPlanArray]];
    if (savedPlanArray.count > 0) {
        [savedPlanArray removeObjectAtIndex:planNumber];
    }
    
    [savedPlanArray insertObject:presentData atIndex:planNumber];
    
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:savedPlanArray] forKey:@"savedPlanArray"];
    [ud synchronize];
    
}

+(void)loadPlanOfPlanNumber:(NSInteger)planNumber {
    
    NSArray<SaveDataPackage *> *savedPlanArray = [SaveDataPackage savedPlanArray];
    
    SaveDataPackage *newData = savedPlanArray[planNumber];
    
    [SaveDataPackage savePresentAllDataWithDataPackage:newData];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[NSNumber numberWithInteger:planNumber] forKey:@"planNumber"];
    [ud synchronize];
    
    NSNotification *n = [NSNotification notificationWithName:@"planReload" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
}

+(void)savePresentAllDataWithDataPackage:(SaveDataPackage *)dataPackage {

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    
    [ud synchronize];

}

+(void)savePresentDataWithPlanArray:(NSArray<NAVLOGLegComponents *> *)planArray{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.planArray = planArray;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];

}

+(void)savePresentDataWithDivertPlanArray:(NSArray<NAVLOGLegComponents *> *)divertPlanArray{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.divertPlanArray = divertPlanArray;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];
    
}

+(void)savePresentDataWithSunMoonPlanArray:(NSArray<SunMoonPointComponents *> *)sunMoonPlanArray{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.sunMoonPlanArray = sunMoonPlanArray;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];

}


+(void)savePresentDataWithCourseArray:(NSArray<CoursePointComponents *> *)courseArray{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.courseArray = courseArray;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];

}

+(void)savePresentDataWithSunMoonTakeoffDate:(TakeoffTimeData *)sunMoonTakeoffDate{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.sunMoonTakeoffDate = sunMoonTakeoffDate;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];

}

+(void)savePresentDataWithMoonPhase:(double)moonPhase{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.moonPhase = moonPhase;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];

}

+(void)savePresentDataWithATCData:(ATCData *)atcData{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.atcData = atcData;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];

    
}

+(void)savePresentDataWithWeightData:(WeightData *)weightData{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.weightData = weightData;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];

    
}

+(void)savePresentDataWithETOPSData:(ETOPSData *)etopsData{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.etopsData = etopsData;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];

}

+(void)savePresentDataWithOtherData:(OtherData *)otherData{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.otherData = otherData;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];

}

+(void)savePresentDataWithAlternateData:(AlternateData *)alternateData {

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.alternateData = alternateData;
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:dataPackage] forKey:@"presentData"];
    [ud synchronize];
    
}

+(SaveDataPackage *)presentData {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    
}

+(NSArray<SaveDataPackage *> *)savedPlanArray {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    return [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"savedPlanArray"]];
    
}

@end
