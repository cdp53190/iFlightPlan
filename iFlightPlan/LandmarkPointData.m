//
//  LandmarkData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/21.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "LandmarkPointData.h"

@implementation LandmarkPointData

-(id)copyWithZone:(NSZone *)zone {
    
    LandmarkPointData *newInstance = [[[self class] allocWithZone:zone] init];
    if (newInstance) {
        
        newInstance.name = _name;
        newInstance.lat = _lat;
        newInstance.lon = _lon;
        newInstance.detectDistance = _detectDistance;
        
    }
    return newInstance;
    
    
    
    
}

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_lat forKey:@"lat"];
    [coder encodeObject:_lon forKey:@"lon"];
    [coder encodeObject:_detectDistance forKey:@"detectDistance"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _name = [coder decodeObjectForKey:@"name"];
        _lat = [coder decodeObjectForKey:@"lat"];
        _lon = [coder decodeObjectForKey:@"lon"];
        _detectDistance = [coder decodeObjectForKey:@"detectDistance"];
        
    }
    return self;
}


-(instancetype)init {
    self = [super init];
    
    if (self) {
        _name = @"";
        _lat = @0.0;
        _lon = @0.0;
        _detectDistance = @0.0;
    }
    
    return self;
}

@end
