//
//  SaveLoadViewData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/26.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveLoadViewData : NSObject<NSCopying, NSCoding>

@property NSString *depTime, *flightNumber, *depAPO3, *arrAPO3;

@end
