//
//  LandmarkPassData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/26.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LandmarkPassData : NSObject<NSCopying, NSCoding>

@property NSString *name, *direction;
@property int CTM;
@property double distance;

@end
