//
//  ATCComponents.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/06.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATCData : NSObject<NSCoding>

@property NSString *aircraftID, *flightRules, *typeOfFlight, *numberOfAircraft, *typeOfAircraft;
@property NSString *wakeCategory, *COMNAVEquip, *surveillanceEquip, *depAPO4, *speedLevelRoute;
@property NSString *arrAPO4, *depTime, *elapsedTime, *firstAlternateAPO4, *secondAlternateAPO4;
@property BOOL otherInfoExist;
@property NSString *STS, *PBN, *NAV, *COM, *DAT, *SUR, *DOF, *REG, *EET, *SEL, *CODE, *DLE, *OPR, *ORGN;
@property NSString *PER, *RALT, *TALT, *RIF, *RMK, *DEP, *DEST, *ALTN;
@property NSString *endurance, *POB, *emergencyRadio, *survivalEquip, *jackets;
@property NSString *dinghiesNumber, *dinghiesCapacity, *dinghiesCover, *dinghiesColor;
@property NSString *aircraftColorMarking, *remarks, *captain;


@end
