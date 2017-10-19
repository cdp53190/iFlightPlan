//
//  LandmarkLineData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/22.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "LandmarkLineData.h"

@implementation LandmarkLineData

-(id)copyWithZone:(NSZone *)zone {
    
    LandmarkLineData *newInstance = [[[self class] allocWithZone:zone] init];
    if (newInstance) {
        
        newInstance.name = _name;
        newInstance.latlon = _latlon;
        
    }
    return newInstance;
    
    
    
    
}

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_latlon forKey:@"latlon"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _name = [coder decodeObjectForKey:@"name"];
        _latlon = [coder decodeObjectForKey:@"latlon"];
        
    }
    return self;
}


-(instancetype)init {
    self = [super init];
    
    if (self) {
        _name = @"";
        _latlon = @[];
    }
    
    return self;
}

@end
