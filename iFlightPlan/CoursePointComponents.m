//
//  CoursePointContents.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/03.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "CoursePointComponents.h"

@implementation CoursePointComponents

-(id)copyWithZone:(NSZone *)zone {
    
    CoursePointComponents *newInstance = [[[self class] allocWithZone:zone] init];
    if (newInstance) {
        
        newInstance.CTM = _CTM;
        newInstance.lat = _lat;
        newInstance.lon = _lon;
        newInstance.FL = _FL;
        newInstance.WPT = _WPT;
        
    }
    return newInstance;
    
    
}



// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeInt:_CTM forKey:@"CTM"];
    [coder encodeDouble:_lat forKey:@"lat"];
    [coder encodeDouble:_lon forKey:@"lon"];
    [coder encodeDouble:_FL forKey:@"FL"];
    [coder encodeObject:_WPT forKey:@"WPT"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _CTM = [coder decodeIntForKey:@"CTM"];
        _lat = [coder decodeDoubleForKey:@"lat"];
        _lon = [coder decodeDoubleForKey:@"lon"];
        _FL = [coder decodeDoubleForKey:@"FL"];
        _WPT = [coder decodeObjectForKey:@"WPT"];
        
    }
    return self;
}



-(instancetype)init {
    self = [super init];
    
    if (self) {
        _CTM = -1;
        _lat = 9999;
        _lon = 9999;
        _FL = 9999;
        _WPT = @"";
    }
    
    return self;
    
    
}


@end
