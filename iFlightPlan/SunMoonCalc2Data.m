//
//  SunMoonCalc2Data.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/04/04.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "SunMoonCalc2Data.h"

@implementation SunMoonCalc2Data


-(instancetype)initWithYear:(int)year {
    
    self = [super init];
    
    if (self) {
        _year = year;
    }
    
    return self;

}

+(BOOL) existDataOfYear:(int)year {
    
    switch (year) {
        case 2016:
            return YES;
        default:
            return NO;
    }
}


+(NSDictionary *)dictionaryOfConstantArrayOfSunByYear:(int)year
                                          tWithDeltaT:(double)t {
    NSArray *RAArray = [NSArray new];
    NSArray *DecArray = [NSArray new];
    NSArray *DistArray = [NSArray new];
    
    double a,b;
    
    switch (year) {
        case 2016:
            a = 0;
            b = 122;
            if (t >= a && t <= b) {
                RAArray = @[[NSNumber numberWithDouble:22.709946f],
                            [NSNumber numberWithDouble: 3.929156f],
                            [NSNumber numberWithDouble:-0.104210f],
                            [NSNumber numberWithDouble: 0.035603f],
                            [NSNumber numberWithDouble: 0.006782f],
                            [NSNumber numberWithDouble:-0.002388f],
                            [NSNumber numberWithDouble: 0.000079f],
                            [NSNumber numberWithDouble: 0.000030f],
                            [NSNumber numberWithDouble: 0.000010f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000057f],
                            [NSNumber numberWithDouble: 0.000007f],
                            [NSNumber numberWithDouble:-0.000063f],
                            [NSNumber numberWithDouble:-0.000005f],
                            [NSNumber numberWithDouble: 0.000027f],
                            [NSNumber numberWithDouble: 0.000002f],
                            [NSNumber numberWithDouble:-0.000007f],
                            [NSNumber numberWithDouble: 0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble:-5.76185f],
                             [NSNumber numberWithDouble:20.13610f],
                             [NSNumber numberWithDouble: 1.75722f],
                             [NSNumber numberWithDouble:-1.00904f],
                             [NSNumber numberWithDouble: 0.01263f],
                             [NSNumber numberWithDouble: 0.00828f],
                             [NSNumber numberWithDouble:-0.00390f],
                             [NSNumber numberWithDouble: 0.00065f],
                             [NSNumber numberWithDouble: 0.00011f],
                             [NSNumber numberWithDouble: 0.00003f],
                             [NSNumber numberWithDouble: 0.00026f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble:-0.00024f],
                             [NSNumber numberWithDouble:-0.00004f],
                             [NSNumber numberWithDouble: 0.00011f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble:-0.00003f],
                             [NSNumber numberWithDouble:-0.00001f]];
                
                DistArray = @[[NSNumber numberWithDouble: 0.993218f],
                              [NSNumber numberWithDouble: 0.012776f],
                              [NSNumber numberWithDouble: 0.002303f],
                              [NSNumber numberWithDouble:-0.000661f],
                              [NSNumber numberWithDouble:-0.000053f],
                              [NSNumber numberWithDouble: 0.000018f],
                              [NSNumber numberWithDouble: 0.000000f],
                              [NSNumber numberWithDouble: 0.000015f],
                              [NSNumber numberWithDouble: 0.000001f],
                              [NSNumber numberWithDouble: 0.000004f],
                              [NSNumber numberWithDouble: 0.000001f],
                              [NSNumber numberWithDouble:-0.000018f],
                              [NSNumber numberWithDouble:-0.000001f],
                              [NSNumber numberWithDouble: 0.000012f],
                              [NSNumber numberWithDouble: 0.000001f],
                              [NSNumber numberWithDouble:-0.000004f],
                              [NSNumber numberWithDouble:-0.000001f],
                              [NSNumber numberWithDouble: 0.000001f]];
                break;
            }
            
            a = 122;
            b = 244;
            if (t >= a && t <= b) {
                RAArray = @[[NSNumber numberWithDouble:22.709946f],
                            [NSNumber numberWithDouble: 3.929156f],
                            [NSNumber numberWithDouble:-0.104210f],
                            [NSNumber numberWithDouble: 0.035603f],
                            [NSNumber numberWithDouble: 0.006782f],
                            [NSNumber numberWithDouble:-0.002388f],
                            [NSNumber numberWithDouble: 0.000079f],
                            [NSNumber numberWithDouble: 0.000030f],
                            [NSNumber numberWithDouble: 0.000010f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000057f],
                            [NSNumber numberWithDouble: 0.000007f],
                            [NSNumber numberWithDouble:-0.000063f],
                            [NSNumber numberWithDouble:-0.000005f],
                            [NSNumber numberWithDouble: 0.000027f],
                            [NSNumber numberWithDouble: 0.000002f],
                            [NSNumber numberWithDouble:-0.000007f],
                            [NSNumber numberWithDouble: 0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble:-5.76185f],
                             [NSNumber numberWithDouble:20.13610f],
                             [NSNumber numberWithDouble: 1.75722f],
                             [NSNumber numberWithDouble:-1.00904f],
                             [NSNumber numberWithDouble: 0.01263f],
                             [NSNumber numberWithDouble: 0.00828f],
                             [NSNumber numberWithDouble:-0.00390f],
                             [NSNumber numberWithDouble: 0.00065f],
                             [NSNumber numberWithDouble: 0.00011f],
                             [NSNumber numberWithDouble: 0.00003f],
                             [NSNumber numberWithDouble: 0.00026f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble:-0.00024f],
                             [NSNumber numberWithDouble:-0.00004f],
                             [NSNumber numberWithDouble: 0.00011f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble:-0.00003f],
                             [NSNumber numberWithDouble:-0.00001f]];
                
                DistArray = @[[NSNumber numberWithDouble: 0.993218f],
                              [NSNumber numberWithDouble: 0.012776f],
                              [NSNumber numberWithDouble: 0.002303f],
                              [NSNumber numberWithDouble:-0.000661f],
                              [NSNumber numberWithDouble:-0.000053f],
                              [NSNumber numberWithDouble: 0.000018f],
                              [NSNumber numberWithDouble: 0.000000f],
                              [NSNumber numberWithDouble: 0.000015f],
                              [NSNumber numberWithDouble: 0.000001f],
                              [NSNumber numberWithDouble: 0.000004f],
                              [NSNumber numberWithDouble: 0.000001f],
                              [NSNumber numberWithDouble:-0.000018f],
                              [NSNumber numberWithDouble:-0.000001f],
                              [NSNumber numberWithDouble: 0.000012f],
                              [NSNumber numberWithDouble: 0.000001f],
                              [NSNumber numberWithDouble:-0.000004f],
                              [NSNumber numberWithDouble:-0.000001f],
                              [NSNumber numberWithDouble: 0.000001f]];
                
                break;
            }
            
            break;
        default:
            break;
    }
    
    return @{@"RAArray":RAArray,@"DecArray":DecArray,@"DistArray":DistArray,
             @"a":[NSNumber numberWithDouble:a],@"b":[NSNumber numberWithDouble:b]};
    
}


+(NSDictionary *)dictionaryOfConstantArrayOfMoonByYear:(int)year
                                           tWithDeltaT:(double)t {
    NSArray *RAArray = [NSArray new];
    NSArray *DecArray = [NSArray new];
    NSArray *HPArray = [NSArray new];
    double a,b;
    
    switch (year) {
        case 2016:
            
            a = 91;
            b = 122;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 8.148711],
                            [NSNumber numberWithDouble:13.607139],
                            [NSNumber numberWithDouble:-0.419910],
                            [NSNumber numberWithDouble: 0.072784],
                            [NSNumber numberWithDouble: 0.215293],
                            [NSNumber numberWithDouble:-0.020593],
                            [NSNumber numberWithDouble:-0.074060],
                            [NSNumber numberWithDouble: 0.004489],
                            [NSNumber numberWithDouble: 0.021925],
                            [NSNumber numberWithDouble:-0.005758],
                            [NSNumber numberWithDouble:-0.003816],
                            [NSNumber numberWithDouble: 0.003692],
                            [NSNumber numberWithDouble: 0.000024],
                            [NSNumber numberWithDouble:-0.001352],
                            [NSNumber numberWithDouble: 0.000330],
                            [NSNumber numberWithDouble: 0.000339],
                            [NSNumber numberWithDouble:-0.000203],
                            [NSNumber numberWithDouble:-0.000049],
                            [NSNumber numberWithDouble: 0.000087],
                            [NSNumber numberWithDouble:-0.000009],
                            [NSNumber numberWithDouble:-0.000029],
                            [NSNumber numberWithDouble: 0.000011],
                            [NSNumber numberWithDouble: 0.000007],
                            [NSNumber numberWithDouble:-0.000006],
                            [NSNumber numberWithDouble: 0.000000],
                            [NSNumber numberWithDouble: 0.000002],
                            [NSNumber numberWithDouble:-0.000001],
                            [NSNumber numberWithDouble:-0.000001],
                            [NSNumber numberWithDouble: 0.000000],
                            [NSNumber numberWithDouble: 0.000000]];
                
                DecArray = @[[NSNumber numberWithDouble: -6.68449],
                             [NSNumber numberWithDouble: -2.30253],
                             [NSNumber numberWithDouble:-14.31544],
                             [NSNumber numberWithDouble:  7.29169],
                             [NSNumber numberWithDouble:  6.41897],
                             [NSNumber numberWithDouble: -2.29533],
                             [NSNumber numberWithDouble: -0.34866],
                             [NSNumber numberWithDouble:  0.54672],
                             [NSNumber numberWithDouble: -0.22392],
                             [NSNumber numberWithDouble: -0.08461],
                             [NSNumber numberWithDouble:  0.09232],
                             [NSNumber numberWithDouble: -0.00459],
                             [NSNumber numberWithDouble: -0.02267],
                             [NSNumber numberWithDouble:  0.00854],
                             [NSNumber numberWithDouble:  0.00345],
                             [NSNumber numberWithDouble: -0.00358],
                             [NSNumber numberWithDouble:  0.00005],
                             [NSNumber numberWithDouble:  0.00101],
                             [NSNumber numberWithDouble: -0.00028],
                             [NSNumber numberWithDouble: -0.00021],
                             [NSNumber numberWithDouble:  0.00014],
                             [NSNumber numberWithDouble:  0.00003],
                             [NSNumber numberWithDouble: -0.00005],
                             [NSNumber numberWithDouble:  0.00000],
                             [NSNumber numberWithDouble:  0.00002],
                             [NSNumber numberWithDouble:  0.00000],
                             [NSNumber numberWithDouble:  0.00000],
                             [NSNumber numberWithDouble:  0.00000],
                             [NSNumber numberWithDouble:  0.00000],
                             [NSNumber numberWithDouble:  0.00000]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.950906],
                            [NSNumber numberWithDouble:-0.018775],
                            [NSNumber numberWithDouble: 0.001512],
                            [NSNumber numberWithDouble: 0.046283],
                            [NSNumber numberWithDouble:-0.008132],
                            [NSNumber numberWithDouble:-0.007730],
                            [NSNumber numberWithDouble: 0.006940],
                            [NSNumber numberWithDouble:-0.000913],
                            [NSNumber numberWithDouble:-0.001917],
                            [NSNumber numberWithDouble: 0.000894],
                            [NSNumber numberWithDouble: 0.000090],
                            [NSNumber numberWithDouble:-0.000280],
                            [NSNumber numberWithDouble: 0.000110],
                            [NSNumber numberWithDouble: 0.000029],
                            [NSNumber numberWithDouble:-0.000046],
                            [NSNumber numberWithDouble: 0.000013],
                            [NSNumber numberWithDouble: 0.000008],
                            [NSNumber numberWithDouble:-0.000007],
                            [NSNumber numberWithDouble: 0.000001],
                            [NSNumber numberWithDouble: 0.000002],
                            [NSNumber numberWithDouble:-0.000001],
                            [NSNumber numberWithDouble: 0.000000],
                            [NSNumber numberWithDouble: 0.000000],
                            [NSNumber numberWithDouble: 0.000000],
                            [NSNumber numberWithDouble: 0.000000],
                            [NSNumber numberWithDouble: 0.000000],
                            [NSNumber numberWithDouble: 0.000000],
                            [NSNumber numberWithDouble: 0.000000],
                            [NSNumber numberWithDouble: 0.000000],
                            [NSNumber numberWithDouble: 0.000000]];
                             
                             
    
                
            }
            
            break;
            
        default:
            break;
    }
    
    return @{@"RAArray":RAArray,@"DecArray":DecArray,@"HPArray":HPArray,
             @"a":[NSNumber numberWithDouble:a],@"b":[NSNumber numberWithDouble:b]};
    
}


+(NSDictionary *)dictionaryOfRbyYear:(int)year
                      tWithoutDeltaT:(double)t {
    NSArray *RArray = [NSArray new];
    double a,b;
    
    switch (year) {
        case 2016:
            if (t >= 0 && t <= 122) {
                
                a = 0;
                b = 122;
                
                RArray = @[[NSNumber numberWithDouble:10.615288],
                           [NSNumber numberWithDouble: 4.008264],
                           [NSNumber numberWithDouble:-0.000011],
                           [NSNumber numberWithDouble: 0.000006],
                           [NSNumber numberWithDouble: 0.000000],
                           [NSNumber numberWithDouble: 0.000000],
                           [NSNumber numberWithDouble: 0.000001],
                           [NSNumber numberWithDouble: 0.000001]]; 
            }
            
            break;
            
        default:
            break;
    }
    
    return @{@"RArray":RArray,@"a":[NSNumber numberWithDouble:a],@"b":[NSNumber numberWithDouble:b]};
    
}


@end
