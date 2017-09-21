//
//  WeatherForcast.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/17.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaveDataPackage.h"

typedef enum WeatherForcastError :NSInteger{
    WeatherForcastErrorConnection,
    WeatherForcastErrorServer,
    WeatherForcastErrorJSON,
    WeatherForcastErrorNoData
}WeatherForcastError;

@protocol WeatherForcastDelegate <NSObject>

@required
-(void)receiveWeatherForcastErrorWithData:(NSData *)data
                                    error:(WeatherForcastError)error
                                 response:(NSURLResponse *)response;
-(void)receiveForcastWithForcastData:(WeatherForcastData *)forcast;

@end


@interface WeatherForcast : NSObject<NSURLSessionTaskDelegate>

@property id<WeatherForcastDelegate>delegate;

-(void)weatherForcastRequestWithDataPackage:(SaveDataPackage *)dataPackage;


@end
