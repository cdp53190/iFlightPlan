//
//  TakeoffTimeData.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/09/14.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "TakeoffTimeData.h"

@implementation TakeoffTimeData

// シリアライズ時に自動で呼び出される関数
- (void) encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeInt:_year forKey:@"year"];
    [coder encodeInt:_month forKey:@"month"];
    [coder encodeInt:_day forKey:@"day"];
    [coder encodeInt:_hour forKey:@"hour"];
    [coder encodeInt:_minute forKey:@"minute"];
    
}

// デシリアライズ時に自動で呼び出される関数
- (instancetype) initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        
        _year = [coder decodeIntForKey:@"year"];
        _month = [coder decodeIntForKey:@"month"];
        _day = [coder decodeIntForKey:@"day"];
        _hour = [coder decodeIntForKey:@"hour"];
        _minute = [coder decodeIntForKey:@"minute"];
        
    }
    return self;
}

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        _year = 1970;
        _month = 1;
        _day = 1;
        _hour = 0;
        _minute = 0;
    }
    
    return self;
    
}

+(TakeoffTimeData *)dataOfdate:(NSDate *)date {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger flags;
    NSDateComponents *comps;
    
    flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute;
    
    if (!date) {
        date = [NSDate date];
    }
    
    comps = [calendar components:flags fromDate:date];
    
    TakeoffTimeData *returnData = [[TakeoffTimeData alloc] init];
    
    
    returnData.year = (int)comps.year;
    returnData.month = (int)comps.month;
    returnData.day = (int)comps.day;
    returnData.hour = (int)comps.hour;
    returnData.minute = (int)comps.minute;
    
    return returnData;

    
    
}

-(NSDate *)date {
    
    
    NSString *timeString = [NSString stringWithFormat:@"%02d%02d %02d%02d%04d",
                            _hour,
                            _minute,
                            _day,
                            _month,
                            _year];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setDateFormat:@"HHmm ddMMyyyy"];
    
    return [formatter dateFromString:timeString];

    
}

@end
