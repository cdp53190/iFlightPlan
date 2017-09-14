//
//  ATCComponents.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/06.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "ATCData.h"

@implementation ATCData


// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:_aircraftID forKey:@"aircraftID"];
    [coder encodeObject:_flightRules forKey:@"flightRules"];
    [coder encodeObject:_typeOfFlight forKey:@"typeOfFlight"];
    [coder encodeObject:_numberOfAircraft forKey:@"numberOfAircraft"];
    [coder encodeObject:_typeOfAircraft forKey:@"typeOfAircraft"];
    [coder encodeObject:_wakeCategory forKey:@"wakeCategory"];
    [coder encodeObject:_COMNAVEquip forKey:@"COMNAVEquip"];
    [coder encodeObject:_surveillanceEquip forKey:@"surveillanceEquip"];
    [coder encodeObject:_depAPO4 forKey:@"depAPO4"];
    [coder encodeObject:_speedLevelRoute forKey:@"speedLevelRoute"];
    [coder encodeObject:_arrAPO4 forKey:@"arrAPO4"];
    [coder encodeObject:_depTime forKey:@"depTime"];
    [coder encodeObject:_elapsedTime forKey:@"elapsedTime"];
    [coder encodeObject:_firstAlternateAPO4 forKey:@"firstAlternateAPO4"];
    [coder encodeObject:_secondAlternateAPO4 forKey:@"secondAlternateAPO4"];
    [coder encodeBool:_otherInfoExist forKey:@"otherInfoExist"];
    [coder encodeObject:_STS forKey:@"STS"];
    [coder encodeObject:_PBN forKey:@"PBN"];
    [coder encodeObject:_NAV forKey:@"NAV"];
    [coder encodeObject:_COM forKey:@"COM"];
    [coder encodeObject:_DAT forKey:@"DAT"];
    [coder encodeObject:_SUR forKey:@"SUR"];
    [coder encodeObject:_DOF forKey:@"DOF"];
    [coder encodeObject:_REG forKey:@"REG"];
    [coder encodeObject:_EET forKey:@"EET"];
    [coder encodeObject:_SEL forKey:@"SEL"];
    [coder encodeObject:_CODE forKey:@"CODE"];
    [coder encodeObject:_DLE forKey:@"DLE"];
    [coder encodeObject:_OPR forKey:@"OPR"];
    [coder encodeObject:_ORGN forKey:@"ORGN"];
    [coder encodeObject:_PER forKey:@"PER"];
    [coder encodeObject:_RALT forKey:@"RALT"];
    [coder encodeObject:_TALT forKey:@"TALT"];
    [coder encodeObject:_RIF forKey:@"RIF"];
    [coder encodeObject:_RMK forKey:@"RMK"];
    [coder encodeObject:_DEP forKey:@"DEP"];
    [coder encodeObject:_DEST forKey:@"DEST"];
    [coder encodeObject:_ALTN forKey:@"ALTN"];
    [coder encodeObject:_endurance forKey:@"endurance"];
    [coder encodeObject:_POB forKey:@"POB"];
    [coder encodeObject:_emergencyRadio forKey:@"emergencyRadio"];
    [coder encodeObject:_survivalEquip forKey:@"survivalEquip"];
    [coder encodeObject:_jackets forKey:@"jackets"];
    [coder encodeObject:_dinghiesNumber forKey:@"dinghiesNumber"];
    [coder encodeObject:_dinghiesCapacity forKey:@"dinghiesCapacity"];
    [coder encodeObject:_dinghiesCover forKey:@"dinghiesCover"];
    [coder encodeObject:_dinghiesColor forKey:@"dinghiesColor"];
    [coder encodeObject:_aircraftColorMarking forKey:@"aircraftColorMarking"];
    [coder encodeObject:_remarks forKey:@"remarks"];
    [coder encodeObject:_captain forKey:@"captain"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _aircraftID = [coder decodeObjectForKey:@"aircraftID"];
        _flightRules = [coder decodeObjectForKey:@"flightRules"];
        _typeOfFlight = [coder decodeObjectForKey:@"typeOfFlight"];
        _numberOfAircraft = [coder decodeObjectForKey:@"numberOfAircraft"];
        _typeOfAircraft = [coder decodeObjectForKey:@"typeOfAircraft"];
        _wakeCategory = [coder decodeObjectForKey:@"wakeCategory"];
        _COMNAVEquip = [coder decodeObjectForKey:@"COMNAVEquip"];
        _surveillanceEquip = [coder decodeObjectForKey:@"surveillanceEquip"];
        _depAPO4 = [coder decodeObjectForKey:@"depAPO4"];
        _speedLevelRoute = [coder decodeObjectForKey:@"speedLevelRoute"];
        _arrAPO4 = [coder decodeObjectForKey:@"arrAPO4"];
        _depTime = [coder decodeObjectForKey:@"depTime"];
        _elapsedTime = [coder decodeObjectForKey:@"elapsedTime"];
        _firstAlternateAPO4 = [coder decodeObjectForKey:@"firstAlternateAPO4"];
        _secondAlternateAPO4 = [coder decodeObjectForKey:@"secondAlternateAPO4"];
        _otherInfoExist = [coder decodeBoolForKey:@"otherInfoExist"];
        _STS = [coder decodeObjectForKey:@"STS"];
        _PBN = [coder decodeObjectForKey:@"PBN"];
        _NAV = [coder decodeObjectForKey:@"NAV"];
        _COM = [coder decodeObjectForKey:@"COM"];
        _DAT = [coder decodeObjectForKey:@"DAT"];
        _SUR = [coder decodeObjectForKey:@"SUR"];
        _DOF = [coder decodeObjectForKey:@"DOF"];
        _REG = [coder decodeObjectForKey:@"REG"];
        _EET = [coder decodeObjectForKey:@"EET"];
        _SEL = [coder decodeObjectForKey:@"SEL"];
        _CODE = [coder decodeObjectForKey:@"CODE"];
        _DLE = [coder decodeObjectForKey:@"DLE"];
        _OPR = [coder decodeObjectForKey:@"OPR"];
        _ORGN = [coder decodeObjectForKey:@"ORGN"];
        _PER = [coder decodeObjectForKey:@"PER"];
        _RALT = [coder decodeObjectForKey:@"RALT"];
        _TALT = [coder decodeObjectForKey:@"TALT"];
        _RIF = [coder decodeObjectForKey:@"RIF"];
        _RMK = [coder decodeObjectForKey:@"RMK"];
        _DEP = [coder decodeObjectForKey:@"DEP"];
        _DEST = [coder decodeObjectForKey:@"DEST"];
        _ALTN = [coder decodeObjectForKey:@"ALTN"];
        _endurance = [coder decodeObjectForKey:@"endurance"];
        _POB = [coder decodeObjectForKey:@"POB"];
        _emergencyRadio = [coder decodeObjectForKey:@"emergencyRadio"];
        _survivalEquip = [coder decodeObjectForKey:@"survivalEquip"];
        _jackets = [coder decodeObjectForKey:@"jackets"];
        _dinghiesNumber = [coder decodeObjectForKey:@"dinghiesNumber"];
        _dinghiesCapacity = [coder decodeObjectForKey:@"dinghiesCapacity"];
        _dinghiesCover = [coder decodeObjectForKey:@"dinghiesCover"];
        _dinghiesColor = [coder decodeObjectForKey:@"dinghiesColor"];
        _aircraftColorMarking = [coder decodeObjectForKey:@"aircraftColorMarking"];
        _remarks = [coder decodeObjectForKey:@"remarks"];
        _captain = [coder decodeObjectForKey:@"captain"];
        
    }
    return self;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        _aircraftID = @"";
        _flightRules = @"";
        _typeOfFlight = @"";
        _numberOfAircraft = @"";
        _typeOfAircraft = @"";
        _wakeCategory = @"";
        _COMNAVEquip = @"";
        _surveillanceEquip = @"";
        _depAPO4 = @"";
        _speedLevelRoute = @"";
        _arrAPO4 = @"";
        _depTime = @"";
        _elapsedTime = @"";
        _firstAlternateAPO4 = @"";
        _secondAlternateAPO4 = @"";
        _otherInfoExist = NO;
        _STS = @"";
        _PBN = @"";
        _NAV = @"";
        _COM = @"";
        _DAT = @"";
        _SUR = @"";
        _DOF = @"";
        _REG = @"";
        _EET = @"";
        _SEL = @"";
        _CODE = @"";
        _DLE = @"";
        _OPR = @"";
        _ORGN = @"";
        _PER = @"";
        _RALT = @"";
        _TALT = @"";
        _RIF = @"";
        _RMK = @"";
        _DEP = @"";
        _DEST = @"";
        _ALTN = @"";
        _endurance = @"";
        _POB = @"";
        _emergencyRadio = @"";
        _survivalEquip = @"";
        _jackets = @"";
        _dinghiesNumber = @"";
        _dinghiesCapacity = @"";
        _dinghiesCover = @"";
        _dinghiesColor = @"";
        _aircraftColorMarking = @"";
        _remarks = @"";
        _captain = @"";

    }
    
    return self;
}
@end
