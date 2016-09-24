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
            
            a = 121;
            b = 245;
            if (t >= a && t <= b) {
                RAArray = @[[NSNumber numberWithDouble: 6.646638f],
                            [NSNumber numberWithDouble: 4.134444f],
                            [NSNumber numberWithDouble:-0.043224f],
                            [NSNumber numberWithDouble:-0.040366f],
                            [NSNumber numberWithDouble: 0.005513f],
                            [NSNumber numberWithDouble: 0.003227f],
                            [NSNumber numberWithDouble:-0.000455f],
                            [NSNumber numberWithDouble:-0.000126f],
                            [NSNumber numberWithDouble: 0.000068f],
                            [NSNumber numberWithDouble: 0.000014f],
                            [NSNumber numberWithDouble: 0.000034f],
                            [NSNumber numberWithDouble:-0.000052f],
                            [NSNumber numberWithDouble:-0.000047f],
                            [NSNumber numberWithDouble: 0.000036f],
                            [NSNumber numberWithDouble: 0.000024f],
                            [NSNumber numberWithDouble:-0.000013f],
                            [NSNumber numberWithDouble:-0.000010f],
                            [NSNumber numberWithDouble: 0.000004f]];
                
                DecArray = @[[NSNumber numberWithDouble:17.14342f],
                             [NSNumber numberWithDouble:-3.53072f],
                             [NSNumber numberWithDouble:-5.78016f],
                             [NSNumber numberWithDouble: 0.22227f],
                             [NSNumber numberWithDouble: 0.15907f],
                             [NSNumber numberWithDouble:-0.01102f],
                             [NSNumber numberWithDouble:-0.00482f],
                             [NSNumber numberWithDouble: 0.00072f],
                             [NSNumber numberWithDouble: 0.00017f],
                             [NSNumber numberWithDouble:-0.00024f],
                             [NSNumber numberWithDouble: 0.00010f],
                             [NSNumber numberWithDouble: 0.00012f],
                             [NSNumber numberWithDouble: 0.00001f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble:-0.00003f],
                             [NSNumber numberWithDouble:-0.00002f],
                             [NSNumber numberWithDouble: 0.00001f],
                             [NSNumber numberWithDouble: 0.00002f]];
                
                DistArray = @[[NSNumber numberWithDouble: 1.012387f],
                              [NSNumber numberWithDouble: 0.000962f],
                              [NSNumber numberWithDouble:-0.004200f],
                              [NSNumber numberWithDouble:-0.000042f],
                              [NSNumber numberWithDouble: 0.000103f],
                              [NSNumber numberWithDouble: 0.000008f],
                              [NSNumber numberWithDouble: 0.000002f],
                              [NSNumber numberWithDouble: 0.000011f],
                              [NSNumber numberWithDouble:-0.000008f],
                              [NSNumber numberWithDouble: 0.000001f],
                              [NSNumber numberWithDouble:-0.000009f],
                              [NSNumber numberWithDouble:-0.000013f],
                              [NSNumber numberWithDouble: 0.000011f],
                              [NSNumber numberWithDouble: 0.000009f],
                              [NSNumber numberWithDouble:-0.000005f],
                              [NSNumber numberWithDouble:-0.000003f],
                              [NSNumber numberWithDouble: 0.000002f],
                              [NSNumber numberWithDouble: 0.000001f]];
                
                break;
            }
            
            a = 244;
            b = 367;
            if (t >= a && t <= b) {
                RAArray = @[[NSNumber numberWithDouble:14.573740f],
                            [NSNumber numberWithDouble: 4.056827f],
                            [NSNumber numberWithDouble: 0.152043f],
                            [NSNumber numberWithDouble: 0.012276f],
                            [NSNumber numberWithDouble:-0.013642f],
                            [NSNumber numberWithDouble:-0.002061f],
                            [NSNumber numberWithDouble: 0.000313f],
                            [NSNumber numberWithDouble: 0.000232f],
                            [NSNumber numberWithDouble: 0.000027f],
                            [NSNumber numberWithDouble: 0.000005f],
                            [NSNumber numberWithDouble:-0.000016f],
                            [NSNumber numberWithDouble:-0.000068f],
                            [NSNumber numberWithDouble: 0.000011f],
                            [NSNumber numberWithDouble: 0.000046f],
                            [NSNumber numberWithDouble:-0.000003f],
                            [NSNumber numberWithDouble:-0.000016f],
                            [NSNumber numberWithDouble:-0.000002f],
                            [NSNumber numberWithDouble: 0.000005f]];
                
                DecArray = @[[NSNumber numberWithDouble:-10.74731f],
                             [NSNumber numberWithDouble:-16.72801f],
                             [NSNumber numberWithDouble: 3.56163f],
                             [NSNumber numberWithDouble: 0.97177f],
                             [NSNumber numberWithDouble:-0.02860f],
                             [NSNumber numberWithDouble:-0.02380f],
                             [NSNumber numberWithDouble:-0.00514f],
                             [NSNumber numberWithDouble: 0.00001f],
                             [NSNumber numberWithDouble: 0.00037f],
                             [NSNumber numberWithDouble:-0.00003f],
                             [NSNumber numberWithDouble:-0.00009f],
                             [NSNumber numberWithDouble: 0.00023f],
                             [NSNumber numberWithDouble:-0.00001f],
                             [NSNumber numberWithDouble:-0.00017f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble: 0.00007f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble:-0.00003f]];
                
                DistArray = @[[NSNumber numberWithDouble: 0.994538f],
                              [NSNumber numberWithDouble:-0.013759f],
                              [NSNumber numberWithDouble: 0.001890f],
                              [NSNumber numberWithDouble: 0.000716f],
                              [NSNumber numberWithDouble:-0.000027f],
                              [NSNumber numberWithDouble:-0.000013f],
                              [NSNumber numberWithDouble: 0.000006f],
                              [NSNumber numberWithDouble:-0.000002f],
                              [NSNumber numberWithDouble:-0.000009f],
                              [NSNumber numberWithDouble: 0.000000f],
                              [NSNumber numberWithDouble:-0.000014f],
                              [NSNumber numberWithDouble: 0.000003f],
                              [NSNumber numberWithDouble: 0.000017f],
                              [NSNumber numberWithDouble:-0.000002f],
                              [NSNumber numberWithDouble:-0.000008f],
                              [NSNumber numberWithDouble: 0.000001f],
                              [NSNumber numberWithDouble: 0.000001f],
                              [NSNumber numberWithDouble: 0.000000f]];
                
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
            a = 0;
            b = 32;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  0.818858],
                            [NSNumber numberWithDouble: 14.068701],
                            [NSNumber numberWithDouble: -0.013869],
                            [NSNumber numberWithDouble: -0.330931],
                            [NSNumber numberWithDouble:  0.000773],
                            [NSNumber numberWithDouble: -0.001382],
                            [NSNumber numberWithDouble:  0.012981],
                            [NSNumber numberWithDouble:  0.054032],
                            [NSNumber numberWithDouble: -0.008647],
                            [NSNumber numberWithDouble: -0.023009],
                            [NSNumber numberWithDouble:  0.003159],
                            [NSNumber numberWithDouble:  0.006232],
                            [NSNumber numberWithDouble: -0.000657],
                            [NSNumber numberWithDouble: -0.000887],
                            [NSNumber numberWithDouble: -0.000074],
                            [NSNumber numberWithDouble: -0.000205],
                            [NSNumber numberWithDouble:  0.000143],
                            [NSNumber numberWithDouble:  0.000205],
                            [NSNumber numberWithDouble: -0.000075],
                            [NSNumber numberWithDouble: -0.000086],
                            [NSNumber numberWithDouble:  0.000024],
                            [NSNumber numberWithDouble:  0.000023],
                            [NSNumber numberWithDouble: -0.000004],
                            [NSNumber numberWithDouble: -0.000002],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble: -0.000001]];
                
                DecArray = @[[NSNumber numberWithDouble:  -1.45441],
                             [NSNumber numberWithDouble:   2.58812],
                             [NSNumber numberWithDouble:  -2.85448],
                             [NSNumber numberWithDouble: -14.11332],
                             [NSNumber numberWithDouble:   1.59808],
                             [NSNumber numberWithDouble:   4.00433],
                             [NSNumber numberWithDouble:  -0.33648],
                             [NSNumber numberWithDouble:  -0.74708],
                             [NSNumber numberWithDouble:   0.06297],
                             [NSNumber numberWithDouble:   0.08179],
                             [NSNumber numberWithDouble:  -0.00451],
                             [NSNumber numberWithDouble:   0.02388],
                             [NSNumber numberWithDouble:  -0.00393],
                             [NSNumber numberWithDouble:  -0.01802],
                             [NSNumber numberWithDouble:   0.00243],
                             [NSNumber numberWithDouble:   0.00655],
                             [NSNumber numberWithDouble:  -0.00079],
                             [NSNumber numberWithDouble:  -0.00155],
                             [NSNumber numberWithDouble:   0.00011],
                             [NSNumber numberWithDouble:   0.00014],
                             [NSNumber numberWithDouble:   0.00005],
                             [NSNumber numberWithDouble:   0.00008],
                             [NSNumber numberWithDouble:  -0.00004],
                             [NSNumber numberWithDouble:  -0.00006],
                             [NSNumber numberWithDouble:   0.00002],
                             [NSNumber numberWithDouble:   0.00002],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:  0.000000]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.931871],
                            [NSNumber numberWithDouble: -0.000869],
                            [NSNumber numberWithDouble: -0.039149],
                            [NSNumber numberWithDouble: -0.001179],
                            [NSNumber numberWithDouble:  0.018160],
                            [NSNumber numberWithDouble: -0.001868],
                            [NSNumber numberWithDouble: -0.000223],
                            [NSNumber numberWithDouble:  0.001339],
                            [NSNumber numberWithDouble: -0.000854],
                            [NSNumber numberWithDouble: -0.000463],
                            [NSNumber numberWithDouble:  0.000324],
                            [NSNumber numberWithDouble:  0.000121],
                            [NSNumber numberWithDouble: -0.000093],
                            [NSNumber numberWithDouble: -0.000022],
                            [NSNumber numberWithDouble:  0.000022],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble: -0.000004],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                
                break;
                
            }

            a = 31;
            b = 61;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  3.065129],
                            [NSNumber numberWithDouble: 13.274506],
                            [NSNumber numberWithDouble: -0.287213],
                            [NSNumber numberWithDouble: -0.244241],
                            [NSNumber numberWithDouble:  0.071596],
                            [NSNumber numberWithDouble:  0.021771],
                            [NSNumber numberWithDouble:  0.038440],
                            [NSNumber numberWithDouble:  0.005873],
                            [NSNumber numberWithDouble: -0.023381],
                            [NSNumber numberWithDouble:  0.000673],
                            [NSNumber numberWithDouble:  0.007128],
                            [NSNumber numberWithDouble: -0.001039],
                            [NSNumber numberWithDouble: -0.001439],
                            [NSNumber numberWithDouble:  0.000184],
                            [NSNumber numberWithDouble:  0.000170],
                            [NSNumber numberWithDouble:  0.000096],
                            [NSNumber numberWithDouble: -0.000014],
                            [NSNumber numberWithDouble: -0.000080],
                            [NSNumber numberWithDouble:  0.000010],
                            [NSNumber numberWithDouble:  0.000032],
                            [NSNumber numberWithDouble: -0.000006],
                            [NSNumber numberWithDouble: -0.000008],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000002],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];

                DecArray = @[[NSNumber numberWithDouble:  -4.64227],
                             [NSNumber numberWithDouble:   4.08022],
                             [NSNumber numberWithDouble: -11.46373],
                             [NSNumber numberWithDouble:  -9.59263],
                             [NSNumber numberWithDouble:   5.47845],
                             [NSNumber numberWithDouble:   2.00596],
                             [NSNumber numberWithDouble:  -1.23966],
                             [NSNumber numberWithDouble:  -0.17552],
                             [NSNumber numberWithDouble:   0.22848],
                             [NSNumber numberWithDouble:  -0.00953],
                             [NSNumber numberWithDouble:  -0.01518],
                             [NSNumber numberWithDouble:   0.00557],
                             [NSNumber numberWithDouble:  -0.00795],
                             [NSNumber numberWithDouble:   0.00108],
                             [NSNumber numberWithDouble:   0.00382],
                             [NSNumber numberWithDouble:  -0.00129],
                             [NSNumber numberWithDouble:  -0.00099],
                             [NSNumber numberWithDouble:   0.00047],
                             [NSNumber numberWithDouble:   0.00019],
                             [NSNumber numberWithDouble:  -0.00009],
                             [NSNumber numberWithDouble:  -0.00004],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00001],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:  -0.00001],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.934354],
                            [NSNumber numberWithDouble: -0.011768],
                            [NSNumber numberWithDouble: -0.039272],
                            [NSNumber numberWithDouble:  0.021448],
                            [NSNumber numberWithDouble:  0.012117],
                            [NSNumber numberWithDouble: -0.007404],
                            [NSNumber numberWithDouble:  0.001571],
                            [NSNumber numberWithDouble:  0.001975],
                            [NSNumber numberWithDouble: -0.001249],
                            [NSNumber numberWithDouble: -0.000312],
                            [NSNumber numberWithDouble:  0.000404],
                            [NSNumber numberWithDouble: -0.000012],
                            [NSNumber numberWithDouble: -0.000096],
                            [NSNumber numberWithDouble:  0.000029],
                            [NSNumber numberWithDouble:  0.000015],
                            [NSNumber numberWithDouble: -0.000012],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000003],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                
                break;
                
            }
            
            a = 60;
            b = 92;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  5.347510],
                            [NSNumber numberWithDouble: 14.085234],
                            [NSNumber numberWithDouble: -0.406154],
                            [NSNumber numberWithDouble: -0.120246],
                            [NSNumber numberWithDouble:  0.193229],
                            [NSNumber numberWithDouble:  0.052517],
                            [NSNumber numberWithDouble: -0.012457],
                            [NSNumber numberWithDouble: -0.029762],
                            [NSNumber numberWithDouble: -0.001654],
                            [NSNumber numberWithDouble:  0.012491],
                            [NSNumber numberWithDouble: -0.002210],
                            [NSNumber numberWithDouble: -0.003769],
                            [NSNumber numberWithDouble:  0.001580],
                            [NSNumber numberWithDouble:  0.000869],
                            [NSNumber numberWithDouble: -0.000540],
                            [NSNumber numberWithDouble: -0.000187],
                            [NSNumber numberWithDouble:  0.000145],
                            [NSNumber numberWithDouble:  0.000059],
                            [NSNumber numberWithDouble: -0.000045],
                            [NSNumber numberWithDouble: -0.000024],
                            [NSNumber numberWithDouble:  0.000019],
                            [NSNumber numberWithDouble:  0.000008],
                            [NSNumber numberWithDouble: -0.000008],
                            [NSNumber numberWithDouble: -0.000002],
                            [NSNumber numberWithDouble:  0.000003],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                DecArray = @[[NSNumber numberWithDouble:  -7.19091],
                             [NSNumber numberWithDouble:   0.14630],
                             [NSNumber numberWithDouble: -15.16389],
                             [NSNumber numberWithDouble:  -2.83137],
                             [NSNumber numberWithDouble:   8.39345],
                             [NSNumber numberWithDouble:   0.00119],
                             [NSNumber numberWithDouble:  -1.58831],
                             [NSNumber numberWithDouble:   0.44954],
                             [NSNumber numberWithDouble:   0.22438],
                             [NSNumber numberWithDouble:  -0.16784],
                             [NSNumber numberWithDouble:  -0.01066],
                             [NSNumber numberWithDouble:   0.03652],
                             [NSNumber numberWithDouble:  -0.00598],
                             [NSNumber numberWithDouble:  -0.00555],
                             [NSNumber numberWithDouble:   0.00170],
                             [NSNumber numberWithDouble:   0.00061],
                             [NSNumber numberWithDouble:  -0.00005],
                             [NSNumber numberWithDouble:  -0.00010],
                             [NSNumber numberWithDouble:  -0.00013],
                             [NSNumber numberWithDouble:   0.00006],
                             [NSNumber numberWithDouble:   0.00007],
                             [NSNumber numberWithDouble:  -0.00004],
                             [NSNumber numberWithDouble:  -0.00003],
                             [NSNumber numberWithDouble:   0.00002],
                             [NSNumber numberWithDouble:   0.00001],
                             [NSNumber numberWithDouble:  -0.00001],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.938919],
                            [NSNumber numberWithDouble: -0.011839],
                            [NSNumber numberWithDouble: -0.024481],
                            [NSNumber numberWithDouble:  0.040145],
                            [NSNumber numberWithDouble:  0.007316],
                            [NSNumber numberWithDouble: -0.011824],
                            [NSNumber numberWithDouble:  0.004456],
                            [NSNumber numberWithDouble:  0.002242],
                            [NSNumber numberWithDouble: -0.002481],
                            [NSNumber numberWithDouble:  0.000011],
                            [NSNumber numberWithDouble:  0.000690],
                            [NSNumber numberWithDouble: -0.000235],
                            [NSNumber numberWithDouble: -0.000113],
                            [NSNumber numberWithDouble:  0.000109],
                            [NSNumber numberWithDouble: -0.000008],
                            [NSNumber numberWithDouble: -0.000030],
                            [NSNumber numberWithDouble:  0.000014],
                            [NSNumber numberWithDouble:  0.000004],
                            [NSNumber numberWithDouble: -0.000006],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                
                break;
                
            }
            
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
                
                
                break;
                
            }

            a = 121;
            b = 153;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 10.973911],
                            [NSNumber numberWithDouble: 14.003905],
                            [NSNumber numberWithDouble: -0.319971],
                            [NSNumber numberWithDouble:  0.202152],
                            [NSNumber numberWithDouble:  0.148298],
                            [NSNumber numberWithDouble: -0.135709],
                            [NSNumber numberWithDouble: -0.034052],
                            [NSNumber numberWithDouble:  0.063324],
                            [NSNumber numberWithDouble:  0.001936],
                            [NSNumber numberWithDouble: -0.013551],
                            [NSNumber numberWithDouble:  0.004954],
                            [NSNumber numberWithDouble: -0.000486],
                            [NSNumber numberWithDouble: -0.002558],
                            [NSNumber numberWithDouble:  0.001537],
                            [NSNumber numberWithDouble:  0.000501],
                            [NSNumber numberWithDouble: -0.000649],
                            [NSNumber numberWithDouble:  0.000106],
                            [NSNumber numberWithDouble:  0.000127],
                            [NSNumber numberWithDouble: -0.000120],
                            [NSNumber numberWithDouble:  0.000019],
                            [NSNumber numberWithDouble:  0.000043],
                            [NSNumber numberWithDouble: -0.000026],
                            [NSNumber numberWithDouble: -0.000004],
                            [NSNumber numberWithDouble:  0.000010],
                            [NSNumber numberWithDouble: -0.000004],
                            [NSNumber numberWithDouble: -0.000002],
                            [NSNumber numberWithDouble:  0.000003],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000001]];
                
                DecArray = @[[NSNumber numberWithDouble:  -3.04536],
                             [NSNumber numberWithDouble:  -2.25132],
                             [NSNumber numberWithDouble:  -5.08081],
                             [NSNumber numberWithDouble:  14.42791],
                             [NSNumber numberWithDouble:   2.22941],
                             [NSNumber numberWithDouble:  -3.22231],
                             [NSNumber numberWithDouble:   0.38828],
                             [NSNumber numberWithDouble:   0.04241],
                             [NSNumber numberWithDouble:  -0.27174],
                             [NSNumber numberWithDouble:   0.16498],
                             [NSNumber numberWithDouble:   0.03859],
                             [NSNumber numberWithDouble:  -0.06497],
                             [NSNumber numberWithDouble:   0.01130],
                             [NSNumber numberWithDouble:   0.01035],
                             [NSNumber numberWithDouble:  -0.00851],
                             [NSNumber numberWithDouble:   0.00199],
                             [NSNumber numberWithDouble:   0.00237],
                             [NSNumber numberWithDouble:  -0.00179],
                             [NSNumber numberWithDouble:  -0.00007],
                             [NSNumber numberWithDouble:   0.00056],
                             [NSNumber numberWithDouble:  -0.00024],
                             [NSNumber numberWithDouble:  -0.00005],
                             [NSNumber numberWithDouble:   0.00012],
                             [NSNumber numberWithDouble:  -0.00004],
                             [NSNumber numberWithDouble:  -0.00003],
                             [NSNumber numberWithDouble:   0.00002],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:  -0.00001],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.963511],
                            [NSNumber numberWithDouble: -0.010277],
                            [NSNumber numberWithDouble:  0.028052],
                            [NSNumber numberWithDouble:  0.037504],
                            [NSNumber numberWithDouble: -0.019430],
                            [NSNumber numberWithDouble: -0.002433],
                            [NSNumber numberWithDouble:  0.006211],
                            [NSNumber numberWithDouble: -0.003050],
                            [NSNumber numberWithDouble: -0.000780],
                            [NSNumber numberWithDouble:  0.000929],
                            [NSNumber numberWithDouble: -0.000294],
                            [NSNumber numberWithDouble: -0.000054],
                            [NSNumber numberWithDouble:  0.000133],
                            [NSNumber numberWithDouble: -0.000053],
                            [NSNumber numberWithDouble: -0.000010],
                            [NSNumber numberWithDouble:  0.000020],
                            [NSNumber numberWithDouble: -0.000008],
                            [NSNumber numberWithDouble: -0.000002],
                            [NSNumber numberWithDouble:  0.000003],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                
                break;
                
            }
            
            a = 152;
            b = 183;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 13.839738],
                            [NSNumber numberWithDouble: 13.533060],
                            [NSNumber numberWithDouble: -0.170111],
                            [NSNumber numberWithDouble:  0.286888],
                            [NSNumber numberWithDouble: -0.009182],
                            [NSNumber numberWithDouble: -0.120676],
                            [NSNumber numberWithDouble:  0.077738],
                            [NSNumber numberWithDouble:  0.034580],
                            [NSNumber numberWithDouble: -0.025199],
                            [NSNumber numberWithDouble: -0.001790],
                            [NSNumber numberWithDouble:  0.000203],
                            [NSNumber numberWithDouble: -0.001196],
                            [NSNumber numberWithDouble:  0.002282],
                            [NSNumber numberWithDouble: -0.000121],
                            [NSNumber numberWithDouble: -0.000793],
                            [NSNumber numberWithDouble:  0.000209],
                            [NSNumber numberWithDouble:  0.000046],
                            [NSNumber numberWithDouble: -0.000019],
                            [NSNumber numberWithDouble:  0.000052],
                            [NSNumber numberWithDouble: -0.000031],
                            [NSNumber numberWithDouble: -0.000015],
                            [NSNumber numberWithDouble:  0.000015],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                DecArray = @[[NSNumber numberWithDouble:   2.35459],
                             [NSNumber numberWithDouble:  -3.63333],
                             [NSNumber numberWithDouble:   6.96742],
                             [NSNumber numberWithDouble:  13.52647],
                             [NSNumber numberWithDouble:  -3.34491],
                             [NSNumber numberWithDouble:  -2.19906],
                             [NSNumber numberWithDouble:   0.33101],
                             [NSNumber numberWithDouble:  -0.21345],
                             [NSNumber numberWithDouble:   0.14608],
                             [NSNumber numberWithDouble:   0.08650],
                             [NSNumber numberWithDouble:  -0.08844],
                             [NSNumber numberWithDouble:   0.00044],
                             [NSNumber numberWithDouble:   0.01589],
                             [NSNumber numberWithDouble:  -0.00403],
                             [NSNumber numberWithDouble:   0.00275],
                             [NSNumber numberWithDouble:  -0.00023],
                             [NSNumber numberWithDouble:  -0.00192],
                             [NSNumber numberWithDouble:   0.00074],
                             [NSNumber numberWithDouble:   0.00028],
                             [NSNumber numberWithDouble:  -0.00020],
                             [NSNumber numberWithDouble:   0.00007],
                             [NSNumber numberWithDouble:  -0.00003],
                             [NSNumber numberWithDouble:  -0.00003],
                             [NSNumber numberWithDouble:   0.00003],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:  -0.00001],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.969814],
                            [NSNumber numberWithDouble: -0.007926],
                            [NSNumber numberWithDouble:  0.043515],
                            [NSNumber numberWithDouble:  0.010192],
                            [NSNumber numberWithDouble: -0.021794],
                            [NSNumber numberWithDouble:  0.004145],
                            [NSNumber numberWithDouble:  0.002590],
                            [NSNumber numberWithDouble: -0.002490],
                            [NSNumber numberWithDouble:  0.000264],
                            [NSNumber numberWithDouble:  0.000196],
                            [NSNumber numberWithDouble: -0.000138],
                            [NSNumber numberWithDouble:  0.000104],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble: -0.000027],
                            [NSNumber numberWithDouble:  0.000011],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble: -0.000002],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                
                break;
                
            }
            
            a = 182;
            b = 214;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 16.754819],
                            [NSNumber numberWithDouble: 14.050994],
                            [NSNumber numberWithDouble:  0.087191],
                            [NSNumber numberWithDouble:  0.288931],
                            [NSNumber numberWithDouble: -0.114310],
                            [NSNumber numberWithDouble: -0.009250],
                            [NSNumber numberWithDouble:  0.085932],
                            [NSNumber numberWithDouble: -0.034683],
                            [NSNumber numberWithDouble: -0.026781],
                            [NSNumber numberWithDouble:  0.005063],
                            [NSNumber numberWithDouble:  0.003545],
                            [NSNumber numberWithDouble:  0.002466],
                            [NSNumber numberWithDouble: -0.000984],
                            [NSNumber numberWithDouble: -0.001153],
                            [NSNumber numberWithDouble:  0.000586],
                            [NSNumber numberWithDouble:  0.000262],
                            [NSNumber numberWithDouble: -0.000115],
                            [NSNumber numberWithDouble: -0.000083],
                            [NSNumber numberWithDouble: -0.000024],
                            [NSNumber numberWithDouble:  0.000042],
                            [NSNumber numberWithDouble:  0.000015],
                            [NSNumber numberWithDouble: -0.000015],
                            [NSNumber numberWithDouble: -0.000004],
                            [NSNumber numberWithDouble:  0.000003],
                            [NSNumber numberWithDouble:  0.000002],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                DecArray = @[[NSNumber numberWithDouble:   6.42931],
                             [NSNumber numberWithDouble:  -0.87134],
                             [NSNumber numberWithDouble:  14.98009],
                             [NSNumber numberWithDouble:   5.99750],
                             [NSNumber numberWithDouble:  -7.73743],
                             [NSNumber numberWithDouble:  -1.40203],
                             [NSNumber numberWithDouble:   0.47941],
                             [NSNumber numberWithDouble:   0.21904],
                             [NSNumber numberWithDouble:   0.19004],
                             [NSNumber numberWithDouble:  -0.11499],
                             [NSNumber numberWithDouble:  -0.03555],
                             [NSNumber numberWithDouble:   0.04327],
                             [NSNumber numberWithDouble:   0.00344],
                             [NSNumber numberWithDouble:  -0.00553],
                             [NSNumber numberWithDouble:  -0.00351],
                             [NSNumber numberWithDouble:  -0.00068],
                             [NSNumber numberWithDouble:   0.00198],
                             [NSNumber numberWithDouble:   0.00018],
                             [NSNumber numberWithDouble:  -0.00055],
                             [NSNumber numberWithDouble:  -0.00003],
                             [NSNumber numberWithDouble:   0.00009],
                             [NSNumber numberWithDouble:   0.00005],
                             [NSNumber numberWithDouble:  -0.00001],
                             [NSNumber numberWithDouble:  -0.00003],
                             [NSNumber numberWithDouble:   0.00001],
                             [NSNumber numberWithDouble:   0.00001],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.966812],
                            [NSNumber numberWithDouble: -0.001130],
                            [NSNumber numberWithDouble:  0.033565],
                            [NSNumber numberWithDouble: -0.017451],
                            [NSNumber numberWithDouble: -0.017649],
                            [NSNumber numberWithDouble:  0.008548],
                            [NSNumber numberWithDouble:  0.001503],
                            [NSNumber numberWithDouble: -0.002095],
                            [NSNumber numberWithDouble:  0.000044],
                            [NSNumber numberWithDouble:  0.000104],
                            [NSNumber numberWithDouble:  0.000100],
                            [NSNumber numberWithDouble:  0.000074],
                            [NSNumber numberWithDouble: -0.000051],
                            [NSNumber numberWithDouble: -0.000019],
                            [NSNumber numberWithDouble:  0.000008],
                            [NSNumber numberWithDouble:  0.000002],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                
                break;
                
            }
            
            a = 213;
            b = 245;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 20.112210],
                            [NSNumber numberWithDouble: 14.082894],
                            [NSNumber numberWithDouble:  0.326797],
                            [NSNumber numberWithDouble:  0.049354],
                            [NSNumber numberWithDouble: -0.173335],
                            [NSNumber numberWithDouble:  0.042792],
                            [NSNumber numberWithDouble: -0.015029],
                            [NSNumber numberWithDouble: -0.038986],
                            [NSNumber numberWithDouble:  0.013158],
                            [NSNumber numberWithDouble:  0.014190],
                            [NSNumber numberWithDouble:  0.000250],
                            [NSNumber numberWithDouble: -0.003963],
                            [NSNumber numberWithDouble: -0.000881],
                            [NSNumber numberWithDouble:  0.000909],
                            [NSNumber numberWithDouble:  0.000068],
                            [NSNumber numberWithDouble: -0.000232],
                            [NSNumber numberWithDouble:  0.000050],
                            [NSNumber numberWithDouble:  0.000105],
                            [NSNumber numberWithDouble: -0.000013],
                            [NSNumber numberWithDouble: -0.000046],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000014],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble: -0.000004],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                DecArray = @[[NSNumber numberWithDouble:   6.17329],
                             [NSNumber numberWithDouble:   0.76448],
                             [NSNumber numberWithDouble:  14.29240],
                             [NSNumber numberWithDouble:  -6.66679],
                             [NSNumber numberWithDouble:  -7.77731],
                             [NSNumber numberWithDouble:   1.00368],
                             [NSNumber numberWithDouble:   1.29731],
                             [NSNumber numberWithDouble:   0.30936],
                             [NSNumber numberWithDouble:  -0.20438],
                             [NSNumber numberWithDouble:  -0.10693],
                             [NSNumber numberWithDouble:   0.04897],
                             [NSNumber numberWithDouble:   0.01152],
                             [NSNumber numberWithDouble:  -0.01397],
                             [NSNumber numberWithDouble:  -0.00257],
                             [NSNumber numberWithDouble:   0.00452],
                             [NSNumber numberWithDouble:   0.00173],
                             [NSNumber numberWithDouble:  -0.00126],
                             [NSNumber numberWithDouble:  -0.00062],
                             [NSNumber numberWithDouble:   0.00025],
                             [NSNumber numberWithDouble:   0.00013],
                             [NSNumber numberWithDouble:  -0.00006],
                             [NSNumber numberWithDouble:  -0.00002],
                             [NSNumber numberWithDouble:   0.00003],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:  -0.00001],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.953500],
                            [NSNumber numberWithDouble:  0.002820],
                            [NSNumber numberWithDouble:  0.004299],
                            [NSNumber numberWithDouble: -0.035499],
                            [NSNumber numberWithDouble: -0.000724],
                            [NSNumber numberWithDouble:  0.012161],
                            [NSNumber numberWithDouble: -0.001065],
                            [NSNumber numberWithDouble: -0.002830],
                            [NSNumber numberWithDouble: -0.000008],
                            [NSNumber numberWithDouble:  0.000631],
                            [NSNumber numberWithDouble:  0.000224],
                            [NSNumber numberWithDouble: -0.000130],
                            [NSNumber numberWithDouble: -0.000101],
                            [NSNumber numberWithDouble:  0.000018],
                            [NSNumber numberWithDouble:  0.000029],
                            [NSNumber numberWithDouble:  0.000002],
                            [NSNumber numberWithDouble: -0.000007],
                            [NSNumber numberWithDouble: -0.000002],
                            [NSNumber numberWithDouble:  0.000002],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                
                break;
                
            }
            
            a = 244;
            b = 275;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 22.889003],
                            [NSNumber numberWithDouble: 13.694847],
                            [NSNumber numberWithDouble:  0.308401],
                            [NSNumber numberWithDouble: -0.232674],
                            [NSNumber numberWithDouble: -0.136016],
                            [NSNumber numberWithDouble:  0.020201],
                            [NSNumber numberWithDouble: -0.009979],
                            [NSNumber numberWithDouble:  0.018320],
                            [NSNumber numberWithDouble:  0.016529],
                            [NSNumber numberWithDouble: -0.005703],
                            [NSNumber numberWithDouble: -0.007106],
                            [NSNumber numberWithDouble:  0.000347],
                            [NSNumber numberWithDouble:  0.002029],
                            [NSNumber numberWithDouble:  0.000279],
                            [NSNumber numberWithDouble: -0.000323],
                            [NSNumber numberWithDouble: -0.000106],
                            [NSNumber numberWithDouble: -0.000021],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000031],
                            [NSNumber numberWithDouble:  0.000018],
                            [NSNumber numberWithDouble: -0.000010],
                            [NSNumber numberWithDouble: -0.000010],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000003],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                DecArray = @[[NSNumber numberWithDouble:   2.13216],
                             [NSNumber numberWithDouble:   3.65959],
                             [NSNumber numberWithDouble:   6.08373],
                             [NSNumber numberWithDouble: -13.22778],
                             [NSNumber numberWithDouble:  -3.38581],
                             [NSNumber numberWithDouble:   3.11146],
                             [NSNumber numberWithDouble:   1.08305],
                             [NSNumber numberWithDouble:  -0.38936],
                             [NSNumber numberWithDouble:  -0.32536],
                             [NSNumber numberWithDouble:   0.03839],
                             [NSNumber numberWithDouble:   0.07127],
                             [NSNumber numberWithDouble:   0.00159],
                             [NSNumber numberWithDouble:  -0.01075],
                             [NSNumber numberWithDouble:  -0.00171],
                             [NSNumber numberWithDouble:   0.00074],
                             [NSNumber numberWithDouble:   0.00015],
                             [NSNumber numberWithDouble:   0.00011],
                             [NSNumber numberWithDouble:   0.00011],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:  -0.00004],
                             [NSNumber numberWithDouble:  -0.00003],
                             [NSNumber numberWithDouble:  -0.00001],
                             [NSNumber numberWithDouble:   0.00001],
                             [NSNumber numberWithDouble:   0.00001],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:  -0.00001],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.940587],
                            [NSNumber numberWithDouble:  0.006985],
                            [NSNumber numberWithDouble: -0.026299],
                            [NSNumber numberWithDouble: -0.031059],
                            [NSNumber numberWithDouble:  0.015566],
                            [NSNumber numberWithDouble:  0.010669],
                            [NSNumber numberWithDouble: -0.004866],
                            [NSNumber numberWithDouble: -0.003235],
                            [NSNumber numberWithDouble:  0.001072],
                            [NSNumber numberWithDouble:  0.001059],
                            [NSNumber numberWithDouble: -0.000130],
                            [NSNumber numberWithDouble: -0.000332],
                            [NSNumber numberWithDouble: -0.000012],
                            [NSNumber numberWithDouble:  0.000097],
                            [NSNumber numberWithDouble:  0.000016],
                            [NSNumber numberWithDouble: -0.000026],
                            [NSNumber numberWithDouble: -0.000008],
                            [NSNumber numberWithDouble:  0.000007],
                            [NSNumber numberWithDouble:  0.000003],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                
                break;
                
            }
            
            a = 274;
            b = 306;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  1.574112],
                            [NSNumber numberWithDouble: 14.139128],
                            [NSNumber numberWithDouble:  0.071774],
                            [NSNumber numberWithDouble: -0.393126],
                            [NSNumber numberWithDouble: -0.069827],
                            [NSNumber numberWithDouble:  0.076075],
                            [NSNumber numberWithDouble:  0.055788],
                            [NSNumber numberWithDouble:  0.011150],
                            [NSNumber numberWithDouble: -0.026205],
                            [NSNumber numberWithDouble: -0.010938],
                            [NSNumber numberWithDouble:  0.008404],
                            [NSNumber numberWithDouble:  0.005099],
                            [NSNumber numberWithDouble: -0.001971],
                            [NSNumber numberWithDouble: -0.002017],
                            [NSNumber numberWithDouble:  0.000164],
                            [NSNumber numberWithDouble:  0.000703],
                            [NSNumber numberWithDouble:  0.000158],
                            [NSNumber numberWithDouble: -0.000209],
                            [NSNumber numberWithDouble: -0.000126],
                            [NSNumber numberWithDouble:  0.000046],
                            [NSNumber numberWithDouble:  0.000062],
                            [NSNumber numberWithDouble: -0.000002],
                            [NSNumber numberWithDouble: -0.000024],
                            [NSNumber numberWithDouble: -0.000005],
                            [NSNumber numberWithDouble:  0.000008],
                            [NSNumber numberWithDouble:  0.000004],
                            [NSNumber numberWithDouble: -0.000002],
                            [NSNumber numberWithDouble: -0.000002],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000001]];
                
                DecArray = @[[NSNumber numberWithDouble:  -2.90847],
                             [NSNumber numberWithDouble:   2.25412],
                             [NSNumber numberWithDouble:  -4.90438],
                             [NSNumber numberWithDouble: -13.85395],
                             [NSNumber numberWithDouble:   2.65838],
                             [NSNumber numberWithDouble:   4.10239],
                             [NSNumber numberWithDouble:  -0.42222],
                             [NSNumber numberWithDouble:  -0.95944],
                             [NSNumber numberWithDouble:   0.01389],
                             [NSNumber numberWithDouble:   0.26661],
                             [NSNumber numberWithDouble:   0.03256],
                             [NSNumber numberWithDouble:  -0.07282],
                             [NSNumber numberWithDouble:  -0.02266],
                             [NSNumber numberWithDouble:   0.01804],
                             [NSNumber numberWithDouble:   0.01048],
                             [NSNumber numberWithDouble:  -0.00369],
                             [NSNumber numberWithDouble:  -0.00397],
                             [NSNumber numberWithDouble:   0.00040],
                             [NSNumber numberWithDouble:   0.00129],
                             [NSNumber numberWithDouble:   0.00014],
                             [NSNumber numberWithDouble:  -0.00035],
                             [NSNumber numberWithDouble:  -0.00012],
                             [NSNumber numberWithDouble:   0.00007],
                             [NSNumber numberWithDouble:   0.00006],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:  -0.00002],
                             [NSNumber numberWithDouble:  -0.00001],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000],
                             [NSNumber numberWithDouble:   0.00000]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.931628],
                            [NSNumber numberWithDouble:  0.001319],
                            [NSNumber numberWithDouble: -0.044910],
                            [NSNumber numberWithDouble: -0.013456],
                            [NSNumber numberWithDouble:  0.027868],
                            [NSNumber numberWithDouble:  0.004588],
                            [NSNumber numberWithDouble: -0.009680],
                            [NSNumber numberWithDouble: -0.001502],
                            [NSNumber numberWithDouble:  0.003141],
                            [NSNumber numberWithDouble:  0.000604],
                            [NSNumber numberWithDouble: -0.000950],
                            [NSNumber numberWithDouble: -0.000238],
                            [NSNumber numberWithDouble:  0.000291],
                            [NSNumber numberWithDouble:  0.000089],
                            [NSNumber numberWithDouble: -0.000091],
                            [NSNumber numberWithDouble: -0.000033],
                            [NSNumber numberWithDouble:  0.000029],
                            [NSNumber numberWithDouble:  0.000012],
                            [NSNumber numberWithDouble: -0.000009],
                            [NSNumber numberWithDouble: -0.000004],
                            [NSNumber numberWithDouble:  0.000003],
                            [NSNumber numberWithDouble:  0.000002],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble: -0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                
                break;
                
            }
            
            a = 305;
            b = 336;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  4.261027],
                            [NSNumber numberWithDouble: 13.759796],
                            [NSNumber numberWithDouble: -0.154999],
                            [NSNumber numberWithDouble: -0.346610],
                            [NSNumber numberWithDouble:  0.043746],
                            [NSNumber numberWithDouble:  0.143670],
                            [NSNumber numberWithDouble:  0.037600],
                            [NSNumber numberWithDouble: -0.056013],
                            [NSNumber numberWithDouble: -0.021958],
                            [NSNumber numberWithDouble:  0.019856],
                            [NSNumber numberWithDouble:  0.007668],
                            [NSNumber numberWithDouble: -0.006683],
                            [NSNumber numberWithDouble: -0.002989],
                            [NSNumber numberWithDouble:  0.002182],
                            [NSNumber numberWithDouble:  0.001328],
                            [NSNumber numberWithDouble: -0.000713],
                            [NSNumber numberWithDouble: -0.000587],
                            [NSNumber numberWithDouble:  0.000238],
                            [NSNumber numberWithDouble:  0.000252],
                            [NSNumber numberWithDouble: -0.000078],
                            [NSNumber numberWithDouble: -0.000106],
                            [NSNumber numberWithDouble:  0.000024],
                            [NSNumber numberWithDouble:  0.000044],
                            [NSNumber numberWithDouble: -0.000006],
                            [NSNumber numberWithDouble: -0.000018],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000007],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble: -0.000003],
                            [NSNumber numberWithDouble: -0.000001]];
                
                DecArray = @[[NSNumber numberWithDouble:  -6.78374],
                             [NSNumber numberWithDouble:   2.00620],
                             [NSNumber numberWithDouble: -13.79731],
                             [NSNumber numberWithDouble:  -7.44006],
                             [NSNumber numberWithDouble:   7.12572],
                             [NSNumber numberWithDouble:   1.83606],
                             [NSNumber numberWithDouble:  -1.65889],
                             [NSNumber numberWithDouble:  -0.32293],
                             [NSNumber numberWithDouble:   0.46374],
                             [NSNumber numberWithDouble:   0.10694],
                             [NSNumber numberWithDouble:  -0.15091],
                             [NSNumber numberWithDouble:  -0.04462],
                             [NSNumber numberWithDouble:   0.05065],
                             [NSNumber numberWithDouble:   0.01708],
                             [NSNumber numberWithDouble:  -0.01721],
                             [NSNumber numberWithDouble:  -0.00640],
                             [NSNumber numberWithDouble:   0.00581],
                             [NSNumber numberWithDouble:   0.00249],
                             [NSNumber numberWithDouble:  -0.00193],
                             [NSNumber numberWithDouble:  -0.00100],
                             [NSNumber numberWithDouble:   0.00063],
                             [NSNumber numberWithDouble:   0.00040],
                             [NSNumber numberWithDouble:  -0.00021],
                             [NSNumber numberWithDouble:  -0.00016],
                             [NSNumber numberWithDouble:   0.00006],
                             [NSNumber numberWithDouble:   0.00007],
                             [NSNumber numberWithDouble:  -0.00002],
                             [NSNumber numberWithDouble:  -0.00003],
                             [NSNumber numberWithDouble:   0.00001],
                             [NSNumber numberWithDouble:   0.00002]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.931094],
                            [NSNumber numberWithDouble: -0.003313],
                            [NSNumber numberWithDouble: -0.049566],
                            [NSNumber numberWithDouble:  0.010426],
                            [NSNumber numberWithDouble:  0.028131],
                            [NSNumber numberWithDouble: -0.005305],
                            [NSNumber numberWithDouble: -0.009259],
                            [NSNumber numberWithDouble:  0.002279],
                            [NSNumber numberWithDouble:  0.002853],
                            [NSNumber numberWithDouble: -0.000865],
                            [NSNumber numberWithDouble: -0.000821],
                            [NSNumber numberWithDouble:  0.000320],
                            [NSNumber numberWithDouble:  0.000237],
                            [NSNumber numberWithDouble: -0.000117],
                            [NSNumber numberWithDouble: -0.000069],
                            [NSNumber numberWithDouble:  0.000042],
                            [NSNumber numberWithDouble:  0.000020],
                            [NSNumber numberWithDouble: -0.000015],
                            [NSNumber numberWithDouble: -0.000005],
                            [NSNumber numberWithDouble:  0.000005],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble: -0.000002],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000]];
                
                
                break;
                
            }
            
            a = 335;
            b = 367;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  7.007828],
                            [NSNumber numberWithDouble: 14.152973],
                            [NSNumber numberWithDouble: -0.243444],
                            [NSNumber numberWithDouble: -0.202938],
                            [NSNumber numberWithDouble:  0.170229],
                            [NSNumber numberWithDouble:  0.134994],
                            [NSNumber numberWithDouble: -0.073418],
                            [NSNumber numberWithDouble: -0.070263],
                            [NSNumber numberWithDouble:  0.031215],
                            [NSNumber numberWithDouble:  0.020879],
                            [NSNumber numberWithDouble: -0.013339],
                            [NSNumber numberWithDouble: -0.004814],
                            [NSNumber numberWithDouble:  0.005848],
                            [NSNumber numberWithDouble:  0.001238],
                            [NSNumber numberWithDouble: -0.002512],
                            [NSNumber numberWithDouble: -0.000276],
                            [NSNumber numberWithDouble:  0.001049],
                            [NSNumber numberWithDouble: -0.000013],
                            [NSNumber numberWithDouble: -0.000430],
                            [NSNumber numberWithDouble:  0.000062],
                            [NSNumber numberWithDouble:  0.000173],
                            [NSNumber numberWithDouble: -0.000047],
                            [NSNumber numberWithDouble: -0.000068],
                            [NSNumber numberWithDouble:  0.000028],
                            [NSNumber numberWithDouble:  0.000025],
                            [NSNumber numberWithDouble: -0.000015],
                            [NSNumber numberWithDouble: -0.000009],
                            [NSNumber numberWithDouble:  0.000008],
                            [NSNumber numberWithDouble:  0.000003],
                            [NSNumber numberWithDouble: -0.000005]];
                
                DecArray = @[[NSNumber numberWithDouble:  -8.11487],
                             [NSNumber numberWithDouble:  -0.54989],
                             [NSNumber numberWithDouble: -15.57462],
                             [NSNumber numberWithDouble:   2.36982],
                             [NSNumber numberWithDouble:   8.63195],
                             [NSNumber numberWithDouble:  -1.13876],
                             [NSNumber numberWithDouble:  -1.61067],
                             [NSNumber numberWithDouble:   0.58220],
                             [NSNumber numberWithDouble:   0.33243],
                             [NSNumber numberWithDouble:  -0.26317],
                             [NSNumber numberWithDouble:  -0.10299],
                             [NSNumber numberWithDouble:   0.10680],
                             [NSNumber numberWithDouble:   0.02762],
                             [NSNumber numberWithDouble:  -0.04164],
                             [NSNumber numberWithDouble:  -0.00417],
                             [NSNumber numberWithDouble:   0.01602],
                             [NSNumber numberWithDouble:  -0.00065],
                             [NSNumber numberWithDouble:  -0.00605],
                             [NSNumber numberWithDouble:   0.00098],
                             [NSNumber numberWithDouble:   0.00222],
                             [NSNumber numberWithDouble:  -0.00064],
                             [NSNumber numberWithDouble:  -0.00079],
                             [NSNumber numberWithDouble:   0.00035],
                             [NSNumber numberWithDouble:   0.00027],
                             [NSNumber numberWithDouble:  -0.00017],
                             [NSNumber numberWithDouble:  -0.00009],
                             [NSNumber numberWithDouble:   0.00008],
                             [NSNumber numberWithDouble:   0.00003],
                             [NSNumber numberWithDouble:  -0.00003],
                             [NSNumber numberWithDouble:  -0.00001]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.936732],
                            [NSNumber numberWithDouble: -0.005009],
                            [NSNumber numberWithDouble: -0.033621],
                            [NSNumber numberWithDouble:  0.030296],
                            [NSNumber numberWithDouble:  0.019649],
                            [NSNumber numberWithDouble: -0.013058],
                            [NSNumber numberWithDouble: -0.005713],
                            [NSNumber numberWithDouble:  0.004824],
                            [NSNumber numberWithDouble:  0.001222],
                            [NSNumber numberWithDouble: -0.001645],
                            [NSNumber numberWithDouble: -0.000095],
                            [NSNumber numberWithDouble:  0.000528],
                            [NSNumber numberWithDouble: -0.000061],
                            [NSNumber numberWithDouble: -0.000160],
                            [NSNumber numberWithDouble:  0.000045],
                            [NSNumber numberWithDouble:  0.000045],
                            [NSNumber numberWithDouble: -0.000021],
                            [NSNumber numberWithDouble: -0.000011],
                            [NSNumber numberWithDouble:  0.000009],
                            [NSNumber numberWithDouble:  0.000002],
                            [NSNumber numberWithDouble: -0.000003],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000001],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],
                            [NSNumber numberWithDouble:  0.000000],];
                
                
                break;
                
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
            
            a = 0;
            b = 122;
            
            if (t >= a && t <= b) {
                

                
                RArray = @[[NSNumber numberWithDouble:10.615288],
                           [NSNumber numberWithDouble: 4.008264],
                           [NSNumber numberWithDouble:-0.000011],
                           [NSNumber numberWithDouble: 0.000006],
                           [NSNumber numberWithDouble: 0.000000],
                           [NSNumber numberWithDouble: 0.000000],
                           [NSNumber numberWithDouble: 0.000001],
                           [NSNumber numberWithDouble: 0.000001]];
                break;
            }
            
            a = 121;
            b = 245;
            
            
            if (t >= a && t <= b) {
                

                RArray = @[[NSNumber numberWithDouble:18.631851],
                           [NSNumber numberWithDouble: 4.074014],
                           [NSNumber numberWithDouble:-0.000003],
                           [NSNumber numberWithDouble:-0.000006],
                           [NSNumber numberWithDouble: 0.000000],
                           [NSNumber numberWithDouble: 0.000001],
                           [NSNumber numberWithDouble: 0.000002],
                           [NSNumber numberWithDouble: 0.000001]];
                break;
            }
            
            a = 244;
            b = 367;
            
            if (t >= a && t <= b) {
                
                
                RArray = @[[NSNumber numberWithDouble: 2.681266],
                           [NSNumber numberWithDouble: 4.041134],
                           [NSNumber numberWithDouble: 0.000019],
                           [NSNumber numberWithDouble: 0.000002],
                           [NSNumber numberWithDouble:-0.000003],
                           [NSNumber numberWithDouble:-0.000001],
                           [NSNumber numberWithDouble: 0.000003],
                           [NSNumber numberWithDouble: 0.000000]];
                break;
            }
            
            break;
            
        default:
            break;
    }
    
    return @{@"RArray":RArray,@"a":[NSNumber numberWithDouble:a],@"b":[NSNumber numberWithDouble:b]};
    
}


@end
