//
//  CourseCalc.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/05.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaveDataPackage.h"

@interface CourseCalc : NSObject


+(NSArray<CoursePointComponents *> *)makeCourseArrayWithPlanArray:(NSArray<NAVLOGLegComponents *> *)planArray;

@end


