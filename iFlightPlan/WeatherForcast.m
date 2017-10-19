//
//  WeatherForcast.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/17.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "WeatherForcast.h"

@implementation WeatherForcast

-(void)weatherForcastRequestWithDataPackage:(SaveDataPackage *)dataPackage {
    
    NSString *destLatString = dataPackage.planArray.lastObject.latString;
    NSString *destLonString = dataPackage.planArray.lastObject.lonString;
    
    double lat = [WeatherForcast convertStringToLat:destLatString];
    double lon = [WeatherForcast convertStringToLon:destLonString];
    
    NSDate *STADate;
    NSTimeInterval timeInterval = 0.0;
    NSString *STDString = dataPackage.otherData.STD;
    NSString *STAString = dataPackage.otherData.STA;//0940
    
    if (dataPackage.atcData.DOF) {
        
        if (STDString.intValue > STAString.intValue) {
            timeInterval += 60.0 * 60.0 * 24.0;
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [formatter setDateFormat:@"yyMMddHHmm"];
        STADate = [formatter dateFromString:[NSString stringWithFormat:@"%@%@",
                                             dataPackage.atcData.DOF,
                                             STAString]];
        
    } else {
        NSMutableString *timeString = [dataPackage.otherData.issueTime mutableCopy];//00:25 04SEP17
        
        [timeString insertString:@"20" atIndex:11];
        [timeString deleteCharactersInRange:NSMakeRange(2, 1)];//HHmm ddMMMyyyy(0025 04SEP2017)
        
        if ([STDString intValue] < [[timeString substringToIndex:4] intValue]) {
            timeInterval = 60.0 * 60.0 * 24.0;
        }
        
        [timeString replaceCharactersInRange:NSMakeRange(0, 4) withString:STDString];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [formatter setDateFormat:@"HHmm ddMMMyyyy"];
        
        STADate = [formatter dateFromString:timeString];
        
    }
    
    STADate = [NSDate dateWithTimeInterval:timeInterval sinceDate:STADate];
    
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    STADate = [NSDate dateWithTimeInterval:tz.secondsFromGMT sinceDate:STADate];
    
    
    long time = STADate.timeIntervalSince1970;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    NSMutableString *urlStr = [NSMutableString stringWithString:@"https://api.darksky.net/forecast/b133f00b60ac6d0d97205af383472e44/"];
    [urlStr appendString:[NSString stringWithFormat:@"%02.4f,%03.4f,%ld", lat, lon, time]];
    [urlStr appendString:@"?units=si&exclude=currently,daily,flags,latitude,longitude,offset"];
    
    [[session dataTaskWithURL:[NSURL URLWithString:urlStr] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            [self.delegate receiveWeatherForcastErrorWithData:data error:WeatherForcastErrorConnection response:response];
            self.delegate = nil;
            return;
        }
        
        NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (statusCode != 200 && statusCode != 304) {
            [self.delegate receiveWeatherForcastErrorWithData:data error:WeatherForcastErrorServer response:response];
            self.delegate = nil;
            return;
        }
        
        NSError *error2;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error2];
        if (error2) {
            [self.delegate receiveWeatherForcastErrorWithData:data error:WeatherForcastErrorJSON response:response];
            self.delegate = nil;
            
        }else {
            
            
            
            if (dic[@"hourly"][@"data"]) {
                
                WeatherForcastData *forcast = [[WeatherForcastData alloc]init];
                NSArray *hourlyArray = dic[@"hourly"][@"data"];
                
                for (NSDictionary *forcastDic in hourlyArray) {
                    if (!forcastDic[@"time"]) {
                        break;
                    }
                    
                    NSInteger forcastTime = [forcastDic[@"time"] integerValue];
                    
                    if (forcastTime >= time) {
                        if (forcastDic[@"icon"]) {
                            forcast.posteriorWeatherForcastSummery = forcastDic[@"icon"];
                        }
                        
                        if (forcastDic[@"temperature"]) {
                            forcast.posteriorTempForcast = forcastDic[@"temperature"];
                        }
                        
                        forcast.posteriorForcastDate = [NSDate dateWithTimeIntervalSince1970:forcastTime];
                        break;
                        
                    } else {
                        if (forcastDic[@"icon"]) {
                            forcast.previousWeatherForcastSummery = forcastDic[@"icon"];
                        }
                        
                        if (forcastDic[@"temperature"]) {
                            forcast.previousTempForcast = forcastDic[@"temperature"];
                        }
                        
                        forcast.previousForcastDate = [NSDate dateWithTimeIntervalSince1970:forcastTime];
                        
                    }
   
                }
                
                if (dic[@"timezone"]) {
                    forcast.timezone = dic[@"timezone"];
                }
                
                [self.delegate receiveForcastWithForcastData:forcast];
                self.delegate = nil;

            } else {
                [self.delegate receiveWeatherForcastErrorWithData:data error:WeatherForcastErrorNoData response:response];
                self.delegate = nil;
            }
            
        }
        
    }] resume];
    
}

// @"Nxxxxx"->xx.xxxxxx
+(double)convertStringToLat:(NSString *)string{
    
    if ([string isEqualToString:@""]) {
        return 0;
    }
    
    
    double returnValue = 0;
    
    
    returnValue += [string substringWithRange:NSMakeRange(1, 2)].doubleValue;
    returnValue += [string substringWithRange:NSMakeRange(3, 2)].doubleValue / 60;
    returnValue += [string substringWithRange:NSMakeRange(5, 1)].doubleValue / 600;
    
    if ([string hasPrefix:@"N"]) {
        return returnValue;
    } else if([string hasPrefix:@"S"]){
        return -returnValue;
    }
    
    return 0;
    
}

+(double)convertStringToLon:(NSString *)string{
    
    double returnValue = 0;
    
    if ([string isEqualToString:@""]) {
        return 0;
    }
    
    returnValue += [string substringWithRange:NSMakeRange(1, 3)].doubleValue;
    returnValue += [string substringWithRange:NSMakeRange(4, 2)].doubleValue / 60;
    returnValue += [string substringWithRange:NSMakeRange(6, 1)].doubleValue / 600;
    
    if ([string hasPrefix:@"E"]) {
        return returnValue;
    } else if([string hasPrefix:@"W"]){
        return -returnValue;
    }
    
    return 0;
    
}


@end
