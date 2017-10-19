//
//  SaveLoadViewData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/26.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "SaveLoadViewData.h"

@implementation SaveLoadViewData


-(id)copyWithZone:(NSZone *)zone {
    
    SaveLoadViewData *newInstance = [[[self class] allocWithZone:zone] init];
    if (newInstance) {
        
        newInstance.depTime = _depTime;
        newInstance.flightNumber = _flightNumber;
        newInstance.depAPO3 = _depAPO3;
        newInstance.arrAPO3 = _arrAPO3;
        
    }
    return newInstance;
    
    
    
    
}

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_depTime forKey:@"depTime"];
    [coder encodeObject:_flightNumber forKey:@"flightNumber"];
    [coder encodeObject:_depAPO3 forKey:@"depAPO3"];
    [coder encodeObject:_arrAPO3 forKey:@"arrAPO3"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _depTime = [coder decodeObjectForKey:@"depTime"];
        _flightNumber = [coder decodeObjectForKey:@"flightNumber"];
        _depAPO3 = [coder decodeObjectForKey:@"depAPO3"];
        _arrAPO3 = [coder decodeObjectForKey:@"arrAPO3"];
        
    }
    return self;
}


-(instancetype)init {
    self = [super init];
    
    if (self) {
        _depTime = @"0000-00-00 00:00Z";
        _flightNumber = @"JAL0000";
        _depAPO3 = @"HND";
        _arrAPO3 = @"HND";
    }
    
    return self;
}

@end
