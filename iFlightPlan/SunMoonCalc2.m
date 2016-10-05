//
//  SunMoonCalc2.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/04/03.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "SunMoonCalc2.h"

@implementation SunMoonCalc2
{
    double RA,Dec,Dist,HP;
    double aForSun,bForSun;
    double aForMoon,bForMoon;
    double aForR,bForR;
    double calcdYearForSun,calcdYearForMoon,calcdYearForR;
    
    NSArray *RAArrayForSun, *DecArrayForSun, *DistArrayForSun;
    NSArray *RAArrayForMoon, *DecArrayForMoon, *HPArrayForMoon;
    NSArray *RArray;
}

@synthesize year,month,day,hour,minute,lat,lon,alt;

#pragma mark - C Function

static double sind(double d) {return sin(d * M_PI/180);}
static double cosd(double d) {return cos(d * M_PI/180);}
//static double tand(double d) {return tan(d * M_PI/180);}
static double asind(double x) {return asin(x) * 180 / M_PI;}
static double acosd(double x) {return acos(x) * 180 / M_PI;}
static double atand(double x) {return atan(x) * 180 / M_PI;}

#pragma mark - Initialize

-(instancetype)initWithYear:(int)aYear
                      month:(int)aMonth
                        day:(int)aDay
                       hour:(int)aHour
                     minute:(int)aMinute//UTC
                   latitude:(double)aLat//N:+,S:-
                  longitude:(double)aLon//E:+,W:-
                   altitude:(int)aAlt {
    
    self = [super init];
    
    if (self) {
        
        year = (double)aYear;
        month = (double)aMonth;
        day = (double)aDay;
        hour = (double)aHour;
        minute = (double)aMinute;
        lat = aLat;
        lon = aLon;
        alt = (double)aAlt;
        
        aForSun = bForSun = aForMoon = bForMoon = aForR = bForR = calcdYearForSun = calcdYearForMoon = calcdYearForR = -1;
    }
    
    return self;
    
}



-(void)calcSun {

    [self setRightAscensionDeclinationDistanceOfSun];
    
    double localHourAngleDeg = [self setLocalHourAngleDegrees];
    
    _directionDeg = [self directionWithHourAngle:localHourAngleDeg rightAscension:Dec];
    _heightDeg = [self altitudeWithHourAngle:localHourAngleDeg rightAscension:Dec];
    
    HP = 0.00244281888889 / Dist;//赤道地平偏差(Π) 8.794148 / 3600
    double e = 0.03533333333333 * sqrt(alt) ;//みかけの地平線E 2.12 / 60
    double s = 0.26699444444445 / Dist ;//視半径S (16.0 / 60.0 + 1.18 / 3600.0 )
    double r = 0.58555555555555 ; //大気差（日の出日の入り時のみ）R35 8
    
    double t1 = -18.0 - e + HP;
    double t2 = -12.0 - e + HP;
    double t3 = -6.0 - e + HP;
    double t4 = -s - e - r + HP;
    
    //status check
    
    if(_heightDeg <= t1) {
        _status = @"Night";
    } else if (_heightDeg > t4) {
        _status = @"Day  ";
    } else if (_heightDeg > t1 && _heightDeg <= t2) {
        _status = @"Astro";
    } else if (_heightDeg > t2 && _heightDeg <= t3) {
        _status = @"Natcl";
    } else if (_heightDeg > t3 && _heightDeg <= t4) {
        _status = @"Citzn";
    }
}

//月以外赤経、赤緯、距離計算
-(void)setRightAscensionDeclinationDistanceOfSun{

    double t = [self timeParameterWithDeltaT];
    
    if (t < aForSun || t > bForSun || calcdYearForSun != year) {
        
        calcdYearForSun = year;
        
        NSDictionary *constDic = [SunMoonCalc2Data dictionaryOfConstantArrayOfSunByYear:(int)year tWithDeltaT:t];
        
        RAArrayForSun = constDic[@"RAArray"];
        DecArrayForSun = constDic[@"DecArray"];
        DistArrayForSun = constDic[@"DistArray"];
        aForSun = [constDic[@"a"] doubleValue];
        bForSun = [constDic[@"b"] doubleValue];
    }


    
    if (RAArrayForSun.count == 0 || RAArrayForSun.count != DecArrayForSun.count || RAArrayForSun.count != DistArrayForSun.count) {
        
        return;//エラー処理未実装
    }
    
    
    double theta = acosd((2 * t - (aForSun + bForSun)) /(bForSun - aForSun));
    
    RA = 0;//hour
    Dec = 0;//degree
    Dist = 0;//AU
    
    for (int i = 0; i < RAArrayForSun.count; i++) {
        double j = cosd(i * theta);
        RA = RA + [RAArrayForSun[i] doubleValue] * j;
        Dec = Dec + [DecArrayForSun[i] doubleValue] * j;
        Dist = Dist + [DistArrayForSun[i] doubleValue] * j;
    }
}

-(double)setLocalHourAngleDegrees {

    double t = [self timeParameterWithoutDeltaT];
    
    if (t < aForR || t > bForR || calcdYearForR != year) {
        
        calcdYearForR = year;
        
        NSDictionary *constDicForR = [SunMoonCalc2Data dictionaryOfRbyYear:year tWithoutDeltaT:t];
        
        RArray = constDicForR[@"RArray"];

        aForR = [constDicForR[@"a"] doubleValue];
        bForR = [constDicForR[@"b"] doubleValue];
    }
    
    if (RArray.count == 0) {
        return 0;//エラー処理未実装
    }
    

    double theta = acosd((2 * t - (aForR + bForR)) /(bForR - aForR));
    
    double R = 0;//hour

    for (int i = 0; i < RArray.count; i++) {
        R = R + [RArray[i]doubleValue] * cosd(i * theta);
    }
    
    
    double hourAngle = R - RA + hour + minute / 60;
    
    return hourAngle * 360 / 24 + lon;

}

//観測当日の年月日から通日Tを求める（1/1を１日目とする）
-(double)dayFromNewyear{
    
    int p = month - 1;
    int y = floor((year / 4) - floor(year / 4) + 0.77);
    int q = floor((month + 7) / 10);
    int s = floor(p * 0.55 - 0.33);
    
//    NSLog(@"dayFromNewyear:%f",30 * p + q * (s - y) + p * (1 - q) + day);
    
    return 30 * p + q * (s - y) + p * (1 - q) + day;
    
}

//観測時刻のUTCを日の端数Fで表す
-(double)timeOfDay{
    
//    NSLog(@"timeOfDay:%f",hour / 24 + minute / 1440);
    return hour / 24 + minute / 1440;
    
}

//上記TとFから計算用の時刻引数tを求める
-(double)timeParameterWithDeltaT {
    
    double deltaT;
    
    switch ((int)year) {
        case 2016:
            deltaT = 68;
            break;
            
        default:
            deltaT = 68 + year - 2016;
            break;
    }
    
    
//    NSLog(@"timeParameter:%f",[self dayFromNewyear] + [self timeOfDay] + deltat / 86400);
    
    return [self dayFromNewyear] + [self timeOfDay] + deltaT / 86400;
    

    
}

-(double)timeParameterWithoutDeltaT {
    
//    NSLog(@"timeParameter:%f",[self dayFromNewyear] + [self timeOfDay]);
    
    return [self dayFromNewyear] + [self timeOfDay];
    
}

-(double) directionWithHourAngle:(double)ha
                       rightAscension:(double)ra {

    double dc = - cosd(ra) * sind(ha) ;
    double dm = sind(ra) * cosd(lat) - cosd(ra) * sind(lat) * cosd(ha) ;

    double dr = 0;
    if(dm == 0.0) {
        double st = sind(ha) ;
        if(st > 0.0) { dr = -90.0 ;}
        if(st == 0.0) { dr = 9999.0 ;}
        if(st < 0.0) {dr = 90.0 ;}
    }
    else {
        dr = atand(dc / dm);
        if(dm <0.0) {dr += 180.0 ;}
    }
    if(dr < 0.0) {dr += 360.0 ;}
    
//    NSLog(@"SolarDirection2:%f\n",dr);
    
    return dr ;
}

-(double) altitudeWithHourAngle:(double)ha
                      rightAscension:(double)ra {
    double h = sind(ra) * sind(lat) + cosd(ra) * cosd(lat) * cosd(ha) ;
    h = asind(h);
    
//    NSLog(@"SolarAltitude2:%f\n",h);
    
    return h;
}

-(void)calcMoon{

    [self setRightAscensionDeclinationHPOfMoon];
    
    double localHourAngleDeg = [self setLocalHourAngleDegrees];
    
    _directionDeg = [self directionWithHourAngle:localHourAngleDeg rightAscension:Dec];
    _heightDeg = [self altitudeWithHourAngle:localHourAngleDeg rightAscension:Dec];
    
    
    double e = 0.03533333333333 * sqrt(alt) ;//みかけの地平線E
    double r = 0.58555555555555 ; //大気差（地平線に近い時のみ）R
    
    double heightMoonOnHorizon = -r - e + HP;
    
    //status check
    
    if(_heightDeg < heightMoonOnHorizon) {
        _status = @"Under";
    } else {
        _status = @"Over ";
    }
    
}

-(void)setRightAscensionDeclinationHPOfMoon {
    
    double t = [self timeParameterWithDeltaT];
    
    if (t < aForMoon || t > bForMoon || calcdYearForMoon != year) {
        
        calcdYearForMoon = year;
        
        NSDictionary *constDic = [SunMoonCalc2Data dictionaryOfConstantArrayOfMoonByYear:(int)year tWithDeltaT:t];
        
        RAArrayForMoon = constDic[@"RAArray"];
        DecArrayForMoon = constDic[@"DecArray"];
        HPArrayForMoon = constDic[@"HPArray"];
        
        aForMoon = [constDic[@"a"] doubleValue];
        bForMoon = [constDic[@"b"] doubleValue];

    }
    
    
    if (RAArrayForMoon.count == 0 || RAArrayForMoon.count != DecArrayForMoon.count || RAArrayForMoon.count != HPArrayForMoon.count) {
        
        return;//エラー処理未実装
    }
    
    
    double theta = acosd((2 * t - (aForMoon + bForMoon)) /(bForMoon - aForMoon));
    
    RA = 0;//hour
    Dec = 0;//degree
    HP = 0;//degree
    
    for (int i = 0; i < RAArrayForMoon.count; i++) {
        double j = cosd(i * theta);
        RA = RA + [RAArrayForMoon[i] doubleValue] * j;
        Dec = Dec + [DecArrayForMoon[i] doubleValue] * j;
        HP = HP + [HPArrayForMoon[i] doubleValue] * j;
    }
    
    
}



@end
