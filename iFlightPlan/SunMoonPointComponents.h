//
//  SunMoonPointContents.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/03.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SunMoonPointComponents : NSObject<NSCoding,NSCopying>

@property NSString *CTMString, *timeString, *latString, *lonString, *WPT, *FLString, *SunDIR, *SunALT, *SunSTATUS;
@property NSString *MoonDIR, *MoonALT, *MoonSTATUS;
@property double lat, lon, CTM, FL, time;


@end
