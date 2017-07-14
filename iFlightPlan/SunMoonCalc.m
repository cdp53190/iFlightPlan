//
//  SunMoonCalc.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/03/23.
//  Copyright © 2016年 Another Sky. All rights reserved.
//





#import "SunMoonCalc.h"

@implementation SunMoonCalc
@synthesize yeard,monthd,dayd,hourd,minuted,lat,lon,alt;

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
        
    }
    
    return self;
    
}

static double sind(double d) {return sin(d * M_PI/180.0);}
static double cosd(double d) {return cos(d * M_PI/180.0);}
static double tand(double d) {return tan(d * M_PI/180.0);}
static double asind(double x) {return asin(x) * 180.0 / M_PI;}
//static double acosd(double x) {return acos(x) * 180 / M_PI;}
static double atand(double x) {return atan(x) * 180.0 / M_PI;}

// calculate Julius year (year from 2000/1/1, for variable "t") jy
+(double) juliusYearWithYear:(double)year
                       Month:(double)month
                         Day:(double)day
                      Minute:(double)minute{
    
    year -= 2000.0 ;
    
    if(month <= 2.0) {
        month += 12.0 ;
        year--;
    }
    
    double k = 365.0 * year + 30.0 * month + day - 33.5 + floor(3.0 * (month + 1.0) / 5.0)
    + floor(year / 4.0) - floor(year / 100.0) + floor(year / 400.0);
    k += minute / 60.0 / 24.0 ; // plus time
    k += (65.0 + year) / 86400.0 ; // plus delta T
    
//    NSLog(@"JuliusYear:%f\n",k / 365.25);
    
    return k / 365.25 ;
}

// solar position1 (celestial longitude, degree)太陽黄経λs(p71)
+(double) solarCelestialLongitudeAtJuliusYear:(double)time {
    double l = 280.4603 + 360.00769 * time
    + (1.9146 - 0.00005 * time) * sind(357.538 + 359.991 * time)
    + 0.0200 * sind(355.05 +  719.981 * time)
    + 0.0048 * sind(234.95 +   19.341 * time)
    + 0.0020 * sind(247.1  +  329.640 * time)
    + 0.0018 * sind(297.8  + 4452.67  * time)
    + 0.0018 * sind(251.3  +    0.20  * time)
    + 0.0015 * sind(343.2  +  450.37  * time)
    + 0.0013 * sind( 81.4  +  225.18  * time)
    + 0.0008 * sind(132.5  +  659.29  * time)
    + 0.0007 * sind(153.3  +   90.38  * time)
    + 0.0007 * sind(206.8  +   30.35  * time)
    + 0.0006 * sind( 29.8  +  337.18  * time)
    + 0.0005 * sind(207.4  +    1.50  * time)
    + 0.0005 * sind(291.2  +   22.81  * time)
    + 0.0004 * sind(234.9  +  315.56  * time)
    + 0.0004 * sind(157.3  +  299.30  * time)
    + 0.0004 * sind( 21.1  +  720.02  * time)
    + 0.0003 * sind(352.5  + 1079.97  * time)
    + 0.0003 * sind(329.7  +   44.43  * time);
    while(l >= 360.0) { l -= 360.0 ; }
    while(l < 0.0) { l += 360.0 ; }

    
//    NSLog(@"SolarCelestialLongitude:%f\n",l);
    
    return l ;
}





// solar position2 (distance, AU)太陽距離q(p71)
+(double) solarDistanceAUAtJuliusYear:(double)time { // time: Julius year
    double r = (0.007256 - 0.0000002 * time) * sind(267.54 + 359.991 * time)
    + 0.000091 * sind(265.1 +  719.98 * time)
    + 0.000030 * sind( 90.0)
    + 0.000013 * sind( 27.8 + 4452.67 * time)
    + 0.000007 * sind(254.0 +  450.4  * time)
    + 0.000007 * sind(156.0 +  329.6  * time);
    
//    NSLog(@"SolarDistanceAU:%f\n",pow(10,r));
    
    return pow(10, r) ;
}

// solar position3 (declination, degree)太陽の赤経を計算する。(p74)
+(double) solarDeclinationAtJuliusYear:(double)time { // time: Julius year
    double ls = [self solarCelestialLongitudeAtJuliusYear:time] ;//太陽の黄経
    double ep = 23.439291 - 0.000130042 * time ;
    double al = atand(tand(ls) * cosd(ep));
    if((ls >= 0.0)&&(ls < 180.0)) {
        while(al < 0.0) { al += 180.0 ; }
        while(al >= 180.0) { al -= 180.0 ; } }
    else {
        while(al < 180.0) { al += 180.0 ; }
        while(al >= 360.0) { al -= 180.0 ; } }
    
//    NSLog(@"SolarDeclination:%f\n",al);
    
    return al ;
}

// solar position4 (the right ascension, degree)太陽の赤緯を計算する。(p74）
+(double) solarRightAscensionAtJuliusYear:(double)time {
    double ls = [self solarCelestialLongitudeAtJuliusYear:time] ;//太陽の黄経
    double ep = 23.439291 - 0.000130042 * time ;//黄道偏角ε(p74)
    double dl = asind(sind(ls) * sind(ep));
    while(dl >= 360.0) { dl -= 360.0 ; }
    while(dl < 0.0) { dl += 360.0 ; }
    
//    NSLog(@"SolarRightAscension:%f\n",dl);
    
    return dl ;
}


// Calculate sidereal hour (degree)恒星時の計算Θ
+(double) siderealHourWithJuliusYear:(double)time
                              Minute:(double)minute
                           longitude:(double)lon{
    double d = minute / 60.0 / 24.0 ; // elapsed day (from 0:00 a.m.)
    double th = 100.4606 + 360.007700536 * time + 0.00000003879 * time * time
    + lon + 360.0 * d ;
    while(th >= 360.0) { th -= 360.0 ; }
    while(th < 0.0) { th += 360.0 ; }
    
//    NSLog(@"SiderealHour:%f\n",th);
    
    return th ;
}



// Calculating solar alititude (degree) 視差などは考慮しない
+(double) solarAltitudeWithLatitude:(double)la // latitude
                       siderealHour:(double)th
                   solarDeclination:(double)al
                     rightAscension:(double)dl {
    double h = sind(dl) * sind(la) + cosd(dl) * cosd(la) * cosd(th - al) ;
    h = asind(h);
    
//    NSLog(@"SolarAltitude:%f\n",h);
    
    return h;
}

// Calculating solar direction (degree)
+(double) solarDirectionWithLatitude:(double)la
                        siderealHour:(double)th
                    solarDeclination:(double)al
                      rightAscension:(double)dl {
    double t = th - al ; //時角
    
    double dc = - cosd(dl) * sind(t) ;
    double dm = sind(dl) * cosd(la) - cosd(dl) * sind(la) * cosd(t) ;
    
    double dr = 0;
    if(dm == 0.0) {
        double st = sind(t) ;
        if(st > 0.0) { dr = -90.0 ;}
        if(st == 0.0) { dr = 9999.0 ;}
        if(st < 0.0) {dr = 90.0 ;}
    }
    else {
        dr = atand(dc / dm);
        if(dm <0.0) {dr += 180.0 ;}
    }
    if(dr < 0.0) {dr += 360.0 ;}
    
//    NSLog(@"SolarDirection:%f\n",dr);
    
    return dr ;
}



-(void)calcSun{
    
    double time = hourd * 60 + minuted;
    
    double t = [SunMoonCalc juliusYearWithYear:yeard
                                         Month:monthd
                                           Day:dayd
                                        Minute:time];//ユリウス時
    
    double th = [SunMoonCalc siderealHourWithJuliusYear:t
                                                 Minute:time
                                              longitude:lon];//恒星時
    
    double ds = [SunMoonCalc solarDistanceAUAtJuliusYear:t] ;//太陽距離
    double alp = [SunMoonCalc solarDeclinationAtJuliusYear:t] ;//赤経
    double dlt = [SunMoonCalc solarRightAscensionAtJuliusYear:t] ;//赤緯
        
    _heightDeg = [SunMoonCalc solarAltitudeWithLatitude:lat
                                           siderealHour:th
                                       solarDeclination:alp
                                         rightAscension:dlt];//高度計算（視差等なし）
    _directionDeg = [SunMoonCalc solarDirectionWithLatitude:lat
                                            siderealHour:th
                                        solarDeclination:alp
                                          rightAscension:dlt];//方向計算
    
    double shisa = 0.00244281888889 / ds;//赤道地平視差(Π) 8.794148 / 3600。
    
    double e = 0.03533333333333 * sqrt(alt * .3048) ;//みかけの地平線E 2.12 / 60
    double s = 0.26699444444445 / ds ;//視半径S (16.0 / 60.0 + 1.18 / 3600.0 )
    double r = 0.58555555555555 ; //大気差（日の出日の入り時のみ）R35 8
    
    double t1 = -18.0 - e + shisa;
    double t2 = -12.0 - e + shisa;
    double t3 = -6.0 - e + shisa;
    double t4 = -s - e - r + shisa;
    
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






//月の黄経
+(double)moonCelestialLongitudeAtJuliusYear:(double)time {
    
    double l = 218.3161 + 4812.67881 * time
    + 6.2887 * sind(134.961 + 4771.9886 * time +
                      0.0040 * sind(119.5 + 1.33 * time)
                    + 0.0020 * sind(55.0 + 19.34 * time)
                    + 0.0006 * sind(71.0 +  0.2  * time)
                    + 0.0006 * sind(54.0 + 19.3  * time))
    + 1.2740 * sind(100.738 +  4133.3536 * time)
    + 0.6583 * sind(235.700 +  8905.3422 * time)
    + 0.2136 * sind(269.926 +  9543.9773 * time)
    + 0.1856 * sind(177.525 +   359.9905 * time)
    + 0.1143 * sind(  6.546 +  9664.0404 * time)
    + 0.0588 * sind(214.22  +   638.635  * time)
    + 0.0572 * sind(103.21  +  3773.363  * time)
    + 0.0533 * sind( 10.66  + 13677.331  * time)
    + 0.0459 * sind(238.18  +  8545.352  * time)
    + 0.0410 * sind(137.43  +  4411.998  * time)
    + 0.0348 * sind(117.84  +  4452.671  * time)
    + 0.0305 * sind(312.49  +  5131.979  * time)
    + 0.0153 * sind(130.84  +   758.698  * time)
    + 0.0125 * sind(141.51  + 14436.029  * time)
    + 0.0110 * sind(231.59  +  4892.052  * time)
    + 0.0107 * sind(336.44  + 13038.696  * time)
    + 0.0100 * sind( 44.89  + 14315.966  * time)
    + 0.0085 * sind(201.5   +  8266.71   * time)
    + 0.0079 * sind(278.2   +  4493.34   * time)
    + 0.0068 * sind( 53.2   +  9265.33   * time)
    + 0.0052 * sind(197.2   +   319.32   * time)
    + 0.0050 * sind(295.4   +  4812.66   * time)
    + 0.0048 * sind(235.0   +    19.34   * time)
    + 0.0040 * sind( 13.2   + 13317.34   * time)
    + 0.0040 * sind(145.6   + 18449.32   * time)
    + 0.0040 * sind(119.5   +     1.33   * time)
    + 0.0039 * sind(111.3   + 17810.68   * time)
    + 0.0037 * sind(349.1   +  5410.62   * time)
    + 0.0027 * sind(272.5   +  9183.99   * time)
    + 0.0026 * sind(107.2   + 13797.39   * time)
    + 0.0024 * sind(211.9   +   988.63   * time)
    + 0.0024 * sind(252.8   +  9224.66   * time)
    + 0.0022 * sind(240.6   +  8185.36   * time)
    + 0.0021 * sind( 87.5   +  9903.97   * time)
    + 0.0021 * sind(175.1   +   719.98   * time)
    + 0.0021 * sind(105.6   +  3413.37   * time)
    + 0.0020 * sind( 55.0   +    19.34   * time)
    + 0.0018 * sind(  4.1   +  4013.29   * time)
    + 0.0016 * sind(242.2   + 18569.38   * time)
    + 0.0012 * sind(339.0   + 12678.71   * time)
    + 0.0011 * sind(276.5   + 19208.02   * time)
    + 0.0009 * sind(218.0   +  8586.0    * time)
    + 0.0008 * sind(188.0   + 14037.3    * time)
    + 0.0008 * sind(204.0   +  7906.7    * time)
    + 0.0007 * sind(140.0   +  4052.0    * time)
    + 0.0007 * sind(275.0   +  4853.3    * time)
    + 0.0007 * sind(216.0   +   278.6    * time)
    + 0.0006 * sind(128.0   +  1118.7    * time)
    + 0.0005 * sind(247.0   + 22582.7    * time)
    + 0.0005 * sind(181.0   + 19088.0    * time)
    + 0.0005 * sind(114.0   + 17450.7    * time)
    + 0.0005 * sind(332.0   +  5091.3    * time)
    + 0.0004 * sind(313.0   +   398.7    * time)
    + 0.0004 * sind(278.0   +   120.1    * time)
    + 0.0004 * sind( 71.0   +  9584.7    * time)
    + 0.0004 * sind( 20.0   +   720.0    * time)
    + 0.0003 * sind( 83.0   +  3814.0    * time)
    + 0.0003 * sind( 66.0   +  3494.7    * time)
    + 0.0003 * sind(147.0   + 18089.3    * time)
    + 0.0003 * sind(311.0   +  5492.0    * time)
    + 0.0003 * sind(161.0   +    40.7    * time)
    + 0.0003 * sind(280.0   + 23221.3    * time);
    while(l >= 360.0) { l -= 360.0 ; }
    while(l < 0.0) { l += 360.0 ; }
    return l ;
    
}


//月の黄緯

+(double)moonCelestialLatitudeAtJuliusYear:(double)time {
    
    double l = 5.1282 * sind( 93.273 + 4832.0202 * time +
                             0.0267 * sind(234.95 + 19.341 * time)
                             + 0.0043 * sind(322.1  + 19.36  * time)
                             + 0.0040 * sind(119.5  +  1.33  * time)
                             + 0.0020 * sind( 55.0  + 19.34  * time)
                             + 0.0005 * sind(307.0  + 19.4   * time))
    + 0.2806 * sind(228.235 +  9604.0088 * time)
    + 0.2777 * sind(138.311 +    60.0316 * time)
    + 0.1732 * sind(142.427 +  4073.3220 * time)
    + 0.0554 * sind(194.01  +  8965.374  * time)
    + 0.0463 * sind(172.55  +   698.667  * time)
    + 0.0326 * sind(328.96  + 13737.362  * time)
    + 0.0172 * sind(  3.18  + 14375.997  * time)
    + 0.0093 * sind(277.4   +  8845.31   * time)
    + 0.0088 * sind(176.7   +  4711.96   * time)
    + 0.0082 * sind(144.9   +  3713.33   * time)
    + 0.0043 * sind(307.6   +  5470.66   * time)
    + 0.0042 * sind(103.9   + 18509.35   * time)
    + 0.0034 * sind(319.9   +  4433.31   * time)
    + 0.0025 * sind(196.5   +  8605.38   * time)
    + 0.0022 * sind(331.4   + 13377.37   * time)
    + 0.0021 * sind(170.1   +  1058.66   * time)
    + 0.0019 * sind(230.7   +  9244.02   * time)
    + 0.0018 * sind(243.3   +  8206.68   * time)
    + 0.0018 * sind(270.8   +  5192.01   * time)
    + 0.0017 * sind( 99.8   + 14496.06   * time)
    + 0.0016 * sind(135.7   +   420.02   * time)
    + 0.0015 * sind(211.1   +  9284.69   * time)
    + 0.0015 * sind( 45.8   +  9964.00   * time)
    + 0.0014 * sind(219.2   +   299.96   * time)
    + 0.0013 * sind( 95.8   +  4472.03   * time)
    + 0.0013 * sind(155.4   +   379.35   * time)
    + 0.0012 * sind( 38.4   +  4812.68   * time)
    + 0.0012 * sind(148.2   +  4851.36   * time)
    + 0.0011 * sind(138.3   + 19147.99   * time)
    + 0.0010 * sind( 18.0   + 12978.66   * time)
    + 0.0008 * sind( 70.0   + 17870.7    * time)
    + 0.0008 * sind(326.0   +  9724.1    * time)
    + 0.0007 * sind(294.0   + 13098.7    * time)
    + 0.0006 * sind(224.0   +  5590.7    * time)
    + 0.0006 * sind( 52.0   + 13617.3    * time)
    + 0.0005 * sind(280.0   +  8485.3    * time)
    + 0.0005 * sind(239.0   +  4193.4    * time)
    + 0.0004 * sind(311.0   +  9483.9    * time)
    + 0.0004 * sind(238.0   + 23281.3    * time)
    + 0.0004 * sind( 81.0   + 10242.6    * time)
    + 0.0004 * sind( 13.0   +  9325.4    * time)
    + 0.0004 * sind(147.0   + 14097.4    * time)
    + 0.0003 * sind(205.0   + 22642.7    * time)
    + 0.0003 * sind(107.0   + 18149.4    * time)
    + 0.0003 * sind(146.0   +  3353.3    * time)
    + 0.0003 * sind(234.0   + 19268.0    * time);
    
    while(l >= 360.0) { l -= 360.0 ; }
    while(l < 0.0) { l += 360.0 ; }
    return l ;
}

//月の赤道地平視差

+(double)moonShisaAtJuliusYear:(double)time {
    
    double sa = 0.9507
    + 0.0518 * sind(224.98 +  4771.989 * time)
    + 0.0095 * sind(190.7  +  4133.35 * time)
    + 0.0078 * sind(325.7  +  8905.34 * time)
    + 0.0028 * sind(  0.0  +  9543.98 * time)
    + 0.0009 * sind(100.0  + 13677.3  * time)
    + 0.0005 * sind(329.0  +  8545.4  * time)
    + 0.0004 * sind(194.0  +  3773.4  * time)
    + 0.0003 * sind(227.0  +  4412.0  * time);
    
    return sa;
}

//(汎用)黄緯、黄経から、赤緯、赤経に変換する。(p131)

+(NSArray *)arrayOfRightAscensionDeclinationByJuliusYear:(double)time
                                         EclipticLatitude:(double)csLat
                                        EclipticLongitude:(double)csLon {
    
    double ep = 23.439291 - 0.000130042 * time ;//黄道偏角ε(p74)
    double u = cosd(csLat) * cosd(csLon);
    double v = -sind(csLat) * sind(ep) + cosd(csLat) * sind(csLon) * cosd(ep);
    double w = sind(csLat) * cosd(ep) + cosd(csLat) * sind(csLon) * sind(ep);
    
    double redLon = atand(v / u);
    if (u < 0) {
        redLon += 180.0;
    }
    if (redLon < 0.0) { redLon += 360.0;}
    
    double redLat = atand(w / sqrt(u * u + v * v));
    
    return @[[NSNumber numberWithDouble:redLat], [NSNumber numberWithDouble:redLon]];
    
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



-(void)calcMoon {
    
    double time = hourd * 60.0 + minuted;
    
    double t = [SunMoonCalc juliusYearWithYear:yeard
                                         Month:monthd
                                           Day:dayd
                                        Minute:time];//ユリウス時
    
    double th = [SunMoonCalc siderealHourWithJuliusYear:t
                                                 Minute:time
                                              longitude:lon];//恒星時
    double csLat = [SunMoonCalc moonCelestialLatitudeAtJuliusYear:t];//月の黄緯
    double csLon = [SunMoonCalc moonCelestialLongitudeAtJuliusYear:t];//月の黄経
    
    NSArray *redArray = [SunMoonCalc arrayOfRightAscensionDeclinationByJuliusYear:t
                                                                      EclipticLatitude:csLat
                                                                     EclipticLongitude:csLon];//赤緯、赤経に変換
    
    double alp = [[redArray objectAtIndex:1] doubleValue]; ;//赤経
    double dlt = [[redArray objectAtIndex:0] doubleValue];//赤緯
    
    _heightDeg = [SunMoonCalc solarAltitudeWithLatitude:lat
                                        siderealHour:th
                                    solarDeclination:alp
                                      rightAscension:dlt]
                - [SunMoonCalc moonShisaAtJuliusYear:t];//赤道地平偏差(Π)。高度計算（視差等なし）
    
    _directionDeg = [SunMoonCalc solarDirectionWithLatitude:lat
                                            siderealHour:th
                                        solarDeclination:alp
                                          rightAscension:dlt];//方向計算
    
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


-(double) moonPhase {
    
    double deltaRamda,oldDeltaRamda;
    double moonPhase = 0.0;
    
    oldDeltaRamda = 9999.9;
    
    do {

        //tの計算
        double time = hourd * 60.0 + minuted;
        
        double t = [SunMoonCalc juliusYearWithYear:yeard
                                             Month:monthd
                                               Day:dayd
                                            Minute:time];//ユリウス時

        //太陽黄経
        double csSun = [SunMoonCalc solarCelestialLongitudeAtJuliusYear:t];
        
        
        //月赤緯赤経
        double csMoon = [SunMoonCalc moonCelestialLongitudeAtJuliusYear:t];
        
        deltaRamda = csMoon - csSun;
        
        if (deltaRamda < 0.0) {deltaRamda += 360.0;}
        
        if (ABS(deltaRamda) > ABS(oldDeltaRamda)) {deltaRamda -= 360.0;}
        
        double g = deltaRamda / 12.1908;
        moonPhase += g;
        minuted -= g * 24.0 * 60.0;
        
        oldDeltaRamda = deltaRamda;
        
    } while (deltaRamda > 0.05 || deltaRamda < 0.0);
    
    return moonPhase;
}


@end


