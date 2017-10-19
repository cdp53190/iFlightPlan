//
//  LandmarkData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/21.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LandmarkPointData : NSObject<NSCoding, NSCopying>

@property NSString *name;
@property NSNumber *lat, *lon;
@property NSNumber *detectDistance;

@end
