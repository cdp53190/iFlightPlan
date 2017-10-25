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
    [coder encodeObject:_landmarkPassArray forKey:@"landmarkPassArray"];
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
        _landmarkPassArray = [coder decodeObjectForKey:@"landmarkPassArray"];
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
        _landmarkPassArray = @[];
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
    
    
    NSData *saveData = [NSKeyedArchiver archivedDataWithRootObject:dataPackage];
    
    NSString *fileName = [NSString stringWithFormat:@"%010d", (int)[[NSDate date] timeIntervalSince1970]];
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",fileName]];
    
    [saveData writeToFile:filePath atomically:true];
    

    SaveLoadViewData *saveLoadViewData = [[SaveLoadViewData alloc] init];
    
    NSMutableString *depTime = [NSMutableString new];
    
    NSString *atcDOF = dataPackage.atcData.DOF;
    
    NSString *searchPattern = @"^([0-9][0-9])([0-9][0-9])([0-9][0-9])$";
    NSError *matchError = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:searchPattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&matchError];
    
    if (matchError != nil){
        
        [depTime appendString:@"00-00-00 "];
        
    } else {
        
        if (!atcDOF) {
            [depTime appendString:@"00-00-00 "];
        } else {
            
            NSArray *matches = [regex matchesInString:atcDOF options:0 range:NSMakeRange(0, atcDOF.length)];
            
            if (matches.count != 1) {
                [depTime appendString:@"00-00-00 "];
            } else {
                [depTime appendFormat:@"%@-%@-%@ ",
                 [atcDOF substringWithRange:[matches[0] rangeAtIndex:1]],
                 [atcDOF substringWithRange:[matches[0] rangeAtIndex:2]],
                 [atcDOF substringWithRange:[matches[0] rangeAtIndex:3]]];
            }
            
        }
        
    }
    
    [depTime appendString:dataPackage.otherData.STD];
    [depTime appendString:@"Z"];
    
    saveLoadViewData.depTime = (NSString *)depTime;
    saveLoadViewData.flightNumber = dataPackage.otherData.flightNumber;
    saveLoadViewData.depAPO3 = dataPackage.otherData.depAPO3;
    saveLoadViewData.arrAPO3 = dataPackage.otherData.arrAPO3;

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    NSMutableArray<SaveLoadViewData *> *SLViewArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"SLViewDataArray"]]];
    [SLViewArray insertObject:saveLoadViewData atIndex:0];
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:SLViewArray.copy] forKey:@"SLViewDataArray"];

    [ud setObject:saveData forKey:@"presentData"];
    [ud setObject:@0 forKey:@"planNumber"];
    
    NSMutableArray *fileNameArray = [NSMutableArray arrayWithArray:[ud objectForKey:@"savedFileNameArray"]];
    [fileNameArray insertObject:fileName atIndex:0];
    [ud setObject:fileNameArray.copy forKey:@"savedFileNameArray"];
    
    [ud synchronize];
    
}

+(void)savePresentPlanWithPlanNumber:(NSInteger)planNumber{
    
    SaveDataPackage *presentData = [SaveDataPackage presentData];
    
    NSMutableArray<NSString *> *savedFileNameArray = [NSMutableArray arrayWithArray:[SaveDataPackage savedFileNameArray]];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.data", savedFileNameArray[planNumber]];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    
    NSData *saveData = [NSKeyedArchiver archivedDataWithRootObject:presentData];

    [saveData writeToFile:filePath atomically:true];
    
}

+(void)loadPlanOfPlanNumber:(NSInteger)planNumber {
    
    NSArray<NSString *> *savedFileNameArray = [SaveDataPackage savedFileNameArray];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.data", savedFileNameArray[planNumber]];
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:filePath];
    
    NSData *data;
    
    if(success) {
        data = [[NSData alloc] initWithContentsOfFile:filePath];
    } else {
        //エラー処理未実装
    }
                
    SaveDataPackage *newData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
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

+(void)savePresentDataWithLandmarkPassArray:(NSArray<LandmarkPassData *> *)landmarkPassArray {

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveDataPackage *dataPackage  = [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"presentData"]];
    dataPackage.landmarkPassArray = landmarkPassArray;
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

+(NSArray<NSString *> *)savedFileNameArray {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    return [ud objectForKey:@"savedFileNameArray"];
    
}

+(NSArray<SaveLoadViewData *> *)SLViewDataArray {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:[ud objectForKey:@"SLViewDataArray"]];

}

+(void)allDataLogWithDataPackage:(SaveDataPackage *)dataPackage {
    
    unsigned int outCount;
    objc_property_t *properties;
    
    NSLog(@"atcData");
    properties = class_copyPropertyList([(dataPackage.atcData) class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *propertyValue = [(dataPackage.atcData) valueForKey:propertyName];
        NSLog(@"%@:%@\n",propertyName,propertyValue);
    }
    free(properties);
    NSLog(@"\n\n");
    
    NSLog(@"fuelTimeData");
    properties = class_copyPropertyList([(dataPackage.fuelTimeData) class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *propertyValue = [(dataPackage.fuelTimeData) valueForKey:propertyName];
        
        if ([propertyValue isKindOfClass:[FuelTimeComponents class]]) {
            NSLog(@"%@.time:%@\n",propertyName, ((FuelTimeComponents *)propertyValue).time);
            NSLog(@"%@.fuel:%@\n",propertyName, ((FuelTimeComponents *)propertyValue).fuel);
        } else {
            NSLog(@"%@:%@\n",propertyName, propertyValue);
            
        }
        
    }
    free(properties);
    NSLog(@"\n\n");
    
    
    NSLog(@"WeightData");
    properties = class_copyPropertyList([(dataPackage.weightData) class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *propertyValue = [(dataPackage.weightData) valueForKey:propertyName];
        NSLog(@"%@:%@\n",propertyName, propertyValue);
    }
    free(properties);
    NSLog(@"\n\n");
    
    NSLog(@"etopsData");
    NSLog(@"ETOPS:%@\n", dataPackage.etopsData.ETOPS);
    [dataPackage.etopsData.RALT enumerateObjectsUsingBlock:^(RALTData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        unsigned int outCount;
        objc_property_t *properties;
        
        properties = class_copyPropertyList([(obj) class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *name = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:name];
            NSString *propertyValue = [(obj) valueForKey:propertyName];
            NSLog(@"%@-%ld:%@\n",propertyName, (long)idx, propertyValue);
        }
        free(properties);
    }];
    [dataPackage.etopsData.ETPDivert enumerateObjectsUsingBlock:^(ETPDivertData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        unsigned int outCount;
        objc_property_t *properties;
        
        properties = class_copyPropertyList([(obj) class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *name = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:name];
            NSString *propertyValue = [(obj) valueForKey:propertyName];
            NSLog(@"%@-%ld:%@\n",propertyName, (long)idx, propertyValue);
        }
        free(properties);
    }];
    NSLog(@"\n\n");
    
    NSLog(@"otherData");
    properties = class_copyPropertyList([(dataPackage.otherData) class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *propertyValue = [(dataPackage.otherData) valueForKey:propertyName];
        NSLog(@"%@:%@\n",propertyName, propertyValue);
    }
    free(properties);
    NSLog(@"\n\n");
    
    
    NSLog(@"AlternateData");
    properties = class_copyPropertyList([(dataPackage.alternateData) class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *propertyValue = [(dataPackage.alternateData) valueForKey:propertyName];
        NSLog(@"%@:%@\n",propertyName, propertyValue);
    }
    free(properties);
    NSLog(@"\n\n");

    
}


@end
