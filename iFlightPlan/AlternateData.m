//
//  AlternateData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/10.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "AlternateData.h"

@implementation AlternateData

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_firstAPO3 forKey:@"firstAPO3"];
    [coder encodeObject:_firstAPO4 forKey:@"firstAPO4"];
    [coder encodeObject:_secondAPO3 forKey:@"secondAPO3"];
    [coder encodeObject:_secondAPO4 forKey:@"secondAPO4"];
    [coder encodeObject:_route forKey:@"route"];
    [coder encodeObject:_windFactorToFirstALTN forKey:@"windFactorToFirstALTN"];
    [coder encodeObject:_windFactorToSecondALTN forKey:@"windFactorToSecondALTN"];
    [coder encodeObject:_FL forKey:@"FL"];

}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _firstAPO3 = [coder decodeObjectForKey:@"firstAPO3"];
        _firstAPO4 = [coder decodeObjectForKey:@"firstAPO4"];
        _secondAPO3 = [coder decodeObjectForKey:@"secondAPO3"];
        _secondAPO4 = [coder decodeObjectForKey:@"secondAPO4"];
        _route = [coder decodeObjectForKey:@"route"];
        _windFactorToFirstALTN = [coder decodeObjectForKey:@"windFactorToFirstALTN"];
        _windFactorToSecondALTN = [coder decodeObjectForKey:@"windFactorToSecondALTN"];
        _FL = [coder decodeObjectForKey:@"FL"];

    }
    return self;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _firstAPO3 = @"";
        _firstAPO4 = @"";
        _secondAPO3 = @"";
        _secondAPO4 = @"";
        _route = @"";
        _windFactorToFirstALTN = @"";
        _windFactorToSecondALTN = @"";
        _FL = @"";
        
    }
    
    return self;
}

@end
