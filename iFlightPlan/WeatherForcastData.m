//
//  WeatherForcastData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/17.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "WeatherForcastData.h"

@implementation WeatherForcastData

-(void)encodeWithCoder:(NSCoder *)coder{
    
    [coder encodeObject:_previousWeatherForcastSummery forKey:@"previousWeatherForcastSummery"];
    [coder encodeObject:_previousTempForcast forKey:@"previousTempForcast"];
    [coder encodeObject:_posteriorWeatherForcastSummery forKey:@"posteriorWeatherForcastSummery"];
    [coder encodeObject:_posteriorTempForcast forKey:@"posteriorTempForcast"];
    [coder encodeObject:_previousForcastDate forKey:@"previousForcastDate"];
    [coder encodeObject:_posteriorForcastDate forKey:@"posteriorForcastDate"];
    [coder encodeObject:_timezone forKey:@"timezone"];

}

-(instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _previousWeatherForcastSummery = [coder decodeObjectForKey:@"previousWeatherForcastSummery"];
        _previousTempForcast = [coder decodeObjectForKey:@"previousTempForcast"];
        _posteriorWeatherForcastSummery = [coder decodeObjectForKey:@"posteriorWeatherForcastSummery"];
        _posteriorTempForcast = [coder decodeObjectForKey:@"posteriorTempForcast"];
        _previousForcastDate = [coder decodeObjectForKey:@"previousForcastDate"];
        _posteriorForcastDate = [coder decodeObjectForKey:@"posteriorForcastDate"];
        _timezone = [coder decodeObjectForKey:@"timezone"];
        
    }
    return self;


}

-(instancetype)init {
    self = [super init];
    if (self) {
        
        _previousWeatherForcastSummery = @"";
        _previousTempForcast = @"";
        _posteriorWeatherForcastSummery = @"";
        _posteriorTempForcast = @"";
        _previousForcastDate = nil;
        _posteriorForcastDate = nil;
        _timezone = nil;
        
    }

    return self;

}

@end
