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

@synthesize yeard,monthd,dayd,hourd,minuted,lat,lon,alt;

#pragma mark - C Function

static double sind(double d) {return sin(d * M_PI/180.0);}
static double cosd(double d) {return cos(d * M_PI/180.0);}
//static double tand(double d) {return tan(d * M_PI/180);}
static double asind(double x) {return asin(x) * 180.0 / M_PI;}
static double acosd(double x) {return acos(x) * 180.0 / M_PI;}
static double atand(double x) {return atan(x) * 180.0 / M_PI;}

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

        yeard = (double)aYear;
        monthd = (double)aMonth;
        dayd = (double)aDay;
        hourd = (double)aHour;
        minuted = (double)aMinute;
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
    
    _directionDeg = [self directionWithHourAngle:localHourAngleDeg declination:Dec];
    _heightDeg = [self altitudeWithHourAngle:localHourAngleDeg declination:Dec];
    
    double p = 0.00244281888889 / Dist;//赤道地平視差(Π) 8.794148 / 3600
    double e = 0.03533333333333 * sqrt(alt * .3048) ;//みかけの地平線E 2.12 / 60
    double s = 0.26699444444445 / Dist ;//視半径S (16.0 / 60.0 + 1.18 / 3600.0 )
    double r = 0.58555555555555 ; //大気差（日の出日の入り時のみ）R35 8
    
    double t1 = -18.0 - e + p;
    double t2 = -12.0 - e + p;
    double t3 = -6.0 - e + p;
    double t4 = -s - e - r + p;
    
    //NSLog(@"TIME:%f:%f DIR:%f ALT:%f",hourd, minuted, _directionDeg,_heightDeg);
    
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
    
    if (t < aForSun || t > bForSun || calcdYearForSun != yeard) {
        
        calcdYearForSun = yeard;
        
        NSDictionary *constDic = [SunMoonCalc2Data dictionaryOfConstantArrayOfSunByYear:(int)yeard tWithDeltaT:t];
        
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
        double j = cosd((double)i * theta);
        RA += [RAArrayForSun[i] doubleValue] * j;
        Dec += [DecArrayForSun[i] doubleValue] * j;
        Dist += [DistArrayForSun[i] doubleValue] * j;
    }
}

-(double)setLocalHourAngleDegrees {

    double t = [self timeParameterWithoutDeltaT];
    
    if (t < aForR || t > bForR || calcdYearForR != yeard) {
        
        calcdYearForR = yeard;
        
        NSDictionary *constDicForR = [SunMoonCalc2Data dictionaryOfRbyYear:(int)yeard tWithoutDeltaT:t];
        
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
        R += [RArray[i] doubleValue] * cosd((double)i * theta);
    }
    
    
    double hourAngle = R - RA + hourd + minuted / 60.0;
    
    return hourAngle * 360.0 / 24.0 + lon;

}

//観測当日の年月日から通日Tを求める（1/1を１日目とする）
-(double)dayFromNewyear{
    
    double p = monthd - 1.0;
    double y = floor((yeard / 4.0) - floor(yeard / 4.0) + 0.77);
    double q = floor((monthd + 7.0) / 10.0);
    double s = floor(p * 0.55 - 0.33);
    
//    NSLog(@"dayFromNewyear:%f",30 * p + q * (s - y) + p * (1 - q) + day);
    
    return 30.0 * p + q * (s - y) + p * (1.0 - q) + dayd;
    
}

//観測時刻のUTCを日の端数Fで表す
-(double)timeOfDay{
    
//    NSLog(@"timeOfDay:%f",hour / 24 + minute / 1440);
    return hourd / 24.0 + minuted / 1440.0;
    
}

//上記TとFから計算用の時刻引数tを求める
-(double)timeParameterWithDeltaT {
    
    double deltaT;
    
    switch ((int)yeard) {
        case 2016:
            deltaT = 68.0;
            break;
            
        case 2017:
            deltaT = 68.0;
            break;
            
        default:
            deltaT = 68.0 + yeard - 2017.0;
            break;
    }
    
    
//    NSLog(@"timeParameter:%f",[self dayFromNewyear] + [self timeOfDay] + deltat / 86400);
    
    return [self dayFromNewyear] + [self timeOfDay] + deltaT / 86400.0;
    

    
}

-(double)timeParameterWithoutDeltaT {
    
//    NSLog(@"timeParameter:%f",[self dayFromNewyear] + [self timeOfDay]);
    
    return [self dayFromNewyear] + [self timeOfDay];
    
}

-(double) directionWithHourAngle:(double)ha
                     declination:(double)dec {

    double dc = - cosd(dec) * sind(ha) ;
    double dm = sind(dec) * cosd(lat) - cosd(dec) * sind(lat) * cosd(ha) ;

    double dr = 0;
    if(dm == 0.0) {
        double st = sind(ha) ;
        if(st > 0.0) { dr = -90.0 ;}
        if(st == 0.0) { dr = 0.0 ;}
        if(st < 0.0) {dr = 90.0 ;}
    } else {
        dr = atand(dc / dm);
        if(dm <0.0) {dr += 180.0 ;}
    }
    if(dr < 0.0) {dr += 360.0 ;}
    
//    NSLog(@"SolarDirection2:%f\n",dr);
    
    return dr ;
}

-(double) altitudeWithHourAngle:(double)ha
                    declination:(double)dec {
    
    double h = asind(sind(dec) * sind(lat) + cosd(dec) * cosd(lat) * cosd(ha)) ;
    
//    NSLog(@"SolarAltitude2:%f\n",h);
    
    return h;
}

-(void)calcMoon{

    [self setRightAscensionDeclinationHPOfMoon];
    

    
    //地心から測心に赤経赤緯を変換する。
    double sd = asind(0.2724 * sind(HP));//視半径(deg)
    Dist = 1737.4/sind(sd);//地心距離(km)1737.4は月半径
    
    //観測者の地心座標（含扁平率）
    double altKM = alt * 0.3048 / 1000.0;
    double kyokuritsu = 6378.137 / sqrt(1.0 - 0.00669438002290078 * pow(sind(lat),2.0));
                    //6378.137 = 赤道半径(KM), 0.0066 = 離心率
    double kansokuX = (kyokuritsu + altKM) * cosd(lat) * cosd(lon);
    double kansokuY = (kyokuritsu + altKM) * cosd(lat) * sind(lon);
    double kansokuZ = (kyokuritsu * (1.0 - 0.00669438002290078) + altKM) * sind(lat);
    
    
    //月の地心座標
    double RAdeg = RA / 24.0 * 360.0;
    double moonX = Dist * cosd(Dec) * cosd(RAdeg);
    double moonY = Dist * cosd(Dec) * sind(RAdeg);
    double moonZ = Dist * sind(Dec);
    
    //観測者から月までの距離と地心から天体までの距離の比
    
    double distRatio = (sqrt(pow(kansokuX - moonX , 2.0) +
                             pow(kansokuY - moonY , 2.0) +
                             pow(kansokuZ - moonZ , 2.0))) / Dist;

    //時角の変換
    double localHourAngleDeg = [self setLocalHourAngleDegrees];
    
    double dc = cosd(Dec) * sind(localHourAngleDeg);
    double dm = cosd(Dec) * cosd(localHourAngleDeg) - cosd(lat) * sind(HP) ;
    
    if(dm == 0.0) {
        double st = sind(localHourAngleDeg) ;
        if(st > 0.0) { localHourAngleDeg = 90.0 ;}
        if(st == 0.0) { localHourAngleDeg = 0.0 ;}
        if(st < 0.0) {localHourAngleDeg = -90.0 ;}
    } else {
        localHourAngleDeg = atand(dc / dm);
        if(dm < 0.0) {localHourAngleDeg += 180.0 ;}
    }
    if(localHourAngleDeg < 0.0) {localHourAngleDeg += 360.0 ;}
    

    //赤緯の変換
    Dec = asind((sind(Dec) - sind(lat) * sind(HP)) / distRatio);
    
    
    
    _directionDeg = [self directionWithHourAngle:localHourAngleDeg declination:Dec];
    _heightDeg = [self altitudeWithHourAngle:localHourAngleDeg declination:Dec];

    
    double e = 0.03533333333333 * sqrt(alt * .3048) ;//みかけの地平線E
    double r = 0.58555555555555 ; //大気差（地平線に近い時のみ）R
    
    double heightMoonOnHorizon = -r - e;

    //status check
    
    if(_heightDeg < heightMoonOnHorizon) {
        _status = @"Under";
    } else {
        _status = @"Over ";
    }
    
}

-(void)setRightAscensionDeclinationHPOfMoon {
    
    double t = [self timeParameterWithDeltaT];
    
    if (t < aForMoon || t > bForMoon || calcdYearForMoon != yeard) {
        
        calcdYearForMoon = yeard;
        
        NSDictionary *constDic = [SunMoonCalc2Data dictionaryOfConstantArrayOfMoonByYear:(int)yeard tWithDeltaT:t];
        
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
        double j = cosd((double)i * theta);
        RA += [RAArrayForMoon[i] doubleValue] * j;
        Dec += [DecArrayForMoon[i] doubleValue] * j;
        HP += [HPArrayForMoon[i] doubleValue] * j;
    }
    
    
}



-(double) moonPhase {
    
    double deltaRamda,oldDeltaRamda;
    double moonPhase = 0.0;
    
    oldDeltaRamda = 9999.9;
    
    do {
        //黄道傾角計算
        double t = [self timeParameterWithoutDeltaT];
        
        NSDictionary *constDic = [SunMoonCalc2Data dictionaryOfEbyYear:yeard tWithoutDeltaT:t];
        
        NSArray *EArray = constDic[@"EArray"];
        
        double a = [constDic[@"a"] doubleValue];
        double b = [constDic[@"b"] doubleValue];
        
        if (EArray.count == 0) {
            
            return moonPhase;//エラー処理未実装
        }
        
        
        double theta = acosd((2 * t - (a + b)) /(b - a));
        
        double E = 0;
        
        for (int i = 0; i < EArray.count; i++) {
            E += [EArray[i] doubleValue] * cosd((double)i * theta);
        }
        
        //太陽赤緯赤経
        [self setRightAscensionDeclinationDistanceOfSun];
        double RAofSun = RA;
        double DecOfSun = Dec;
        
        //月赤緯赤経
        [self setRightAscensionDeclinationHPOfMoon];
        double RAofMoon = RA;
        double DecOfMoon = Dec;
        
        
        deltaRamda = [[SunMoonCalc2 arrayOfEclipticLatitudeLongitudeByRightAscension:RAofMoon
                                                                         declination:DecOfMoon
                                                                             epsilon:E][1] doubleValue] -
                    [[SunMoonCalc2 arrayOfEclipticLatitudeLongitudeByRightAscension:RAofSun
                                                                        declination:DecOfSun
                                                                            epsilon:E][1] doubleValue];
        if (deltaRamda < 0.0) {deltaRamda += 360.0;}
        
        if (ABS(deltaRamda) > ABS(oldDeltaRamda)) {deltaRamda -= 360.0;}
        
        double g = deltaRamda / 12.1908;
        moonPhase += g;
        minuted -= g * 24.0 * 60.0;
        
        oldDeltaRamda = deltaRamda;
        
    } while (deltaRamda > 0.05 || deltaRamda < 0.0);
    
    return moonPhase;
}

//赤経赤緯から黄経黄緯に変換
+(NSArray *)arrayOfEclipticLatitudeLongitudeByRightAscension:(double)aRA
                                                   declination:(double)aDec
                                                       epsilon:(double)ep {
    
    double RADeg = aRA * 360.0 / 24.0;
    
    double ecLon = 0.0;
    
    double dc = sind(aDec) * sind(ep) + cosd(aDec) * sind(RADeg) * cosd(ep);
    double dm = cosd(aDec) * cosd(RADeg);
    
    if (dm == 0.0) {
        double sr = sind(RADeg);
        if (sr > 0.0) {ecLon = 90.0;}
        if (sr == 0.0) {ecLon = 0.0;}
        if (sr < 0.0) {ecLon = -90.0;}
    } else {
        ecLon = atand(dc / dm);
        if (dm < 0.0) { ecLon += 180.0;}
    }
    if(ecLon < 0.0) {ecLon += 360.0 ;}

    double ecLat = asind(sind(aDec) * cosd(ep) - cosd(aDec) * sind(RADeg) * sind(ep));
    
    return @[[NSNumber numberWithDouble:ecLat], [NSNumber numberWithDouble:ecLon]];
    
}

@end
