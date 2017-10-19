//
//  LandmarkPassData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/26.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "LandmarkPassData.h"

@implementation LandmarkPassData


-(id)copyWithZone:(NSZone *)zone {
    
    LandmarkPassData *newInstance = [[[self class] allocWithZone:zone] init];
    if (newInstance) {
        
        newInstance.name = _name;
        newInstance.CTM = _CTM;
        newInstance.direction = _direction;
        newInstance.distance = _distance;
        
    }
    return newInstance;
    
    
    
    
}

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeInt:_CTM forKey:@"CTM"];
    [coder encodeObject:_direction forKey:@"direction"];
    [coder encodeDouble:_distance forKey:@"distance"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _name = [coder decodeObjectForKey:@"name"];
        _CTM = [coder decodeIntForKey:@"CTM"];
        _direction = [coder decodeObjectForKey:@"direction"];
        _distance = [coder decodeDoubleForKey:@"distance"];
        
    }
    return self;
}


-(instancetype)init {
    self = [super init];
    
    if (self) {
        _name = @"";
        _CTM = 9999;
        _direction = @"";
        _distance = 9999;
    }
    
    return self;
}

@end
