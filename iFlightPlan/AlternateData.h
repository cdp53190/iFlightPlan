//
//  AlternateData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/10.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlternateData : NSObject

@property NSString *firstAPO3, *firstAPO4, *secondAPO3, *secondAPO4;
@property NSString *route, *windFactorToFirstALTN, *windFactorToSecondALTN, *FL;


@end
