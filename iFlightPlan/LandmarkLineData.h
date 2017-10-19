//
//  LandmarkLineData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/22.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LandmarkLineData : NSObject<NSCopying, NSCoding>

@property NSString *name;
@property NSArray<NSArray *> *latlon;


@end
