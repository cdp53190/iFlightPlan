//
//  LandmarkPass.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/21.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaveDataPackage.h"
#import "LandmarkPointData.h"
#import "LandmarkLineData.h"
#import "LandmarkPassData.h"

@interface LandmarkPass : NSObject

-(NSArray<LandmarkPassData *> *)landmarkPassByCourseArray:(NSArray<CoursePointComponents *> *)courseArray;

@end
