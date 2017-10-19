//
//  NAVLOGLegContents.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/03.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "NAVLOGLegComponents.h"

@implementation NAVLOGLegComponents

-(id)copyWithZone:(NSZone *)zone {
    
    NAVLOGLegComponents *newInstance = [[[self class] allocWithZone:zone] init];
    if (newInstance) {
        
        newInstance.Ewindtemp = _Ewindtemp;
        newInstance.Awindtemp = _Awindtemp;
        newInstance.PFL = _PFL;
        newInstance.AFL = _AFL;
        newInstance.TC = _TC;
        newInstance.MC = _MC;
        newInstance.waypoint = _waypoint;
        newInstance.AWY = _AWY;
        newInstance.FIR = _FIR;
        newInstance.latString = _latString;
        newInstance.lonString = _lonString;
        newInstance.DST = _DST;
        newInstance.ZTM = _ZTM;
        newInstance.ETO = _ETO;
        newInstance.ETO2 = _ETO2;
        newInstance.ATO = _ATO;
        newInstance.CTM = _CTM;
        newInstance.Efuel = _Efuel;
        newInstance.Afuel = _Afuel;
        newInstance.memo1 = _memo1;
        newInstance.memo2 = _memo2;

    }
    return newInstance;
    
    
    
    
}

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_Ewindtemp forKey:@"Ewindtemp"];
    [coder encodeObject:_Awindtemp forKey:@"Awindtemp"];
    [coder encodeObject:_PFL forKey:@"PFL"];
    [coder encodeObject:_AFL forKey:@"AFL"];
    [coder encodeObject:_TC forKey:@"TC"];
    [coder encodeObject:_MC forKey:@"MC"];
    [coder encodeObject:_waypoint forKey:@"waypoint"];
    [coder encodeObject:_AWY forKey:@"AWY"];
    [coder encodeObject:_FIR forKey:@"FIR"];
    [coder encodeObject:_latString forKey:@"latString"];
    [coder encodeObject:_lonString forKey:@"lonString"];
    [coder encodeObject:_DST forKey:@"DST"];
    [coder encodeObject:_ZTM forKey:@"ZTM"];
    [coder encodeObject:_ETO forKey:@"ETO"];
    [coder encodeObject:_ETO2 forKey:@"ETO2"];
    [coder encodeObject:_ATO forKey:@"ATO"];
    [coder encodeObject:_CTM forKey:@"CTM"];
    [coder encodeObject:_Efuel forKey:@"Efuel"];
    [coder encodeObject:_Afuel forKey:@"Afuel"];
    [coder encodeObject:_memo1 forKey:@"memo1"];
    [coder encodeObject:_memo2 forKey:@"memo2"];

}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _Ewindtemp = [coder decodeObjectForKey:@"Ewindtemp"];
        _Awindtemp = [coder decodeObjectForKey:@"Awindtemp"];
        _PFL = [coder decodeObjectForKey:@"PFL"];
        _AFL = [coder decodeObjectForKey:@"AFL"];
        _TC = [coder decodeObjectForKey:@"TC"];
        _MC = [coder decodeObjectForKey:@"MC"];
        _waypoint = [coder decodeObjectForKey:@"waypoint"];
        _AWY = [coder decodeObjectForKey:@"AWY"];
        _FIR = [coder decodeObjectForKey:@"FIR"];
        _latString = [coder decodeObjectForKey:@"latString"];
        _lonString = [coder decodeObjectForKey:@"lonString"];
        _DST = [coder decodeObjectForKey:@"DST"];
        _ZTM = [coder decodeObjectForKey:@"ZTM"];
        _ETO = [coder decodeObjectForKey:@"ETO"];
        _ETO2 = [coder decodeObjectForKey:@"ETO2"];
        _ATO = [coder decodeObjectForKey:@"ATO"];
        _CTM = [coder decodeObjectForKey:@"CTM"];
        _Efuel = [coder decodeObjectForKey:@"Efuel"];
        _Afuel = [coder decodeObjectForKey:@"Afuel"];
        _memo1 = [coder decodeObjectForKey:@"memo1"];
        _memo2 = [coder decodeObjectForKey:@"memo2"];

    }
    return self;
}


-(instancetype)init {
    self = [super init];
    
    if (self) {
        _Ewindtemp = @"";
        _Awindtemp = @"";
        _PFL = @"";
        _AFL = @"";
        _TC = @"";
        _MC = @"";
        _waypoint = @"";
        _AWY = @"";
        _FIR = @"";
        _latString = @"";
        _lonString = @"";
        _DST = @"";
        _ZTM = @"";
        _ETO = @"";
        _ETO2 = @"";
        _ATO = @"";
        _CTM = @"";
        _Efuel = @"";
        _Afuel = @"";
        _memo1 = @"";
        _memo2 = @"";
    }
    
    return self;
}

@end
