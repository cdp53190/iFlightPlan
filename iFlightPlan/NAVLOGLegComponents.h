//
//  NAVLOGLegContents.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/03.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAVLOGLegComponents : NSObject<NSCoding, NSCopying>

@property NSString *Ewindtemp, *Awindtemp, *PFL, *AFL, *TC, *MC, *waypoint, *AWY, *FIR;
@property NSString *latString, *lonString, *DST,*ZTM, *ETO, *ETO2, *ATO, *CTM, *Efuel, *Afuel;
@property NSString *memo1, *memo2;

@end
