//
//  routeCopy.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/10.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SaveDataPackage.h"

@interface RouteCopy : NSObject

-(NSString *)stringOfJeppsenRoute;
-(NSArray *)arrayOfATCRoute;
-(NSArray *)arrayOfFMCLegs;

@end
