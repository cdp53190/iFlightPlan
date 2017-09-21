//
//  WeatherForcastData.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/17.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherForcastData : NSObject<NSCoding>

@property NSString *previousWeatherForcastSummery, *previousTempForcast, *posteriorWeatherForcastSummery, *posteriorTempForcast;
@property NSDate *previousForcastDate, *posteriorForcastDate;
@property NSString *timezone;


@end
