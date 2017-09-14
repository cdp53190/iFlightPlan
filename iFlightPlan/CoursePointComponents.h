//
//  CoursePointContents.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/03.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoursePointComponents : NSObject<NSCoding, NSCopying>

@property int CTM;
@property double lat, lon, FL;
@property NSString *WPT;



@end
