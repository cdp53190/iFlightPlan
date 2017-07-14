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
            break;

        case 2017:
            return YES;
            break;
            
        default:
            return NO;
            break;
    }
}


+(NSDictionary *)dictionaryOfConstantArrayOfSunByYear:(int)year
                                          tWithDeltaT:(double)t {
    NSArray *RAArray = [NSArray new];
    NSArray *DecArray = [NSArray new];
    NSArray *DistArray = [NSArray new];
    
    double a = 0,b = 0;
    
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
                             [NSNumber numberWithDouble:  3.56163f],
                             [NSNumber numberWithDouble:  0.97177f],
                             [NSNumber numberWithDouble: -0.02860f],
                             [NSNumber numberWithDouble: -0.02380f],
                             [NSNumber numberWithDouble: -0.00514f],
                             [NSNumber numberWithDouble:  0.00001f],
                             [NSNumber numberWithDouble:  0.00037f],
                             [NSNumber numberWithDouble: -0.00003f],
                             [NSNumber numberWithDouble: -0.00009f],
                             [NSNumber numberWithDouble:  0.00023f],
                             [NSNumber numberWithDouble: -0.00001f],
                             [NSNumber numberWithDouble: -0.00017f],
                             [NSNumber numberWithDouble:  0.00002f],
                             [NSNumber numberWithDouble:  0.00007f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble: -0.00003f]];
                
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
            
            
        case 2017:
            a = 0;
            b = 121;
            if (t >= a && t <= b) {
                RAArray = @[[NSNumber numberWithDouble:22.728272f],
                            [NSNumber numberWithDouble: 3.893828f],
                            [NSNumber numberWithDouble:-0.102050f],
                            [NSNumber numberWithDouble: 0.035151f],
                            [NSNumber numberWithDouble: 0.006551f],
                            [NSNumber numberWithDouble:-0.002273f],
                            [NSNumber numberWithDouble: 0.000130f],
                            [NSNumber numberWithDouble: 0.000078f],
                            [NSNumber numberWithDouble:-0.000045f],
                            [NSNumber numberWithDouble: 0.000023f],
                            [NSNumber numberWithDouble:-0.000037f],
                            [NSNumber numberWithDouble:-0.000054f],
                            [NSNumber numberWithDouble: 0.000040f],
                            [NSNumber numberWithDouble: 0.000032f],
                            [NSNumber numberWithDouble:-0.000018f],
                            [NSNumber numberWithDouble:-0.000011f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble: 0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble:-5.71871f],
                             [NSNumber numberWithDouble:20.04848f],
                             [NSNumber numberWithDouble: 1.70375f],
                             [NSNumber numberWithDouble:-0.98471f],
                             [NSNumber numberWithDouble: 0.01318f],
                             [NSNumber numberWithDouble: 0.00780f],
                             [NSNumber numberWithDouble:-0.00338f],
                             [NSNumber numberWithDouble: 0.00075f],
                             [NSNumber numberWithDouble: 0.00011f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble:-0.00019f],
                             [NSNumber numberWithDouble:-0.00022f],
                             [NSNumber numberWithDouble: 0.00013f],
                             [NSNumber numberWithDouble: 0.00016f],
                             [NSNumber numberWithDouble:-0.00004f],
                             [NSNumber numberWithDouble:-0.00006f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00002f]];
                
                DistArray = @[[NSNumber numberWithDouble: 0.993235f],
                              [NSNumber numberWithDouble: 0.012739f],
                              [NSNumber numberWithDouble: 0.002254f],
                              [NSNumber numberWithDouble:-0.000645f],
                              [NSNumber numberWithDouble:-0.000038f],
                              [NSNumber numberWithDouble: 0.000006f],
                              [NSNumber numberWithDouble: 0.000007f],
                              [NSNumber numberWithDouble:-0.000010f],
                              [NSNumber numberWithDouble:-0.000006f],
                              [NSNumber numberWithDouble:-0.000004f],
                              [NSNumber numberWithDouble:-0.000012f],
                              [NSNumber numberWithDouble: 0.000012f],
                              [NSNumber numberWithDouble: 0.000011f],
                              [NSNumber numberWithDouble:-0.000007f],
                              [NSNumber numberWithDouble:-0.000005f],
                              [NSNumber numberWithDouble: 0.000002f],
                              [NSNumber numberWithDouble: 0.000002f],
                              [NSNumber numberWithDouble:-0.000001f]];
               break;
            }

            a = 120;
            b = 244;
            if (t >= a && t <= b) {
                RAArray = @[[NSNumber numberWithDouble: 6.630962f],
                            [NSNumber numberWithDouble: 4.135162f],
                            [NSNumber numberWithDouble:-0.042334f],
                            [NSNumber numberWithDouble:-0.040545f],
                            [NSNumber numberWithDouble: 0.005481f],
                            [NSNumber numberWithDouble: 0.003220f],
                            [NSNumber numberWithDouble:-0.000415f],
                            [NSNumber numberWithDouble:-0.000159f],
                            [NSNumber numberWithDouble:-0.000005f],
                            [NSNumber numberWithDouble: 0.000009f],
                            [NSNumber numberWithDouble:-0.000054f],
                            [NSNumber numberWithDouble:-0.000005f],
                            [NSNumber numberWithDouble: 0.000068f],
                            [NSNumber numberWithDouble: 0.000007f],
                            [NSNumber numberWithDouble:-0.000034f],
                            [NSNumber numberWithDouble:-0.000003f],
                            [NSNumber numberWithDouble: 0.000010f],
                            [NSNumber numberWithDouble: 0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble:17.15415f],
                             [NSNumber numberWithDouble:-3.44570f],
                             [NSNumber numberWithDouble:-5.78541f],
                             [NSNumber numberWithDouble: 0.21723f],
                             [NSNumber numberWithDouble: 0.15956f],
                             [NSNumber numberWithDouble:-0.01104f],
                             [NSNumber numberWithDouble:-0.00480f],
                             [NSNumber numberWithDouble: 0.00087f],
                             [NSNumber numberWithDouble: 0.00020f],
                             [NSNumber numberWithDouble: 0.00016f],
                             [NSNumber numberWithDouble: 0.00004f],
                             [NSNumber numberWithDouble:-0.00010f],
                             [NSNumber numberWithDouble:-0.00002f],
                             [NSNumber numberWithDouble:-0.00003f],
                             [NSNumber numberWithDouble:-0.00001f],
                             [NSNumber numberWithDouble: 0.00004f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble:-0.00002f]];
                
                DistArray = @[[NSNumber numberWithDouble: 1.012360f],
                              [NSNumber numberWithDouble: 0.001033f],
                              [NSNumber numberWithDouble:-0.004199f],
                              [NSNumber numberWithDouble:-0.000051f],
                              [NSNumber numberWithDouble: 0.000097f],
                              [NSNumber numberWithDouble:-0.000010f],
                              [NSNumber numberWithDouble: 0.000000f],
                              [NSNumber numberWithDouble:-0.000014f],
                              [NSNumber numberWithDouble:-0.000001f],
                              [NSNumber numberWithDouble:-0.000001f],
                              [NSNumber numberWithDouble:-0.000002f],
                              [NSNumber numberWithDouble: 0.000018f],
                              [NSNumber numberWithDouble: 0.000003f],
                              [NSNumber numberWithDouble:-0.000013f],
                              [NSNumber numberWithDouble:-0.000001f],
                              [NSNumber numberWithDouble: 0.000005f],
                              [NSNumber numberWithDouble: 0.000000f],
                              [NSNumber numberWithDouble:-0.000001f]];
                
                break;
            }
            
            a = 243;
            b = 367;
            if (t >= a && t <= b) {
                RAArray = @[[NSNumber numberWithDouble:14.557792f],
                            [NSNumber numberWithDouble: 4.054790f],
                            [NSNumber numberWithDouble: 0.151828f],
                            [NSNumber numberWithDouble: 0.012687f],
                            [NSNumber numberWithDouble:-0.013543f],
                            [NSNumber numberWithDouble:-0.002133f],
                            [NSNumber numberWithDouble: 0.000311f],
                            [NSNumber numberWithDouble: 0.000130f],
                            [NSNumber numberWithDouble:-0.000002f],
                            [NSNumber numberWithDouble:-0.000019f],
                            [NSNumber numberWithDouble:-0.000036f],
                            [NSNumber numberWithDouble: 0.000055f],
                            [NSNumber numberWithDouble: 0.000040f],
                            [NSNumber numberWithDouble:-0.000034f],
                            [NSNumber numberWithDouble:-0.000019f],
                            [NSNumber numberWithDouble: 0.000010f],
                            [NSNumber numberWithDouble: 0.000007f],
                            [NSNumber numberWithDouble:-0.000004f]];
                
                DecArray = @[[NSNumber numberWithDouble:-10.69312f],
                             [NSNumber numberWithDouble:-16.78233f],
                             [NSNumber numberWithDouble:  3.53962f],
                             [NSNumber numberWithDouble:  0.97278f],
                             [NSNumber numberWithDouble: -0.02788f],
                             [NSNumber numberWithDouble: -0.02344f],
                             [NSNumber numberWithDouble: -0.00540f],
                             [NSNumber numberWithDouble:  0.00022f],
                             [NSNumber numberWithDouble:  0.00034f],
                             [NSNumber numberWithDouble:  0.00003f],
                             [NSNumber numberWithDouble:  0.00021f],
                             [NSNumber numberWithDouble: -0.00015f],
                             [NSNumber numberWithDouble: -0.00019f],
                             [NSNumber numberWithDouble:  0.00014f],
                             [NSNumber numberWithDouble:  0.00009f],
                             [NSNumber numberWithDouble: -0.00006f],
                             [NSNumber numberWithDouble: -0.00004f],
                             [NSNumber numberWithDouble:  0.00002f]];
                
                DistArray = @[[NSNumber numberWithDouble: 0.994580f],
                              [NSNumber numberWithDouble:-0.013773f],
                              [NSNumber numberWithDouble: 0.001847f],
                              [NSNumber numberWithDouble: 0.000717f],
                              [NSNumber numberWithDouble:-0.000049f],
                              [NSNumber numberWithDouble:-0.000018f],
                              [NSNumber numberWithDouble:-0.000005f],
                              [NSNumber numberWithDouble:-0.000010f],
                              [NSNumber numberWithDouble: 0.000007f],
                              [NSNumber numberWithDouble:-0.000003f],
                              [NSNumber numberWithDouble: 0.000010f],
                              [NSNumber numberWithDouble: 0.000012f],
                              [NSNumber numberWithDouble:-0.000012f],
                              [NSNumber numberWithDouble:-0.000008f],
                              [NSNumber numberWithDouble: 0.000006f],
                              [NSNumber numberWithDouble: 0.000003f],
                              [NSNumber numberWithDouble:-0.000001f],
                              [NSNumber numberWithDouble:-0.000001f]];
                
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
    double a = 0, b = 0;
    
    switch (year) {
        case 2016:
            a = 0;
            b = 32;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  0.818858f],
                            [NSNumber numberWithDouble: 14.068701f],
                            [NSNumber numberWithDouble: -0.013869f],
                            [NSNumber numberWithDouble: -0.330931f],
                            [NSNumber numberWithDouble:  0.000773f],
                            [NSNumber numberWithDouble: -0.001382f],
                            [NSNumber numberWithDouble:  0.012981f],
                            [NSNumber numberWithDouble:  0.054032f],
                            [NSNumber numberWithDouble: -0.008647f],
                            [NSNumber numberWithDouble: -0.023009f],
                            [NSNumber numberWithDouble:  0.003159f],
                            [NSNumber numberWithDouble:  0.006232f],
                            [NSNumber numberWithDouble: -0.000657f],
                            [NSNumber numberWithDouble: -0.000887f],
                            [NSNumber numberWithDouble: -0.000074f],
                            [NSNumber numberWithDouble: -0.000205f],
                            [NSNumber numberWithDouble:  0.000143f],
                            [NSNumber numberWithDouble:  0.000205f],
                            [NSNumber numberWithDouble: -0.000075f],
                            [NSNumber numberWithDouble: -0.000086f],
                            [NSNumber numberWithDouble:  0.000024f],
                            [NSNumber numberWithDouble:  0.000023f],
                            [NSNumber numberWithDouble: -0.000004f],
                            [NSNumber numberWithDouble: -0.000002f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble: -0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble:  -1.45441f],
                             [NSNumber numberWithDouble:   2.58812f],
                             [NSNumber numberWithDouble:  -2.85448f],
                             [NSNumber numberWithDouble: -14.11332f],
                             [NSNumber numberWithDouble:   1.59808f],
                             [NSNumber numberWithDouble:   4.00433f],
                             [NSNumber numberWithDouble:  -0.33648f],
                             [NSNumber numberWithDouble:  -0.74708f],
                             [NSNumber numberWithDouble:   0.06297f],
                             [NSNumber numberWithDouble:   0.08179f],
                             [NSNumber numberWithDouble:  -0.00451f],
                             [NSNumber numberWithDouble:   0.02388f],
                             [NSNumber numberWithDouble:  -0.00393f],
                             [NSNumber numberWithDouble:  -0.01802f],
                             [NSNumber numberWithDouble:   0.00243f],
                             [NSNumber numberWithDouble:   0.00655f],
                             [NSNumber numberWithDouble:  -0.00079f],
                             [NSNumber numberWithDouble:  -0.00155f],
                             [NSNumber numberWithDouble:   0.00011f],
                             [NSNumber numberWithDouble:   0.00014f],
                             [NSNumber numberWithDouble:   0.00005f],
                             [NSNumber numberWithDouble:   0.00008f],
                             [NSNumber numberWithDouble:  -0.00004f],
                             [NSNumber numberWithDouble:  -0.00006f],
                             [NSNumber numberWithDouble:   0.00002f],
                             [NSNumber numberWithDouble:   0.00002f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:  0.000000f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.931871f],
                            [NSNumber numberWithDouble: -0.000869f],
                            [NSNumber numberWithDouble: -0.039149f],
                            [NSNumber numberWithDouble: -0.001179f],
                            [NSNumber numberWithDouble:  0.018160f],
                            [NSNumber numberWithDouble: -0.001868f],
                            [NSNumber numberWithDouble: -0.000223f],
                            [NSNumber numberWithDouble:  0.001339f],
                            [NSNumber numberWithDouble: -0.000854f],
                            [NSNumber numberWithDouble: -0.000463f],
                            [NSNumber numberWithDouble:  0.000324f],
                            [NSNumber numberWithDouble:  0.000121f],
                            [NSNumber numberWithDouble: -0.000093f],
                            [NSNumber numberWithDouble: -0.000022f],
                            [NSNumber numberWithDouble:  0.000022f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble: -0.000004f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }

            a = 31;
            b = 61;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  3.065129f],
                            [NSNumber numberWithDouble: 13.274506f],
                            [NSNumber numberWithDouble: -0.287213f],
                            [NSNumber numberWithDouble: -0.244241f],
                            [NSNumber numberWithDouble:  0.071596f],
                            [NSNumber numberWithDouble:  0.021771f],
                            [NSNumber numberWithDouble:  0.038440f],
                            [NSNumber numberWithDouble:  0.005873f],
                            [NSNumber numberWithDouble: -0.023381f],
                            [NSNumber numberWithDouble:  0.000673f],
                            [NSNumber numberWithDouble:  0.007128f],
                            [NSNumber numberWithDouble: -0.001039f],
                            [NSNumber numberWithDouble: -0.001439f],
                            [NSNumber numberWithDouble:  0.000184f],
                            [NSNumber numberWithDouble:  0.000170f],
                            [NSNumber numberWithDouble:  0.000096f],
                            [NSNumber numberWithDouble: -0.000014f],
                            [NSNumber numberWithDouble: -0.000080f],
                            [NSNumber numberWithDouble:  0.000010f],
                            [NSNumber numberWithDouble:  0.000032f],
                            [NSNumber numberWithDouble: -0.000006f],
                            [NSNumber numberWithDouble: -0.000008f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000002f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];

                DecArray = @[[NSNumber numberWithDouble:  -4.64227f],
                             [NSNumber numberWithDouble:   4.08022f],
                             [NSNumber numberWithDouble: -11.46373f],
                             [NSNumber numberWithDouble:  -9.59263f],
                             [NSNumber numberWithDouble:   5.47845f],
                             [NSNumber numberWithDouble:   2.00596f],
                             [NSNumber numberWithDouble:  -1.23966f],
                             [NSNumber numberWithDouble:  -0.17552f],
                             [NSNumber numberWithDouble:   0.22848f],
                             [NSNumber numberWithDouble:  -0.00953f],
                             [NSNumber numberWithDouble:  -0.01518f],
                             [NSNumber numberWithDouble:   0.00557f],
                             [NSNumber numberWithDouble:  -0.00795f],
                             [NSNumber numberWithDouble:   0.00108f],
                             [NSNumber numberWithDouble:   0.00382f],
                             [NSNumber numberWithDouble:  -0.00129f],
                             [NSNumber numberWithDouble:  -0.00099f],
                             [NSNumber numberWithDouble:   0.00047f],
                             [NSNumber numberWithDouble:   0.00019f],
                             [NSNumber numberWithDouble:  -0.00009f],
                             [NSNumber numberWithDouble:  -0.00004f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00001f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:  -0.00001f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.934354f],
                            [NSNumber numberWithDouble: -0.011768f],
                            [NSNumber numberWithDouble: -0.039272f],
                            [NSNumber numberWithDouble:  0.021448f],
                            [NSNumber numberWithDouble:  0.012117f],
                            [NSNumber numberWithDouble: -0.007404f],
                            [NSNumber numberWithDouble:  0.001571f],
                            [NSNumber numberWithDouble:  0.001975f],
                            [NSNumber numberWithDouble: -0.001249f],
                            [NSNumber numberWithDouble: -0.000312f],
                            [NSNumber numberWithDouble:  0.000404f],
                            [NSNumber numberWithDouble: -0.000012f],
                            [NSNumber numberWithDouble: -0.000096f],
                            [NSNumber numberWithDouble:  0.000029f],
                            [NSNumber numberWithDouble:  0.000015f],
                            [NSNumber numberWithDouble: -0.000012f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000003f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }
            
            a = 60;
            b = 92;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  5.347510f],
                            [NSNumber numberWithDouble: 14.085234f],
                            [NSNumber numberWithDouble: -0.406154f],
                            [NSNumber numberWithDouble: -0.120246f],
                            [NSNumber numberWithDouble:  0.193229f],
                            [NSNumber numberWithDouble:  0.052517f],
                            [NSNumber numberWithDouble: -0.012457f],
                            [NSNumber numberWithDouble: -0.029762f],
                            [NSNumber numberWithDouble: -0.001654f],
                            [NSNumber numberWithDouble:  0.012491f],
                            [NSNumber numberWithDouble: -0.002210f],
                            [NSNumber numberWithDouble: -0.003769f],
                            [NSNumber numberWithDouble:  0.001580f],
                            [NSNumber numberWithDouble:  0.000869f],
                            [NSNumber numberWithDouble: -0.000540f],
                            [NSNumber numberWithDouble: -0.000187f],
                            [NSNumber numberWithDouble:  0.000145f],
                            [NSNumber numberWithDouble:  0.000059f],
                            [NSNumber numberWithDouble: -0.000045f],
                            [NSNumber numberWithDouble: -0.000024f],
                            [NSNumber numberWithDouble:  0.000019f],
                            [NSNumber numberWithDouble:  0.000008f],
                            [NSNumber numberWithDouble: -0.000008f],
                            [NSNumber numberWithDouble: -0.000002f],
                            [NSNumber numberWithDouble:  0.000003f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble:  -7.19091f],
                             [NSNumber numberWithDouble:   0.14630f],
                             [NSNumber numberWithDouble: -15.16389f],
                             [NSNumber numberWithDouble:  -2.83137f],
                             [NSNumber numberWithDouble:   8.39345f],
                             [NSNumber numberWithDouble:   0.00119f],
                             [NSNumber numberWithDouble:  -1.58831f],
                             [NSNumber numberWithDouble:   0.44954f],
                             [NSNumber numberWithDouble:   0.22438f],
                             [NSNumber numberWithDouble:  -0.16784f],
                             [NSNumber numberWithDouble:  -0.01066f],
                             [NSNumber numberWithDouble:   0.03652f],
                             [NSNumber numberWithDouble:  -0.00598f],
                             [NSNumber numberWithDouble:  -0.00555f],
                             [NSNumber numberWithDouble:   0.00170f],
                             [NSNumber numberWithDouble:   0.00061f],
                             [NSNumber numberWithDouble:  -0.00005f],
                             [NSNumber numberWithDouble:  -0.00010f],
                             [NSNumber numberWithDouble:  -0.00013f],
                             [NSNumber numberWithDouble:   0.00006f],
                             [NSNumber numberWithDouble:   0.00007f],
                             [NSNumber numberWithDouble:  -0.00004f],
                             [NSNumber numberWithDouble:  -0.00003f],
                             [NSNumber numberWithDouble:   0.00002f],
                             [NSNumber numberWithDouble:   0.00001f],
                             [NSNumber numberWithDouble:  -0.00001f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.938919f],
                            [NSNumber numberWithDouble: -0.011839f],
                            [NSNumber numberWithDouble: -0.024481f],
                            [NSNumber numberWithDouble:  0.040145f],
                            [NSNumber numberWithDouble:  0.007316f],
                            [NSNumber numberWithDouble: -0.011824f],
                            [NSNumber numberWithDouble:  0.004456f],
                            [NSNumber numberWithDouble:  0.002242f],
                            [NSNumber numberWithDouble: -0.002481f],
                            [NSNumber numberWithDouble:  0.000011f],
                            [NSNumber numberWithDouble:  0.000690f],
                            [NSNumber numberWithDouble: -0.000235f],
                            [NSNumber numberWithDouble: -0.000113f],
                            [NSNumber numberWithDouble:  0.000109f],
                            [NSNumber numberWithDouble: -0.000008f],
                            [NSNumber numberWithDouble: -0.000030f],
                            [NSNumber numberWithDouble:  0.000014f],
                            [NSNumber numberWithDouble:  0.000004f],
                            [NSNumber numberWithDouble: -0.000006f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }
            
            a = 91;
            b = 122;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 8.148711f],
                            [NSNumber numberWithDouble:13.607139f],
                            [NSNumber numberWithDouble:-0.419910f],
                            [NSNumber numberWithDouble: 0.072784f],
                            [NSNumber numberWithDouble: 0.215293f],
                            [NSNumber numberWithDouble:-0.020593f],
                            [NSNumber numberWithDouble:-0.074060f],
                            [NSNumber numberWithDouble: 0.004489f],
                            [NSNumber numberWithDouble: 0.021925f],
                            [NSNumber numberWithDouble:-0.005758f],
                            [NSNumber numberWithDouble:-0.003816f],
                            [NSNumber numberWithDouble: 0.003692f],
                            [NSNumber numberWithDouble: 0.000024f],
                            [NSNumber numberWithDouble:-0.001352f],
                            [NSNumber numberWithDouble: 0.000330f],
                            [NSNumber numberWithDouble: 0.000339f],
                            [NSNumber numberWithDouble:-0.000203f],
                            [NSNumber numberWithDouble:-0.000049f],
                            [NSNumber numberWithDouble: 0.000087f],
                            [NSNumber numberWithDouble:-0.000009f],
                            [NSNumber numberWithDouble:-0.000029f],
                            [NSNumber numberWithDouble: 0.000011f],
                            [NSNumber numberWithDouble: 0.000007f],
                            [NSNumber numberWithDouble:-0.000006f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000002f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble: -6.68449f],
                             [NSNumber numberWithDouble: -2.30253f],
                             [NSNumber numberWithDouble:-14.31544f],
                             [NSNumber numberWithDouble:  7.29169f],
                             [NSNumber numberWithDouble:  6.41897f],
                             [NSNumber numberWithDouble: -2.29533f],
                             [NSNumber numberWithDouble: -0.34866f],
                             [NSNumber numberWithDouble:  0.54672f],
                             [NSNumber numberWithDouble: -0.22392f],
                             [NSNumber numberWithDouble: -0.08461f],
                             [NSNumber numberWithDouble:  0.09232f],
                             [NSNumber numberWithDouble: -0.00459f],
                             [NSNumber numberWithDouble: -0.02267f],
                             [NSNumber numberWithDouble:  0.00854f],
                             [NSNumber numberWithDouble:  0.00345f],
                             [NSNumber numberWithDouble: -0.00358f],
                             [NSNumber numberWithDouble:  0.00005f],
                             [NSNumber numberWithDouble:  0.00101f],
                             [NSNumber numberWithDouble: -0.00028f],
                             [NSNumber numberWithDouble: -0.00021f],
                             [NSNumber numberWithDouble:  0.00014f],
                             [NSNumber numberWithDouble:  0.00003f],
                             [NSNumber numberWithDouble: -0.00005f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble:  0.00002f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble:  0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.950906f],
                            [NSNumber numberWithDouble:-0.018775f],
                            [NSNumber numberWithDouble: 0.001512f],
                            [NSNumber numberWithDouble: 0.046283f],
                            [NSNumber numberWithDouble:-0.008132f],
                            [NSNumber numberWithDouble:-0.007730f],
                            [NSNumber numberWithDouble: 0.006940f],
                            [NSNumber numberWithDouble:-0.000913f],
                            [NSNumber numberWithDouble:-0.001917f],
                            [NSNumber numberWithDouble: 0.000894f],
                            [NSNumber numberWithDouble: 0.000090f],
                            [NSNumber numberWithDouble:-0.000280f],
                            [NSNumber numberWithDouble: 0.000110f],
                            [NSNumber numberWithDouble: 0.000029f],
                            [NSNumber numberWithDouble:-0.000046f],
                            [NSNumber numberWithDouble: 0.000013f],
                            [NSNumber numberWithDouble: 0.000008f],
                            [NSNumber numberWithDouble:-0.000007f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000002f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }

            a = 121;
            b = 153;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 10.973911f],
                            [NSNumber numberWithDouble: 14.003905f],
                            [NSNumber numberWithDouble: -0.319971f],
                            [NSNumber numberWithDouble:  0.202152f],
                            [NSNumber numberWithDouble:  0.148298f],
                            [NSNumber numberWithDouble: -0.135709f],
                            [NSNumber numberWithDouble: -0.034052f],
                            [NSNumber numberWithDouble:  0.063324f],
                            [NSNumber numberWithDouble:  0.001936f],
                            [NSNumber numberWithDouble: -0.013551f],
                            [NSNumber numberWithDouble:  0.004954f],
                            [NSNumber numberWithDouble: -0.000486f],
                            [NSNumber numberWithDouble: -0.002558f],
                            [NSNumber numberWithDouble:  0.001537f],
                            [NSNumber numberWithDouble:  0.000501f],
                            [NSNumber numberWithDouble: -0.000649f],
                            [NSNumber numberWithDouble:  0.000106f],
                            [NSNumber numberWithDouble:  0.000127f],
                            [NSNumber numberWithDouble: -0.000120f],
                            [NSNumber numberWithDouble:  0.000019f],
                            [NSNumber numberWithDouble:  0.000043f],
                            [NSNumber numberWithDouble: -0.000026f],
                            [NSNumber numberWithDouble: -0.000004f],
                            [NSNumber numberWithDouble:  0.000010f],
                            [NSNumber numberWithDouble: -0.000004f],
                            [NSNumber numberWithDouble: -0.000002f],
                            [NSNumber numberWithDouble:  0.000003f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble:  -3.04536f],
                             [NSNumber numberWithDouble:  -2.25132f],
                             [NSNumber numberWithDouble:  -5.08081f],
                             [NSNumber numberWithDouble:  14.42791f],
                             [NSNumber numberWithDouble:   2.22941f],
                             [NSNumber numberWithDouble:  -3.22231f],
                             [NSNumber numberWithDouble:   0.38828f],
                             [NSNumber numberWithDouble:   0.04241f],
                             [NSNumber numberWithDouble:  -0.27174f],
                             [NSNumber numberWithDouble:   0.16498f],
                             [NSNumber numberWithDouble:   0.03859f],
                             [NSNumber numberWithDouble:  -0.06497f],
                             [NSNumber numberWithDouble:   0.01130f],
                             [NSNumber numberWithDouble:   0.01035f],
                             [NSNumber numberWithDouble:  -0.00851f],
                             [NSNumber numberWithDouble:   0.00199f],
                             [NSNumber numberWithDouble:   0.00237f],
                             [NSNumber numberWithDouble:  -0.00179f],
                             [NSNumber numberWithDouble:  -0.00007f],
                             [NSNumber numberWithDouble:   0.00056f],
                             [NSNumber numberWithDouble:  -0.00024f],
                             [NSNumber numberWithDouble:  -0.00005f],
                             [NSNumber numberWithDouble:   0.00012f],
                             [NSNumber numberWithDouble:  -0.00004f],
                             [NSNumber numberWithDouble:  -0.00003f],
                             [NSNumber numberWithDouble:   0.00002f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:  -0.00001f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.963511f],
                            [NSNumber numberWithDouble: -0.010277f],
                            [NSNumber numberWithDouble:  0.028052f],
                            [NSNumber numberWithDouble:  0.037504f],
                            [NSNumber numberWithDouble: -0.019430f],
                            [NSNumber numberWithDouble: -0.002433f],
                            [NSNumber numberWithDouble:  0.006211f],
                            [NSNumber numberWithDouble: -0.003050f],
                            [NSNumber numberWithDouble: -0.000780f],
                            [NSNumber numberWithDouble:  0.000929f],
                            [NSNumber numberWithDouble: -0.000294f],
                            [NSNumber numberWithDouble: -0.000054f],
                            [NSNumber numberWithDouble:  0.000133f],
                            [NSNumber numberWithDouble: -0.000053f],
                            [NSNumber numberWithDouble: -0.000010f],
                            [NSNumber numberWithDouble:  0.000020f],
                            [NSNumber numberWithDouble: -0.000008f],
                            [NSNumber numberWithDouble: -0.000002f],
                            [NSNumber numberWithDouble:  0.000003f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }
            
            a = 152;
            b = 183;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 13.839738f],
                            [NSNumber numberWithDouble: 13.533060f],
                            [NSNumber numberWithDouble: -0.170111f],
                            [NSNumber numberWithDouble:  0.286888f],
                            [NSNumber numberWithDouble: -0.009182f],
                            [NSNumber numberWithDouble: -0.120676f],
                            [NSNumber numberWithDouble:  0.077738f],
                            [NSNumber numberWithDouble:  0.034580f],
                            [NSNumber numberWithDouble: -0.025199f],
                            [NSNumber numberWithDouble: -0.001790f],
                            [NSNumber numberWithDouble:  0.000203f],
                            [NSNumber numberWithDouble: -0.001196f],
                            [NSNumber numberWithDouble:  0.002282f],
                            [NSNumber numberWithDouble: -0.000121f],
                            [NSNumber numberWithDouble: -0.000793f],
                            [NSNumber numberWithDouble:  0.000209f],
                            [NSNumber numberWithDouble:  0.000046f],
                            [NSNumber numberWithDouble: -0.000019f],
                            [NSNumber numberWithDouble:  0.000052f],
                            [NSNumber numberWithDouble: -0.000031f],
                            [NSNumber numberWithDouble: -0.000015f],
                            [NSNumber numberWithDouble:  0.000015f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble:   2.35459f],
                             [NSNumber numberWithDouble:  -3.63333f],
                             [NSNumber numberWithDouble:   6.96742f],
                             [NSNumber numberWithDouble:  13.52647f],
                             [NSNumber numberWithDouble:  -3.34491f],
                             [NSNumber numberWithDouble:  -2.19906f],
                             [NSNumber numberWithDouble:   0.33101f],
                             [NSNumber numberWithDouble:  -0.21345f],
                             [NSNumber numberWithDouble:   0.14608f],
                             [NSNumber numberWithDouble:   0.08650f],
                             [NSNumber numberWithDouble:  -0.08844f],
                             [NSNumber numberWithDouble:   0.00044f],
                             [NSNumber numberWithDouble:   0.01589f],
                             [NSNumber numberWithDouble:  -0.00403f],
                             [NSNumber numberWithDouble:   0.00275f],
                             [NSNumber numberWithDouble:  -0.00023f],
                             [NSNumber numberWithDouble:  -0.00192f],
                             [NSNumber numberWithDouble:   0.00074f],
                             [NSNumber numberWithDouble:   0.00028f],
                             [NSNumber numberWithDouble:  -0.00020f],
                             [NSNumber numberWithDouble:   0.00007f],
                             [NSNumber numberWithDouble:  -0.00003f],
                             [NSNumber numberWithDouble:  -0.00003f],
                             [NSNumber numberWithDouble:   0.00003f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:  -0.00001f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.969814f],
                            [NSNumber numberWithDouble: -0.007926f],
                            [NSNumber numberWithDouble:  0.043515f],
                            [NSNumber numberWithDouble:  0.010192f],
                            [NSNumber numberWithDouble: -0.021794f],
                            [NSNumber numberWithDouble:  0.004145f],
                            [NSNumber numberWithDouble:  0.002590f],
                            [NSNumber numberWithDouble: -0.002490f],
                            [NSNumber numberWithDouble:  0.000264f],
                            [NSNumber numberWithDouble:  0.000196f],
                            [NSNumber numberWithDouble: -0.000138f],
                            [NSNumber numberWithDouble:  0.000104f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble: -0.000027f],
                            [NSNumber numberWithDouble:  0.000011f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble: -0.000002f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }
            
            a = 182;
            b = 214;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 16.754819f],
                            [NSNumber numberWithDouble: 14.050994f],
                            [NSNumber numberWithDouble:  0.087191f],
                            [NSNumber numberWithDouble:  0.288931f],
                            [NSNumber numberWithDouble: -0.114310f],
                            [NSNumber numberWithDouble: -0.009250f],
                            [NSNumber numberWithDouble:  0.085932f],
                            [NSNumber numberWithDouble: -0.034683f],
                            [NSNumber numberWithDouble: -0.026781f],
                            [NSNumber numberWithDouble:  0.005063f],
                            [NSNumber numberWithDouble:  0.003545f],
                            [NSNumber numberWithDouble:  0.002466f],
                            [NSNumber numberWithDouble: -0.000984f],
                            [NSNumber numberWithDouble: -0.001153f],
                            [NSNumber numberWithDouble:  0.000586f],
                            [NSNumber numberWithDouble:  0.000262f],
                            [NSNumber numberWithDouble: -0.000115f],
                            [NSNumber numberWithDouble: -0.000083f],
                            [NSNumber numberWithDouble: -0.000024f],
                            [NSNumber numberWithDouble:  0.000042f],
                            [NSNumber numberWithDouble:  0.000015f],
                            [NSNumber numberWithDouble: -0.000015f],
                            [NSNumber numberWithDouble: -0.000004f],
                            [NSNumber numberWithDouble:  0.000003f],
                            [NSNumber numberWithDouble:  0.000002f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble:   6.42931f],
                             [NSNumber numberWithDouble:  -0.87134f],
                             [NSNumber numberWithDouble:  14.98009f],
                             [NSNumber numberWithDouble:   5.99750f],
                             [NSNumber numberWithDouble:  -7.73743f],
                             [NSNumber numberWithDouble:  -1.40203f],
                             [NSNumber numberWithDouble:   0.47941f],
                             [NSNumber numberWithDouble:   0.21904f],
                             [NSNumber numberWithDouble:   0.19004f],
                             [NSNumber numberWithDouble:  -0.11499f],
                             [NSNumber numberWithDouble:  -0.03555f],
                             [NSNumber numberWithDouble:   0.04327f],
                             [NSNumber numberWithDouble:   0.00344f],
                             [NSNumber numberWithDouble:  -0.00553f],
                             [NSNumber numberWithDouble:  -0.00351f],
                             [NSNumber numberWithDouble:  -0.00068f],
                             [NSNumber numberWithDouble:   0.00198f],
                             [NSNumber numberWithDouble:   0.00018f],
                             [NSNumber numberWithDouble:  -0.00055f],
                             [NSNumber numberWithDouble:  -0.00003f],
                             [NSNumber numberWithDouble:   0.00009f],
                             [NSNumber numberWithDouble:   0.00005f],
                             [NSNumber numberWithDouble:  -0.00001f],
                             [NSNumber numberWithDouble:  -0.00003f],
                             [NSNumber numberWithDouble:   0.00001f],
                             [NSNumber numberWithDouble:   0.00001f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.966812f],
                            [NSNumber numberWithDouble: -0.001130f],
                            [NSNumber numberWithDouble:  0.033565f],
                            [NSNumber numberWithDouble: -0.017451f],
                            [NSNumber numberWithDouble: -0.017649f],
                            [NSNumber numberWithDouble:  0.008548f],
                            [NSNumber numberWithDouble:  0.001503f],
                            [NSNumber numberWithDouble: -0.002095f],
                            [NSNumber numberWithDouble:  0.000044f],
                            [NSNumber numberWithDouble:  0.000104f],
                            [NSNumber numberWithDouble:  0.000100f],
                            [NSNumber numberWithDouble:  0.000074f],
                            [NSNumber numberWithDouble: -0.000051f],
                            [NSNumber numberWithDouble: -0.000019f],
                            [NSNumber numberWithDouble:  0.000008f],
                            [NSNumber numberWithDouble:  0.000002f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }
            
            a = 213;
            b = 245;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 20.112210f],
                            [NSNumber numberWithDouble: 14.082894f],
                            [NSNumber numberWithDouble:  0.326797f],
                            [NSNumber numberWithDouble:  0.049354f],
                            [NSNumber numberWithDouble: -0.173335f],
                            [NSNumber numberWithDouble:  0.042792f],
                            [NSNumber numberWithDouble: -0.015029f],
                            [NSNumber numberWithDouble: -0.038986f],
                            [NSNumber numberWithDouble:  0.013158f],
                            [NSNumber numberWithDouble:  0.014190f],
                            [NSNumber numberWithDouble:  0.000250f],
                            [NSNumber numberWithDouble: -0.003963f],
                            [NSNumber numberWithDouble: -0.000881f],
                            [NSNumber numberWithDouble:  0.000909f],
                            [NSNumber numberWithDouble:  0.000068f],
                            [NSNumber numberWithDouble: -0.000232f],
                            [NSNumber numberWithDouble:  0.000050f],
                            [NSNumber numberWithDouble:  0.000105f],
                            [NSNumber numberWithDouble: -0.000013f],
                            [NSNumber numberWithDouble: -0.000046f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000014f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble: -0.000004f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble:   6.17329f],
                             [NSNumber numberWithDouble:   0.76448f],
                             [NSNumber numberWithDouble:  14.29240f],
                             [NSNumber numberWithDouble:  -6.66679f],
                             [NSNumber numberWithDouble:  -7.77731f],
                             [NSNumber numberWithDouble:   1.00368f],
                             [NSNumber numberWithDouble:   1.29731f],
                             [NSNumber numberWithDouble:   0.30936f],
                             [NSNumber numberWithDouble:  -0.20438f],
                             [NSNumber numberWithDouble:  -0.10693f],
                             [NSNumber numberWithDouble:   0.04897f],
                             [NSNumber numberWithDouble:   0.01152f],
                             [NSNumber numberWithDouble:  -0.01397f],
                             [NSNumber numberWithDouble:  -0.00257f],
                             [NSNumber numberWithDouble:   0.00452f],
                             [NSNumber numberWithDouble:   0.00173f],
                             [NSNumber numberWithDouble:  -0.00126f],
                             [NSNumber numberWithDouble:  -0.00062f],
                             [NSNumber numberWithDouble:   0.00025f],
                             [NSNumber numberWithDouble:   0.00013f],
                             [NSNumber numberWithDouble:  -0.00006f],
                             [NSNumber numberWithDouble:  -0.00002f],
                             [NSNumber numberWithDouble:   0.00003f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:  -0.00001f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.953500f],
                            [NSNumber numberWithDouble:  0.002820f],
                            [NSNumber numberWithDouble:  0.004299f],
                            [NSNumber numberWithDouble: -0.035499f],
                            [NSNumber numberWithDouble: -0.000724f],
                            [NSNumber numberWithDouble:  0.012161f],
                            [NSNumber numberWithDouble: -0.001065f],
                            [NSNumber numberWithDouble: -0.002830f],
                            [NSNumber numberWithDouble: -0.000008f],
                            [NSNumber numberWithDouble:  0.000631f],
                            [NSNumber numberWithDouble:  0.000224f],
                            [NSNumber numberWithDouble: -0.000130f],
                            [NSNumber numberWithDouble: -0.000101f],
                            [NSNumber numberWithDouble:  0.000018f],
                            [NSNumber numberWithDouble:  0.000029f],
                            [NSNumber numberWithDouble:  0.000002f],
                            [NSNumber numberWithDouble: -0.000007f],
                            [NSNumber numberWithDouble: -0.000002f],
                            [NSNumber numberWithDouble:  0.000002f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }
            
            a = 244;
            b = 275;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 22.889003f],
                            [NSNumber numberWithDouble: 13.694847f],
                            [NSNumber numberWithDouble:  0.308401f],
                            [NSNumber numberWithDouble: -0.232674f],
                            [NSNumber numberWithDouble: -0.136016f],
                            [NSNumber numberWithDouble:  0.020201f],
                            [NSNumber numberWithDouble: -0.009979f],
                            [NSNumber numberWithDouble:  0.018320f],
                            [NSNumber numberWithDouble:  0.016529f],
                            [NSNumber numberWithDouble: -0.005703f],
                            [NSNumber numberWithDouble: -0.007106f],
                            [NSNumber numberWithDouble:  0.000347f],
                            [NSNumber numberWithDouble:  0.002029f],
                            [NSNumber numberWithDouble:  0.000279f],
                            [NSNumber numberWithDouble: -0.000323f],
                            [NSNumber numberWithDouble: -0.000106f],
                            [NSNumber numberWithDouble: -0.000021f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000031f],
                            [NSNumber numberWithDouble:  0.000018f],
                            [NSNumber numberWithDouble: -0.000010f],
                            [NSNumber numberWithDouble: -0.000010f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000003f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble:   2.13216f],
                             [NSNumber numberWithDouble:   3.65959f],
                             [NSNumber numberWithDouble:   6.08373f],
                             [NSNumber numberWithDouble: -13.22778f],
                             [NSNumber numberWithDouble:  -3.38581f],
                             [NSNumber numberWithDouble:   3.11146f],
                             [NSNumber numberWithDouble:   1.08305f],
                             [NSNumber numberWithDouble:  -0.38936f],
                             [NSNumber numberWithDouble:  -0.32536f],
                             [NSNumber numberWithDouble:   0.03839f],
                             [NSNumber numberWithDouble:   0.07127f],
                             [NSNumber numberWithDouble:   0.00159f],
                             [NSNumber numberWithDouble:  -0.01075f],
                             [NSNumber numberWithDouble:  -0.00171f],
                             [NSNumber numberWithDouble:   0.00074f],
                             [NSNumber numberWithDouble:   0.00015f],
                             [NSNumber numberWithDouble:   0.00011f],
                             [NSNumber numberWithDouble:   0.00011f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:  -0.00004f],
                             [NSNumber numberWithDouble:  -0.00003f],
                             [NSNumber numberWithDouble:  -0.00001f],
                             [NSNumber numberWithDouble:   0.00001f],
                             [NSNumber numberWithDouble:   0.00001f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:  -0.00001f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.940587f],
                            [NSNumber numberWithDouble:  0.006985f],
                            [NSNumber numberWithDouble: -0.026299f],
                            [NSNumber numberWithDouble: -0.031059f],
                            [NSNumber numberWithDouble:  0.015566f],
                            [NSNumber numberWithDouble:  0.010669f],
                            [NSNumber numberWithDouble: -0.004866f],
                            [NSNumber numberWithDouble: -0.003235f],
                            [NSNumber numberWithDouble:  0.001072f],
                            [NSNumber numberWithDouble:  0.001059f],
                            [NSNumber numberWithDouble: -0.000130f],
                            [NSNumber numberWithDouble: -0.000332f],
                            [NSNumber numberWithDouble: -0.000012f],
                            [NSNumber numberWithDouble:  0.000097f],
                            [NSNumber numberWithDouble:  0.000016f],
                            [NSNumber numberWithDouble: -0.000026f],
                            [NSNumber numberWithDouble: -0.000008f],
                            [NSNumber numberWithDouble:  0.000007f],
                            [NSNumber numberWithDouble:  0.000003f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }
            
            a = 274;
            b = 306;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  1.574112f],
                            [NSNumber numberWithDouble: 14.139128f],
                            [NSNumber numberWithDouble:  0.071774f],
                            [NSNumber numberWithDouble: -0.393126f],
                            [NSNumber numberWithDouble: -0.069827f],
                            [NSNumber numberWithDouble:  0.076075f],
                            [NSNumber numberWithDouble:  0.055788f],
                            [NSNumber numberWithDouble:  0.011150f],
                            [NSNumber numberWithDouble: -0.026205f],
                            [NSNumber numberWithDouble: -0.010938f],
                            [NSNumber numberWithDouble:  0.008404f],
                            [NSNumber numberWithDouble:  0.005099f],
                            [NSNumber numberWithDouble: -0.001971f],
                            [NSNumber numberWithDouble: -0.002017f],
                            [NSNumber numberWithDouble:  0.000164f],
                            [NSNumber numberWithDouble:  0.000703f],
                            [NSNumber numberWithDouble:  0.000158f],
                            [NSNumber numberWithDouble: -0.000209f],
                            [NSNumber numberWithDouble: -0.000126f],
                            [NSNumber numberWithDouble:  0.000046f],
                            [NSNumber numberWithDouble:  0.000062f],
                            [NSNumber numberWithDouble: -0.000002f],
                            [NSNumber numberWithDouble: -0.000024f],
                            [NSNumber numberWithDouble: -0.000005f],
                            [NSNumber numberWithDouble:  0.000008f],
                            [NSNumber numberWithDouble:  0.000004f],
                            [NSNumber numberWithDouble: -0.000002f],
                            [NSNumber numberWithDouble: -0.000002f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble:  -2.90847f],
                             [NSNumber numberWithDouble:   2.25412f],
                             [NSNumber numberWithDouble:  -4.90438f],
                             [NSNumber numberWithDouble: -13.85395f],
                             [NSNumber numberWithDouble:   2.65838f],
                             [NSNumber numberWithDouble:   4.10239f],
                             [NSNumber numberWithDouble:  -0.42222f],
                             [NSNumber numberWithDouble:  -0.95944f],
                             [NSNumber numberWithDouble:   0.01389f],
                             [NSNumber numberWithDouble:   0.26661f],
                             [NSNumber numberWithDouble:   0.03256f],
                             [NSNumber numberWithDouble:  -0.07282f],
                             [NSNumber numberWithDouble:  -0.02266f],
                             [NSNumber numberWithDouble:   0.01804f],
                             [NSNumber numberWithDouble:   0.01048f],
                             [NSNumber numberWithDouble:  -0.00369f],
                             [NSNumber numberWithDouble:  -0.00397f],
                             [NSNumber numberWithDouble:   0.00040f],
                             [NSNumber numberWithDouble:   0.00129f],
                             [NSNumber numberWithDouble:   0.00014f],
                             [NSNumber numberWithDouble:  -0.00035f],
                             [NSNumber numberWithDouble:  -0.00012f],
                             [NSNumber numberWithDouble:   0.00007f],
                             [NSNumber numberWithDouble:   0.00006f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:  -0.00002f],
                             [NSNumber numberWithDouble:  -0.00001f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f],
                             [NSNumber numberWithDouble:   0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.931628f],
                            [NSNumber numberWithDouble:  0.001319f],
                            [NSNumber numberWithDouble: -0.044910f],
                            [NSNumber numberWithDouble: -0.013456f],
                            [NSNumber numberWithDouble:  0.027868f],
                            [NSNumber numberWithDouble:  0.004588f],
                            [NSNumber numberWithDouble: -0.009680f],
                            [NSNumber numberWithDouble: -0.001502f],
                            [NSNumber numberWithDouble:  0.003141f],
                            [NSNumber numberWithDouble:  0.000604f],
                            [NSNumber numberWithDouble: -0.000950f],
                            [NSNumber numberWithDouble: -0.000238f],
                            [NSNumber numberWithDouble:  0.000291f],
                            [NSNumber numberWithDouble:  0.000089f],
                            [NSNumber numberWithDouble: -0.000091f],
                            [NSNumber numberWithDouble: -0.000033f],
                            [NSNumber numberWithDouble:  0.000029f],
                            [NSNumber numberWithDouble:  0.000012f],
                            [NSNumber numberWithDouble: -0.000009f],
                            [NSNumber numberWithDouble: -0.000004f],
                            [NSNumber numberWithDouble:  0.000003f],
                            [NSNumber numberWithDouble:  0.000002f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble: -0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }
            
            a = 305;
            b = 336;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  4.261027f],
                            [NSNumber numberWithDouble: 13.759796f],
                            [NSNumber numberWithDouble: -0.154999f],
                            [NSNumber numberWithDouble: -0.346610f],
                            [NSNumber numberWithDouble:  0.043746f],
                            [NSNumber numberWithDouble:  0.143670f],
                            [NSNumber numberWithDouble:  0.037600f],
                            [NSNumber numberWithDouble: -0.056013f],
                            [NSNumber numberWithDouble: -0.021958f],
                            [NSNumber numberWithDouble:  0.019856f],
                            [NSNumber numberWithDouble:  0.007668f],
                            [NSNumber numberWithDouble: -0.006683f],
                            [NSNumber numberWithDouble: -0.002989f],
                            [NSNumber numberWithDouble:  0.002182f],
                            [NSNumber numberWithDouble:  0.001328f],
                            [NSNumber numberWithDouble: -0.000713f],
                            [NSNumber numberWithDouble: -0.000587f],
                            [NSNumber numberWithDouble:  0.000238f],
                            [NSNumber numberWithDouble:  0.000252f],
                            [NSNumber numberWithDouble: -0.000078f],
                            [NSNumber numberWithDouble: -0.000106f],
                            [NSNumber numberWithDouble:  0.000024f],
                            [NSNumber numberWithDouble:  0.000044f],
                            [NSNumber numberWithDouble: -0.000006f],
                            [NSNumber numberWithDouble: -0.000018f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000007f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble: -0.000003f],
                            [NSNumber numberWithDouble: -0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble:  -6.78374f],
                             [NSNumber numberWithDouble:   2.00620f],
                             [NSNumber numberWithDouble: -13.79731f],
                             [NSNumber numberWithDouble:  -7.44006f],
                             [NSNumber numberWithDouble:   7.12572f],
                             [NSNumber numberWithDouble:   1.83606f],
                             [NSNumber numberWithDouble:  -1.65889f],
                             [NSNumber numberWithDouble:  -0.32293f],
                             [NSNumber numberWithDouble:   0.46374f],
                             [NSNumber numberWithDouble:   0.10694f],
                             [NSNumber numberWithDouble:  -0.15091f],
                             [NSNumber numberWithDouble:  -0.04462f],
                             [NSNumber numberWithDouble:   0.05065f],
                             [NSNumber numberWithDouble:   0.01708f],
                             [NSNumber numberWithDouble:  -0.01721f],
                             [NSNumber numberWithDouble:  -0.00640f],
                             [NSNumber numberWithDouble:   0.00581f],
                             [NSNumber numberWithDouble:   0.00249f],
                             [NSNumber numberWithDouble:  -0.00193f],
                             [NSNumber numberWithDouble:  -0.00100f],
                             [NSNumber numberWithDouble:   0.00063f],
                             [NSNumber numberWithDouble:   0.00040f],
                             [NSNumber numberWithDouble:  -0.00021f],
                             [NSNumber numberWithDouble:  -0.00016f],
                             [NSNumber numberWithDouble:   0.00006f],
                             [NSNumber numberWithDouble:   0.00007f],
                             [NSNumber numberWithDouble:  -0.00002f],
                             [NSNumber numberWithDouble:  -0.00003f],
                             [NSNumber numberWithDouble:   0.00001f],
                             [NSNumber numberWithDouble:   0.00002f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.931094f],
                            [NSNumber numberWithDouble: -0.003313f],
                            [NSNumber numberWithDouble: -0.049566f],
                            [NSNumber numberWithDouble:  0.010426f],
                            [NSNumber numberWithDouble:  0.028131f],
                            [NSNumber numberWithDouble: -0.005305f],
                            [NSNumber numberWithDouble: -0.009259f],
                            [NSNumber numberWithDouble:  0.002279f],
                            [NSNumber numberWithDouble:  0.002853f],
                            [NSNumber numberWithDouble: -0.000865f],
                            [NSNumber numberWithDouble: -0.000821f],
                            [NSNumber numberWithDouble:  0.000320f],
                            [NSNumber numberWithDouble:  0.000237f],
                            [NSNumber numberWithDouble: -0.000117f],
                            [NSNumber numberWithDouble: -0.000069f],
                            [NSNumber numberWithDouble:  0.000042f],
                            [NSNumber numberWithDouble:  0.000020f],
                            [NSNumber numberWithDouble: -0.000015f],
                            [NSNumber numberWithDouble: -0.000005f],
                            [NSNumber numberWithDouble:  0.000005f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble: -0.000002f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }
            
            a = 335;
            b = 367;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:  7.007828f],
                            [NSNumber numberWithDouble: 14.152973f],
                            [NSNumber numberWithDouble: -0.243444f],
                            [NSNumber numberWithDouble: -0.202938f],
                            [NSNumber numberWithDouble:  0.170229f],
                            [NSNumber numberWithDouble:  0.134994f],
                            [NSNumber numberWithDouble: -0.073418f],
                            [NSNumber numberWithDouble: -0.070263f],
                            [NSNumber numberWithDouble:  0.031215f],
                            [NSNumber numberWithDouble:  0.020879f],
                            [NSNumber numberWithDouble: -0.013339f],
                            [NSNumber numberWithDouble: -0.004814f],
                            [NSNumber numberWithDouble:  0.005848f],
                            [NSNumber numberWithDouble:  0.001238f],
                            [NSNumber numberWithDouble: -0.002512f],
                            [NSNumber numberWithDouble: -0.000276f],
                            [NSNumber numberWithDouble:  0.001049f],
                            [NSNumber numberWithDouble: -0.000013f],
                            [NSNumber numberWithDouble: -0.000430f],
                            [NSNumber numberWithDouble:  0.000062f],
                            [NSNumber numberWithDouble:  0.000173f],
                            [NSNumber numberWithDouble: -0.000047f],
                            [NSNumber numberWithDouble: -0.000068f],
                            [NSNumber numberWithDouble:  0.000028f],
                            [NSNumber numberWithDouble:  0.000025f],
                            [NSNumber numberWithDouble: -0.000015f],
                            [NSNumber numberWithDouble: -0.000009f],
                            [NSNumber numberWithDouble:  0.000008f],
                            [NSNumber numberWithDouble:  0.000003f],
                            [NSNumber numberWithDouble: -0.000005f]];
                
                DecArray = @[[NSNumber numberWithDouble:  -8.11487f],
                             [NSNumber numberWithDouble:  -0.54989f],
                             [NSNumber numberWithDouble: -15.57462f],
                             [NSNumber numberWithDouble:   2.36982f],
                             [NSNumber numberWithDouble:   8.63195f],
                             [NSNumber numberWithDouble:  -1.13876f],
                             [NSNumber numberWithDouble:  -1.61067f],
                             [NSNumber numberWithDouble:   0.58220f],
                             [NSNumber numberWithDouble:   0.33243f],
                             [NSNumber numberWithDouble:  -0.26317f],
                             [NSNumber numberWithDouble:  -0.10299f],
                             [NSNumber numberWithDouble:   0.10680f],
                             [NSNumber numberWithDouble:   0.02762f],
                             [NSNumber numberWithDouble:  -0.04164f],
                             [NSNumber numberWithDouble:  -0.00417f],
                             [NSNumber numberWithDouble:   0.01602f],
                             [NSNumber numberWithDouble:  -0.00065f],
                             [NSNumber numberWithDouble:  -0.00605f],
                             [NSNumber numberWithDouble:   0.00098f],
                             [NSNumber numberWithDouble:   0.00222f],
                             [NSNumber numberWithDouble:  -0.00064f],
                             [NSNumber numberWithDouble:  -0.00079f],
                             [NSNumber numberWithDouble:   0.00035f],
                             [NSNumber numberWithDouble:   0.00027f],
                             [NSNumber numberWithDouble:  -0.00017f],
                             [NSNumber numberWithDouble:  -0.00009f],
                             [NSNumber numberWithDouble:   0.00008f],
                             [NSNumber numberWithDouble:   0.00003f],
                             [NSNumber numberWithDouble:  -0.00003f],
                             [NSNumber numberWithDouble:  -0.00001f]];
                
                HPArray = @[[NSNumber numberWithDouble:  0.936732f],
                            [NSNumber numberWithDouble: -0.005009f],
                            [NSNumber numberWithDouble: -0.033621f],
                            [NSNumber numberWithDouble:  0.030296f],
                            [NSNumber numberWithDouble:  0.019649f],
                            [NSNumber numberWithDouble: -0.013058f],
                            [NSNumber numberWithDouble: -0.005713f],
                            [NSNumber numberWithDouble:  0.004824f],
                            [NSNumber numberWithDouble:  0.001222f],
                            [NSNumber numberWithDouble: -0.001645f],
                            [NSNumber numberWithDouble: -0.000095f],
                            [NSNumber numberWithDouble:  0.000528f],
                            [NSNumber numberWithDouble: -0.000061f],
                            [NSNumber numberWithDouble: -0.000160f],
                            [NSNumber numberWithDouble:  0.000045f],
                            [NSNumber numberWithDouble:  0.000045f],
                            [NSNumber numberWithDouble: -0.000021f],
                            [NSNumber numberWithDouble: -0.000011f],
                            [NSNumber numberWithDouble:  0.000009f],
                            [NSNumber numberWithDouble:  0.000002f],
                            [NSNumber numberWithDouble: -0.000003f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000001f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f],
                            [NSNumber numberWithDouble:  0.000000f]];
                
                
                break;
                
            }
            
            break;
            
        case 2017:
            a = 0;
            b = 32;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:10.229896f],
                            [NSNumber numberWithDouble:14.080103f],
                            [NSNumber numberWithDouble:-0.257200f],
                            [NSNumber numberWithDouble:-0.024342f],
                            [NSNumber numberWithDouble: 0.207967f],
                            [NSNumber numberWithDouble:-0.027397f],
                            [NSNumber numberWithDouble:-0.119655f],
                            [NSNumber numberWithDouble: 0.029197f],
                            [NSNumber numberWithDouble: 0.040125f],
                            [NSNumber numberWithDouble:-0.015773f],
                            [NSNumber numberWithDouble:-0.005532f],
                            [NSNumber numberWithDouble: 0.007110f],
                            [NSNumber numberWithDouble:-0.001374f],
                            [NSNumber numberWithDouble:-0.002668f],
                            [NSNumber numberWithDouble: 0.001401f],
                            [NSNumber numberWithDouble: 0.000675f],
                            [NSNumber numberWithDouble:-0.000705f],
                            [NSNumber numberWithDouble:-0.000013f],
                            [NSNumber numberWithDouble: 0.000269f],
                            [NSNumber numberWithDouble:-0.000100f],
                            [NSNumber numberWithDouble:-0.000076f],
                            [NSNumber numberWithDouble: 0.000068f],
                            [NSNumber numberWithDouble: 0.000009f],
                            [NSNumber numberWithDouble:-0.000030f],
                            [NSNumber numberWithDouble: 0.000007f],
                            [NSNumber numberWithDouble: 0.000010f],
                            [NSNumber numberWithDouble:-0.000006f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble:-0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble:-4.94126f],
                             [NSNumber numberWithDouble:-1.98735f],
                             [NSNumber numberWithDouble:-8.81608f],
                             [NSNumber numberWithDouble:12.74472f],
                             [NSNumber numberWithDouble: 4.50853f],
                             [NSNumber numberWithDouble:-3.41052f],
                             [NSNumber numberWithDouble:-0.14545f],
                             [NSNumber numberWithDouble: 0.58797f],
                             [NSNumber numberWithDouble:-0.30734f],
                             [NSNumber numberWithDouble:-0.12211f],
                             [NSNumber numberWithDouble: 0.15656f],
                             [NSNumber numberWithDouble: 0.01302f],
                             [NSNumber numberWithDouble:-0.05363f],
                             [NSNumber numberWithDouble: 0.01056f],
                             [NSNumber numberWithDouble: 0.01344f],
                             [NSNumber numberWithDouble:-0.00880f],
                             [NSNumber numberWithDouble:-0.00182f],
                             [NSNumber numberWithDouble: 0.00403f],
                             [NSNumber numberWithDouble:-0.00056f],
                             [NSNumber numberWithDouble:-0.00131f],
                             [NSNumber numberWithDouble: 0.00062f],
                             [NSNumber numberWithDouble: 0.00027f],
                             [NSNumber numberWithDouble:-0.00033f],
                             [NSNumber numberWithDouble: 0.00001f],
                             [NSNumber numberWithDouble: 0.00012f],
                             [NSNumber numberWithDouble:-0.00005f],
                             [NSNumber numberWithDouble:-0.00003f],
                             [NSNumber numberWithDouble: 0.00003f],
                             [NSNumber numberWithDouble: 0.00001f],
                             [NSNumber numberWithDouble:-0.00002f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.950471f],
                            [NSNumber numberWithDouble:-0.004793f],
                            [NSNumber numberWithDouble:-0.002942f],
                            [NSNumber numberWithDouble: 0.037935f],
                            [NSNumber numberWithDouble: 0.000266f],
                            [NSNumber numberWithDouble:-0.014695f],
                            [NSNumber numberWithDouble: 0.000689f],
                            [NSNumber numberWithDouble: 0.003961f],
                            [NSNumber numberWithDouble:-0.000861f],
                            [NSNumber numberWithDouble:-0.000766f],
                            [NSNumber numberWithDouble: 0.000490f],
                            [NSNumber numberWithDouble: 0.000070f],
                            [NSNumber numberWithDouble:-0.000176f],
                            [NSNumber numberWithDouble: 0.000023f],
                            [NSNumber numberWithDouble: 0.000046f],
                            [NSNumber numberWithDouble:-0.000018f],
                            [NSNumber numberWithDouble:-0.000008f],
                            [NSNumber numberWithDouble: 0.000008f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble:-0.000002f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 31;
            b = 60;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:12.159805f],
                            [NSNumber numberWithDouble:12.696487f],
                            [NSNumber numberWithDouble:-0.241352f],
                            [NSNumber numberWithDouble: 0.113622f],
                            [NSNumber numberWithDouble: 0.139521f],
                            [NSNumber numberWithDouble:-0.098301f],
                            [NSNumber numberWithDouble:-0.036062f],
                            [NSNumber numberWithDouble: 0.042178f],
                            [NSNumber numberWithDouble: 0.000967f],
                            [NSNumber numberWithDouble:-0.007936f],
                            [NSNumber numberWithDouble: 0.003582f],
                            [NSNumber numberWithDouble:-0.000230f],
                            [NSNumber numberWithDouble:-0.001533f],
                            [NSNumber numberWithDouble: 0.000732f],
                            [NSNumber numberWithDouble: 0.000252f],
                            [NSNumber numberWithDouble:-0.000292f],
                            [NSNumber numberWithDouble: 0.000058f],
                            [NSNumber numberWithDouble: 0.000056f],
                            [NSNumber numberWithDouble:-0.000052f],
                            [NSNumber numberWithDouble: 0.000006f],
                            [NSNumber numberWithDouble: 0.000016f],
                            [NSNumber numberWithDouble:-0.000009f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble:-1.26708f],
                             [NSNumber numberWithDouble:-7.75169f],
                             [NSNumber numberWithDouble:-1.43007f],
                             [NSNumber numberWithDouble:13.68977f],
                             [NSNumber numberWithDouble: 0.10491f],
                             [NSNumber numberWithDouble:-2.23875f],
                             [NSNumber numberWithDouble: 0.45048f],
                             [NSNumber numberWithDouble: 0.00199f],
                             [NSNumber numberWithDouble:-0.20450f],
                             [NSNumber numberWithDouble: 0.07567f],
                             [NSNumber numberWithDouble: 0.04239f],
                             [NSNumber numberWithDouble:-0.02833f],
                             [NSNumber numberWithDouble:-0.00021f],
                             [NSNumber numberWithDouble: 0.00642f],
                             [NSNumber numberWithDouble:-0.00328f],
                             [NSNumber numberWithDouble:-0.00040f],
                             [NSNumber numberWithDouble: 0.00127f],
                             [NSNumber numberWithDouble:-0.00038f],
                             [NSNumber numberWithDouble:-0.00021f],
                             [NSNumber numberWithDouble: 0.00019f],
                             [NSNumber numberWithDouble:-0.00003f],
                             [NSNumber numberWithDouble:-0.00004f],
                             [NSNumber numberWithDouble: 0.00003f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble:-0.00001f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.959226f],
                            [NSNumber numberWithDouble:-0.010299f],
                            [NSNumber numberWithDouble: 0.021191f],
                            [NSNumber numberWithDouble: 0.028774f],
                            [NSNumber numberWithDouble:-0.007168f],
                            [NSNumber numberWithDouble:-0.009013f],
                            [NSNumber numberWithDouble: 0.000659f],
                            [NSNumber numberWithDouble: 0.001575f],
                            [NSNumber numberWithDouble:-0.000354f],
                            [NSNumber numberWithDouble:-0.000119f],
                            [NSNumber numberWithDouble: 0.000177f],
                            [NSNumber numberWithDouble:-0.000021f],
                            [NSNumber numberWithDouble:-0.000043f],
                            [NSNumber numberWithDouble: 0.000012f],
                            [NSNumber numberWithDouble: 0.000005f],
                            [NSNumber numberWithDouble:-0.000004f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 59;
            b = 91;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:14.095543f],
                            [NSNumber numberWithDouble:13.996441f],
                            [NSNumber numberWithDouble:-0.127922f],
                            [NSNumber numberWithDouble: 0.245090f],
                            [NSNumber numberWithDouble: 0.076760f],
                            [NSNumber numberWithDouble:-0.095707f],
                            [NSNumber numberWithDouble: 0.028304f],
                            [NSNumber numberWithDouble: 0.034118f],
                            [NSNumber numberWithDouble:-0.018616f],
                            [NSNumber numberWithDouble:-0.004453f],
                            [NSNumber numberWithDouble: 0.003075f],
                            [NSNumber numberWithDouble:-0.001580f],
                            [NSNumber numberWithDouble: 0.000527f],
                            [NSNumber numberWithDouble: 0.000646f],
                            [NSNumber numberWithDouble:-0.000493f],
                            [NSNumber numberWithDouble:-0.000013f],
                            [NSNumber numberWithDouble: 0.000133f],
                            [NSNumber numberWithDouble:-0.000054f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble: 0.000016f],
                            [NSNumber numberWithDouble:-0.000015f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000004f],
                            [NSNumber numberWithDouble:-0.000002f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble: 2.55830f],
                             [NSNumber numberWithDouble:-1.95992f],
                             [NSNumber numberWithDouble: 7.04807f],
                             [NSNumber numberWithDouble:14.32350f],
                             [NSNumber numberWithDouble:-3.64313f],
                             [NSNumber numberWithDouble:-2.77630f],
                             [NSNumber numberWithDouble: 0.51769f],
                             [NSNumber numberWithDouble:-0.17762f],
                             [NSNumber numberWithDouble:-0.04892f],
                             [NSNumber numberWithDouble: 0.12443f],
                             [NSNumber numberWithDouble:-0.00934f],
                             [NSNumber numberWithDouble:-0.01775f],
                             [NSNumber numberWithDouble: 0.00882f],
                             [NSNumber numberWithDouble:-0.00092f],
                             [NSNumber numberWithDouble:-0.00179f],
                             [NSNumber numberWithDouble: 0.00113f],
                             [NSNumber numberWithDouble:-0.00032f],
                             [NSNumber numberWithDouble:-0.00021f],
                             [NSNumber numberWithDouble: 0.00026f],
                             [NSNumber numberWithDouble:-0.00005f],
                             [NSNumber numberWithDouble:-0.00005f],
                             [NSNumber numberWithDouble: 0.00004f],
                             [NSNumber numberWithDouble:-0.00001f],
                             [NSNumber numberWithDouble:-0.00001f],
                             [NSNumber numberWithDouble: 0.00001f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.968492f],
                            [NSNumber numberWithDouble: 0.002344f],
                            [NSNumber numberWithDouble: 0.038310f],
                            [NSNumber numberWithDouble: 0.015160f],
                            [NSNumber numberWithDouble:-0.017939f],
                            [NSNumber numberWithDouble:-0.008331f],
                            [NSNumber numberWithDouble: 0.000173f],
                            [NSNumber numberWithDouble: 0.002143f],
                            [NSNumber numberWithDouble: 0.000431f],
                            [NSNumber numberWithDouble:-0.000131f],
                            [NSNumber numberWithDouble: 0.000093f],
                            [NSNumber numberWithDouble:-0.000049f],
                            [NSNumber numberWithDouble:-0.000063f],
                            [NSNumber numberWithDouble: 0.000007f],
                            [NSNumber numberWithDouble: 0.000010f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 90;
            b = 121;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:16.999373f],
                            [NSNumber numberWithDouble:13.526108f],
                            [NSNumber numberWithDouble: 0.120227f],
                            [NSNumber numberWithDouble: 0.358014f],
                            [NSNumber numberWithDouble:-0.043794f],
                            [NSNumber numberWithDouble:-0.007256f],
                            [NSNumber numberWithDouble: 0.031221f],
                            [NSNumber numberWithDouble:-0.032997f],
                            [NSNumber numberWithDouble:-0.011549f],
                            [NSNumber numberWithDouble: 0.004062f],
                            [NSNumber numberWithDouble: 0.001126f],
                            [NSNumber numberWithDouble: 0.001082f],
                            [NSNumber numberWithDouble:-0.000109f],
                            [NSNumber numberWithDouble:-0.000129f],
                            [NSNumber numberWithDouble: 0.000190f],
                            [NSNumber numberWithDouble:-0.000046f],
                            [NSNumber numberWithDouble:-0.000055f],
                            [NSNumber numberWithDouble:-0.000006f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000007f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble: 6.28816f],
                             [NSNumber numberWithDouble:-1.64164f],
                             [NSNumber numberWithDouble:16.43632f],
                             [NSNumber numberWithDouble: 5.98007f],
                             [NSNumber numberWithDouble:-7.12988f],
                             [NSNumber numberWithDouble:-1.25659f],
                             [NSNumber numberWithDouble: 0.19975f],
                             [NSNumber numberWithDouble: 0.01798f],
                             [NSNumber numberWithDouble: 0.14819f],
                             [NSNumber numberWithDouble: 0.02478f],
                             [NSNumber numberWithDouble: 0.00894f],
                             [NSNumber numberWithDouble: 0.00149f],
                             [NSNumber numberWithDouble:-0.00869f],
                             [NSNumber numberWithDouble:-0.00211f],
                             [NSNumber numberWithDouble:-0.00018f],
                             [NSNumber numberWithDouble: 0.00030f],
                             [NSNumber numberWithDouble: 0.00047f],
                             [NSNumber numberWithDouble:-0.00003f],
                             [NSNumber numberWithDouble:-0.00003f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble:-0.00001f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.970974f],
                            [NSNumber numberWithDouble: 0.009269f],
                            [NSNumber numberWithDouble: 0.047495f],
                            [NSNumber numberWithDouble:-0.012150f],
                            [NSNumber numberWithDouble:-0.021397f],
                            [NSNumber numberWithDouble:-0.004726f],
                            [NSNumber numberWithDouble: 0.001407f],
                            [NSNumber numberWithDouble: 0.002762f],
                            [NSNumber numberWithDouble: 0.000546f],
                            [NSNumber numberWithDouble:-0.000165f],
                            [NSNumber numberWithDouble:-0.000123f],
                            [NSNumber numberWithDouble:-0.000117f],
                            [NSNumber numberWithDouble:-0.000021f],
                            [NSNumber numberWithDouble: 0.000020f],
                            [NSNumber numberWithDouble: 0.000014f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 120;
            b = 152;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:19.940168f],
                            [NSNumber numberWithDouble:14.021929f],
                            [NSNumber numberWithDouble: 0.409148f],
                            [NSNumber numberWithDouble: 0.272159f],
                            [NSNumber numberWithDouble:-0.135427f],
                            [NSNumber numberWithDouble:-0.021147f],
                            [NSNumber numberWithDouble:-0.065330f],
                            [NSNumber numberWithDouble:-0.033909f],
                            [NSNumber numberWithDouble: 0.024109f],
                            [NSNumber numberWithDouble: 0.014578f],
                            [NSNumber numberWithDouble: 0.001716f],
                            [NSNumber numberWithDouble:-0.002007f],
                            [NSNumber numberWithDouble:-0.001259f],
                            [NSNumber numberWithDouble:-0.000569f],
                            [NSNumber numberWithDouble:-0.000395f],
                            [NSNumber numberWithDouble: 0.000141f],
                            [NSNumber numberWithDouble: 0.000278f],
                            [NSNumber numberWithDouble: 0.000097f],
                            [NSNumber numberWithDouble:-0.000029f],
                            [NSNumber numberWithDouble:-0.000040f],
                            [NSNumber numberWithDouble:-0.000016f],
                            [NSNumber numberWithDouble:-0.000004f],
                            [NSNumber numberWithDouble: 0.000002f],
                            [NSNumber numberWithDouble: 0.000005f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble: 6.26183f],
                             [NSNumber numberWithDouble: 0.49339f],
                             [NSNumber numberWithDouble:15.88584f],
                             [NSNumber numberWithDouble:-5.45486f],
                             [NSNumber numberWithDouble:-8.36942f],
                             [NSNumber numberWithDouble: 0.32291f],
                             [NSNumber numberWithDouble: 0.89677f],
                             [NSNumber numberWithDouble: 0.45446f],
                             [NSNumber numberWithDouble: 0.10995f],
                             [NSNumber numberWithDouble:-0.02350f],
                             [NSNumber numberWithDouble:-0.05109f],
                             [NSNumber numberWithDouble:-0.04887f],
                             [NSNumber numberWithDouble:-0.00394f],
                             [NSNumber numberWithDouble: 0.01223f],
                             [NSNumber numberWithDouble: 0.00703f],
                             [NSNumber numberWithDouble: 0.00101f],
                             [NSNumber numberWithDouble:-0.00111f],
                             [NSNumber numberWithDouble:-0.00084f],
                             [NSNumber numberWithDouble:-0.00042f],
                             [NSNumber numberWithDouble:-0.00006f],
                             [NSNumber numberWithDouble: 0.00014f],
                             [NSNumber numberWithDouble: 0.00011f],
                             [NSNumber numberWithDouble: 0.00003f],
                             [NSNumber numberWithDouble:-0.00002f],
                             [NSNumber numberWithDouble:-0.00002f],
                             [NSNumber numberWithDouble:-0.00001f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.964358f],
                            [NSNumber numberWithDouble: 0.010653f],
                            [NSNumber numberWithDouble: 0.030865f],
                            [NSNumber numberWithDouble:-0.038819f],
                            [NSNumber numberWithDouble:-0.019091f],
                            [NSNumber numberWithDouble: 0.001382f],
                            [NSNumber numberWithDouble: 0.005222f],
                            [NSNumber numberWithDouble: 0.003558f],
                            [NSNumber numberWithDouble:-0.000402f],
                            [NSNumber numberWithDouble:-0.000891f],
                            [NSNumber numberWithDouble:-0.000348f],
                            [NSNumber numberWithDouble:-0.000003f],
                            [NSNumber numberWithDouble: 0.000113f],
                            [NSNumber numberWithDouble: 0.000062f],
                            [NSNumber numberWithDouble: 0.000002f],
                            [NSNumber numberWithDouble:-0.000016f],
                            [NSNumber numberWithDouble:-0.000010f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000002f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 151;
            b = 182;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:22.767706f],
                            [NSNumber numberWithDouble:13.589588f],
                            [NSNumber numberWithDouble: 0.506162f],
                            [NSNumber numberWithDouble: 0.012096f],
                            [NSNumber numberWithDouble:-0.157040f],
                            [NSNumber numberWithDouble:-0.088497f],
                            [NSNumber numberWithDouble:-0.056485f],
                            [NSNumber numberWithDouble: 0.043800f],
                            [NSNumber numberWithDouble: 0.037302f],
                            [NSNumber numberWithDouble:-0.001929f],
                            [NSNumber numberWithDouble:-0.009388f],
                            [NSNumber numberWithDouble:-0.003672f],
                            [NSNumber numberWithDouble:-0.000236f],
                            [NSNumber numberWithDouble: 0.000988f],
                            [NSNumber numberWithDouble: 0.001123f],
                            [NSNumber numberWithDouble: 0.000257f],
                            [NSNumber numberWithDouble:-0.000353f],
                            [NSNumber numberWithDouble:-0.000262f],
                            [NSNumber numberWithDouble:-0.000016f],
                            [NSNumber numberWithDouble: 0.000068f],
                            [NSNumber numberWithDouble: 0.000048f],
                            [NSNumber numberWithDouble: 0.000011f],
                            [NSNumber numberWithDouble:-0.000013f],
                            [NSNumber numberWithDouble:-0.000014f],
                            [NSNumber numberWithDouble:-0.000003f],
                            [NSNumber numberWithDouble: 0.000004f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble:-0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble:  2.23806f],
                             [NSNumber numberWithDouble:  3.71982f],
                             [NSNumber numberWithDouble:  8.04900f],
                             [NSNumber numberWithDouble:-13.25762f],
                             [NSNumber numberWithDouble: -4.47743f],
                             [NSNumber numberWithDouble:  2.38177f],
                             [NSNumber numberWithDouble:  1.23680f],
                             [NSNumber numberWithDouble:  0.14912f],
                             [NSNumber numberWithDouble: -0.15364f],
                             [NSNumber numberWithDouble: -0.14662f],
                             [NSNumber numberWithDouble: -0.07093f],
                             [NSNumber numberWithDouble:  0.02443f],
                             [NSNumber numberWithDouble:  0.04065f],
                             [NSNumber numberWithDouble:  0.00926f],
                             [NSNumber numberWithDouble: -0.00749f],
                             [NSNumber numberWithDouble: -0.00604f],
                             [NSNumber numberWithDouble: -0.00138f],
                             [NSNumber numberWithDouble:  0.00093f],
                             [NSNumber numberWithDouble:  0.00119f],
                             [NSNumber numberWithDouble:  0.00042f],
                             [NSNumber numberWithDouble: -0.00022f],
                             [NSNumber numberWithDouble: -0.00027f],
                             [NSNumber numberWithDouble: -0.00007f],
                             [NSNumber numberWithDouble:  0.00005f],
                             [NSNumber numberWithDouble:  0.00005f],
                             [NSNumber numberWithDouble:  0.00002f],
                             [NSNumber numberWithDouble: -0.00001f],
                             [NSNumber numberWithDouble: -0.00001f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble:  0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.951256f],
                            [NSNumber numberWithDouble: 0.018602f],
                            [NSNumber numberWithDouble: 0.002981f],
                            [NSNumber numberWithDouble:-0.046057f],
                            [NSNumber numberWithDouble:-0.007498f],
                            [NSNumber numberWithDouble: 0.006369f],
                            [NSNumber numberWithDouble: 0.006188f],
                            [NSNumber numberWithDouble: 0.001441f],
                            [NSNumber numberWithDouble:-0.001566f],
                            [NSNumber numberWithDouble:-0.000898f],
                            [NSNumber numberWithDouble:-0.000005f],
                            [NSNumber numberWithDouble: 0.000228f],
                            [NSNumber numberWithDouble: 0.000112f],
                            [NSNumber numberWithDouble:-0.000009f],
                            [NSNumber numberWithDouble:-0.000036f],
                            [NSNumber numberWithDouble:-0.000015f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble: 0.000006f],
                            [NSNumber numberWithDouble: 0.000002f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 181;
            b = 213;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 1.492202f],
                            [NSNumber numberWithDouble:14.052190f],
                            [NSNumber numberWithDouble: 0.324927f],
                            [NSNumber numberWithDouble:-0.204158f],
                            [NSNumber numberWithDouble:-0.178868f],
                            [NSNumber numberWithDouble:-0.052667f],
                            [NSNumber numberWithDouble: 0.060611f],
                            [NSNumber numberWithDouble: 0.073182f],
                            [NSNumber numberWithDouble:-0.012725f],
                            [NSNumber numberWithDouble:-0.028434f],
                            [NSNumber numberWithDouble:-0.002777f],
                            [NSNumber numberWithDouble: 0.006723f],
                            [NSNumber numberWithDouble: 0.003577f],
                            [NSNumber numberWithDouble:-0.000236f],
                            [NSNumber numberWithDouble:-0.001703f],
                            [NSNumber numberWithDouble:-0.000774f],
                            [NSNumber numberWithDouble: 0.000457f],
                            [NSNumber numberWithDouble: 0.000489f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble:-0.000178f],
                            [NSNumber numberWithDouble:-0.000076f],
                            [NSNumber numberWithDouble: 0.000032f],
                            [NSNumber numberWithDouble: 0.000047f],
                            [NSNumber numberWithDouble: 0.000008f],
                            [NSNumber numberWithDouble:-0.000016f],
                            [NSNumber numberWithDouble:-0.000011f],
                            [NSNumber numberWithDouble: 0.000002f],
                            [NSNumber numberWithDouble: 0.000005f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble:-0.000002f]];
                
                DecArray = @[[NSNumber numberWithDouble: -2.84884f],
                             [NSNumber numberWithDouble:  2.61166f],
                             [NSNumber numberWithDouble: -3.71262f],
                             [NSNumber numberWithDouble:-14.92908f],
                             [NSNumber numberWithDouble:  1.58040f],
                             [NSNumber numberWithDouble:  4.13640f],
                             [NSNumber numberWithDouble:  0.33633f],
                             [NSNumber numberWithDouble: -0.66431f],
                             [NSNumber numberWithDouble: -0.31622f],
                             [NSNumber numberWithDouble:  0.00282f],
                             [NSNumber numberWithDouble:  0.11926f],
                             [NSNumber numberWithDouble:  0.06594f],
                             [NSNumber numberWithDouble: -0.02528f],
                             [NSNumber numberWithDouble: -0.03356f],
                             [NSNumber numberWithDouble: -0.00199f],
                             [NSNumber numberWithDouble:  0.01006f],
                             [NSNumber numberWithDouble:  0.00455f],
                             [NSNumber numberWithDouble: -0.00134f],
                             [NSNumber numberWithDouble: -0.00231f],
                             [NSNumber numberWithDouble: -0.00056f],
                             [NSNumber numberWithDouble:  0.00068f],
                             [NSNumber numberWithDouble:  0.00051f],
                             [NSNumber numberWithDouble: -0.00006f],
                             [NSNumber numberWithDouble: -0.00021f],
                             [NSNumber numberWithDouble: -0.00007f],
                             [NSNumber numberWithDouble:  0.00005f],
                             [NSNumber numberWithDouble:  0.00005f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble: -0.00002f],
                             [NSNumber numberWithDouble: -0.00001f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.939085f],
                            [NSNumber numberWithDouble: 0.010793f],
                            [NSNumber numberWithDouble:-0.023873f],
                            [NSNumber numberWithDouble:-0.038550f],
                            [NSNumber numberWithDouble: 0.007947f],
                            [NSNumber numberWithDouble: 0.010146f],
                            [NSNumber numberWithDouble: 0.003884f],
                            [NSNumber numberWithDouble:-0.001479f],
                            [NSNumber numberWithDouble:-0.002154f],
                            [NSNumber numberWithDouble:-0.000159f],
                            [NSNumber numberWithDouble: 0.000550f],
                            [NSNumber numberWithDouble: 0.000224f],
                            [NSNumber numberWithDouble:-0.000074f],
                            [NSNumber numberWithDouble:-0.000087f],
                            [NSNumber numberWithDouble:-0.000012f],
                            [NSNumber numberWithDouble: 0.000020f],
                            [NSNumber numberWithDouble: 0.000012f],
                            [NSNumber numberWithDouble:-0.000002f],
                            [NSNumber numberWithDouble:-0.000004f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 212;
            b = 244;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 4.606570f],
                            [NSNumber numberWithDouble:14.099916f],
                            [NSNumber numberWithDouble: 0.055954f],
                            [NSNumber numberWithDouble:-0.261313f],
                            [NSNumber numberWithDouble:-0.072246f],
                            [NSNumber numberWithDouble: 0.083654f],
                            [NSNumber numberWithDouble: 0.088043f],
                            [NSNumber numberWithDouble:-0.025894f],
                            [NSNumber numberWithDouble:-0.042320f],
                            [NSNumber numberWithDouble: 0.007167f],
                            [NSNumber numberWithDouble: 0.013865f],
                            [NSNumber numberWithDouble:-0.000590f],
                            [NSNumber numberWithDouble:-0.004443f],
                            [NSNumber numberWithDouble:-0.000839f],
                            [NSNumber numberWithDouble: 0.001528f],
                            [NSNumber numberWithDouble: 0.000688f],
                            [NSNumber numberWithDouble:-0.000513f],
                            [NSNumber numberWithDouble:-0.000361f],
                            [NSNumber numberWithDouble: 0.000147f],
                            [NSNumber numberWithDouble: 0.000163f],
                            [NSNumber numberWithDouble:-0.000028f],
                            [NSNumber numberWithDouble:-0.000069f],
                            [NSNumber numberWithDouble:-0.000002f],
                            [NSNumber numberWithDouble: 0.000028f],
                            [NSNumber numberWithDouble: 0.000006f],
                            [NSNumber numberWithDouble:-0.000010f],
                            [NSNumber numberWithDouble:-0.000004f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble: 0.000002f],
                            [NSNumber numberWithDouble:-0.000001f]];
                
                DecArray = @[[NSNumber numberWithDouble: -7.37715f],
                             [NSNumber numberWithDouble:  1.32445f],
                             [NSNumber numberWithDouble:-14.05783f],
                             [NSNumber numberWithDouble: -7.61368f],
                             [NSNumber numberWithDouble:  7.77508f],
                             [NSNumber numberWithDouble:  2.28324f],
                             [NSNumber numberWithDouble: -1.51581f],
                             [NSNumber numberWithDouble: -0.56701f],
                             [NSNumber numberWithDouble:  0.23131f],
                             [NSNumber numberWithDouble:  0.20180f],
                             [NSNumber numberWithDouble: -0.00809f],
                             [NSNumber numberWithDouble: -0.07750f],
                             [NSNumber numberWithDouble: -0.01437f],
                             [NSNumber numberWithDouble:  0.02628f],
                             [NSNumber numberWithDouble:  0.00883f],
                             [NSNumber numberWithDouble: -0.00763f],
                             [NSNumber numberWithDouble: -0.00422f],
                             [NSNumber numberWithDouble:  0.00187f],
                             [NSNumber numberWithDouble:  0.00186f],
                             [NSNumber numberWithDouble: -0.00033f],
                             [NSNumber numberWithDouble: -0.00076f],
                             [NSNumber numberWithDouble: -0.00001f],
                             [NSNumber numberWithDouble:  0.00029f],
                             [NSNumber numberWithDouble:  0.00005f],
                             [NSNumber numberWithDouble: -0.00010f],
                             [NSNumber numberWithDouble: -0.00004f],
                             [NSNumber numberWithDouble:  0.00003f],
                             [NSNumber numberWithDouble:  0.00002f],
                             [NSNumber numberWithDouble: -0.00001f],
                             [NSNumber numberWithDouble: -0.00001f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.931897f],
                            [NSNumber numberWithDouble: 0.004507f],
                            [NSNumber numberWithDouble:-0.039931f],
                            [NSNumber numberWithDouble:-0.011078f],
                            [NSNumber numberWithDouble: 0.018902f],
                            [NSNumber numberWithDouble: 0.005822f],
                            [NSNumber numberWithDouble:-0.000646f],
                            [NSNumber numberWithDouble:-0.002413f],
                            [NSNumber numberWithDouble:-0.000802f],
                            [NSNumber numberWithDouble: 0.000684f],
                            [NSNumber numberWithDouble: 0.000365f],
                            [NSNumber numberWithDouble:-0.000140f],
                            [NSNumber numberWithDouble:-0.000123f],
                            [NSNumber numberWithDouble: 0.000015f],
                            [NSNumber numberWithDouble: 0.000034f],
                            [NSNumber numberWithDouble: 0.000004f],
                            [NSNumber numberWithDouble:-0.000008f],
                            [NSNumber numberWithDouble:-0.000003f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 243;
            b = 274;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble: 7.332557f],
                            [NSNumber numberWithDouble:13.671983f],
                            [NSNumber numberWithDouble:-0.130060f],
                            [NSNumber numberWithDouble:-0.198374f],
                            [NSNumber numberWithDouble: 0.066734f],
                            [NSNumber numberWithDouble: 0.107105f],
                            [NSNumber numberWithDouble:-0.023818f],
                            [NSNumber numberWithDouble:-0.050471f],
                            [NSNumber numberWithDouble: 0.011368f],
                            [NSNumber numberWithDouble: 0.016032f],
                            [NSNumber numberWithDouble:-0.004846f],
                            [NSNumber numberWithDouble:-0.004398f],
                            [NSNumber numberWithDouble: 0.001903f],
                            [NSNumber numberWithDouble: 0.001381f],
                            [NSNumber numberWithDouble:-0.000752f],
                            [NSNumber numberWithDouble:-0.000472f],
                            [NSNumber numberWithDouble: 0.000303f],
                            [NSNumber numberWithDouble: 0.000155f],
                            [NSNumber numberWithDouble:-0.000122f],
                            [NSNumber numberWithDouble:-0.000049f],
                            [NSNumber numberWithDouble: 0.000048f],
                            [NSNumber numberWithDouble: 0.000015f],
                            [NSNumber numberWithDouble:-0.000019f],
                            [NSNumber numberWithDouble:-0.000004f],
                            [NSNumber numberWithDouble: 0.000008f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble:-0.000003f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble: -8.01116f],
                             [NSNumber numberWithDouble: -0.97859f],
                             [NSNumber numberWithDouble:-16.73781f],
                             [NSNumber numberWithDouble:  2.88562f],
                             [NSNumber numberWithDouble:  8.27150f],
                             [NSNumber numberWithDouble: -1.01986f],
                             [NSNumber numberWithDouble: -1.49341f],
                             [NSNumber numberWithDouble:  0.31376f],
                             [NSNumber numberWithDouble:  0.28101f],
                             [NSNumber numberWithDouble: -0.07987f],
                             [NSNumber numberWithDouble: -0.07281f],
                             [NSNumber numberWithDouble:  0.02024f],
                             [NSNumber numberWithDouble:  0.02150f],
                             [NSNumber numberWithDouble: -0.00665f],
                             [NSNumber numberWithDouble: -0.00639f],
                             [NSNumber numberWithDouble:  0.00255f],
                             [NSNumber numberWithDouble:  0.00190f],
                             [NSNumber numberWithDouble: -0.00101f],
                             [NSNumber numberWithDouble: -0.00057f],
                             [NSNumber numberWithDouble:  0.00040f],
                             [NSNumber numberWithDouble:  0.00017f],
                             [NSNumber numberWithDouble: -0.00016f],
                             [NSNumber numberWithDouble: -0.00005f],
                             [NSNumber numberWithDouble:  0.00006f],
                             [NSNumber numberWithDouble:  0.00001f],
                             [NSNumber numberWithDouble: -0.00002f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble:  0.00001f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble:  0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.934763f],
                            [NSNumber numberWithDouble:-0.004768f],
                            [NSNumber numberWithDouble:-0.035397f],
                            [NSNumber numberWithDouble: 0.015781f],
                            [NSNumber numberWithDouble: 0.015305f],
                            [NSNumber numberWithDouble:-0.000768f],
                            [NSNumber numberWithDouble:-0.000681f],
                            [NSNumber numberWithDouble:-0.001163f],
                            [NSNumber numberWithDouble:-0.000306f],
                            [NSNumber numberWithDouble: 0.000500f],
                            [NSNumber numberWithDouble: 0.000078f],
                            [NSNumber numberWithDouble:-0.000150f],
                            [NSNumber numberWithDouble:-0.000014f],
                            [NSNumber numberWithDouble: 0.000034f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble:-0.000006f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 273;
            b = 305;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:10.064722f],
                            [NSNumber numberWithDouble:14.032109f],
                            [NSNumber numberWithDouble:-0.277548f],
                            [NSNumber numberWithDouble:-0.092675f],
                            [NSNumber numberWithDouble: 0.164748f],
                            [NSNumber numberWithDouble:-0.007091f],
                            [NSNumber numberWithDouble:-0.078782f],
                            [NSNumber numberWithDouble: 0.023878f],
                            [NSNumber numberWithDouble: 0.029103f],
                            [NSNumber numberWithDouble:-0.012360f],
                            [NSNumber numberWithDouble:-0.005477f],
                            [NSNumber numberWithDouble: 0.004985f],
                            [NSNumber numberWithDouble:-0.000219f],
                            [NSNumber numberWithDouble:-0.001690f],
                            [NSNumber numberWithDouble: 0.000715f],
                            [NSNumber numberWithDouble: 0.000436f],
                            [NSNumber numberWithDouble:-0.000398f],
                            [NSNumber numberWithDouble:-0.000046f],
                            [NSNumber numberWithDouble: 0.000155f],
                            [NSNumber numberWithDouble:-0.000033f],
                            [NSNumber numberWithDouble:-0.000045f],
                            [NSNumber numberWithDouble: 0.000028f],
                            [NSNumber numberWithDouble: 0.000008f],
                            [NSNumber numberWithDouble:-0.000013f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000005f],
                            [NSNumber numberWithDouble:-0.000002f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble: -5.71821f],
                             [NSNumber numberWithDouble: -2.33908f],
                             [NSNumber numberWithDouble:-10.40420f],
                             [NSNumber numberWithDouble: 12.39565f],
                             [NSNumber numberWithDouble:  5.29756f],
                             [NSNumber numberWithDouble: -3.50907f],
                             [NSNumber numberWithDouble: -0.37739f],
                             [NSNumber numberWithDouble:  0.67160f],
                             [NSNumber numberWithDouble: -0.15688f],
                             [NSNumber numberWithDouble: -0.10182f],
                             [NSNumber numberWithDouble:  0.07909f],
                             [NSNumber numberWithDouble:  0.00039f],
                             [NSNumber numberWithDouble: -0.02535f],
                             [NSNumber numberWithDouble:  0.00725f],
                             [NSNumber numberWithDouble:  0.00572f],
                             [NSNumber numberWithDouble: -0.00392f],
                             [NSNumber numberWithDouble: -0.00062f],
                             [NSNumber numberWithDouble:  0.00153f],
                             [NSNumber numberWithDouble: -0.00025f],
                             [NSNumber numberWithDouble: -0.00047f],
                             [NSNumber numberWithDouble:  0.00022f],
                             [NSNumber numberWithDouble:  0.00010f],
                             [NSNumber numberWithDouble: -0.00011f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble:  0.00004f],
                             [NSNumber numberWithDouble: -0.00001f],
                             [NSNumber numberWithDouble: -0.00001f],
                             [NSNumber numberWithDouble:  0.00001f],
                             [NSNumber numberWithDouble:  0.00000f],
                             [NSNumber numberWithDouble:  0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.944123f],
                            [NSNumber numberWithDouble:-0.007484f],
                            [NSNumber numberWithDouble:-0.011663f],
                            [NSNumber numberWithDouble: 0.037691f],
                            [NSNumber numberWithDouble: 0.005770f],
                            [NSNumber numberWithDouble:-0.004697f],
                            [NSNumber numberWithDouble: 0.001303f],
                            [NSNumber numberWithDouble:-0.001439f],
                            [NSNumber numberWithDouble:-0.000525f],
                            [NSNumber numberWithDouble: 0.000655f],
                            [NSNumber numberWithDouble:-0.000064f],
                            [NSNumber numberWithDouble:-0.000160f],
                            [NSNumber numberWithDouble: 0.000063f],
                            [NSNumber numberWithDouble: 0.000019f],
                            [NSNumber numberWithDouble:-0.000016f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 304;
            b = 335;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:12.810191f],
                            [NSNumber numberWithDouble:13.523720f],
                            [NSNumber numberWithDouble:-0.403951f],
                            [NSNumber numberWithDouble: 0.088679f],
                            [NSNumber numberWithDouble: 0.137197f],
                            [NSNumber numberWithDouble:-0.109158f],
                            [NSNumber numberWithDouble: 0.021670f],
                            [NSNumber numberWithDouble: 0.057749f],
                            [NSNumber numberWithDouble:-0.020431f],
                            [NSNumber numberWithDouble:-0.009533f],
                            [NSNumber numberWithDouble: 0.007078f],
                            [NSNumber numberWithDouble:-0.001876f],
                            [NSNumber numberWithDouble:-0.000658f],
                            [NSNumber numberWithDouble: 0.001499f],
                            [NSNumber numberWithDouble:-0.000633f],
                            [NSNumber numberWithDouble:-0.000331f],
                            [NSNumber numberWithDouble: 0.000357f],
                            [NSNumber numberWithDouble:-0.000056f],
                            [NSNumber numberWithDouble:-0.000073f],
                            [NSNumber numberWithDouble: 0.000062f],
                            [NSNumber numberWithDouble:-0.000015f],
                            [NSNumber numberWithDouble:-0.000017f],
                            [NSNumber numberWithDouble: 0.000016f],
                            [NSNumber numberWithDouble:-0.000002f],
                            [NSNumber numberWithDouble:-0.000005f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble:-0.83416f],
                             [NSNumber numberWithDouble:-4.63794f],
                             [NSNumber numberWithDouble: 0.81425f],
                             [NSNumber numberWithDouble:15.59346f],
                             [NSNumber numberWithDouble:-1.01860f],
                             [NSNumber numberWithDouble:-3.04033f],
                             [NSNumber numberWithDouble: 0.80255f],
                             [NSNumber numberWithDouble: 0.01533f],
                             [NSNumber numberWithDouble:-0.17123f],
                             [NSNumber numberWithDouble: 0.12457f],
                             [NSNumber numberWithDouble:-0.03389f],
                             [NSNumber numberWithDouble:-0.03692f],
                             [NSNumber numberWithDouble: 0.02720f],
                             [NSNumber numberWithDouble: 0.00012f],
                             [NSNumber numberWithDouble:-0.00668f],
                             [NSNumber numberWithDouble: 0.00350f],
                             [NSNumber numberWithDouble:-0.00014f],
                             [NSNumber numberWithDouble:-0.00118f],
                             [NSNumber numberWithDouble: 0.00074f],
                             [NSNumber numberWithDouble: 0.00004f],
                             [NSNumber numberWithDouble:-0.00027f],
                             [NSNumber numberWithDouble: 0.00012f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble:-0.00005f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble: 0.00001f],
                             [NSNumber numberWithDouble:-0.00001f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.957685f],
                            [NSNumber numberWithDouble:-0.015024f],
                            [NSNumber numberWithDouble: 0.020140f],
                            [NSNumber numberWithDouble: 0.041231f],
                            [NSNumber numberWithDouble:-0.008183f],
                            [NSNumber numberWithDouble:-0.001447f],
                            [NSNumber numberWithDouble: 0.001693f],
                            [NSNumber numberWithDouble:-0.002740f],
                            [NSNumber numberWithDouble: 0.000176f],
                            [NSNumber numberWithDouble: 0.000541f],
                            [NSNumber numberWithDouble:-0.000272f],
                            [NSNumber numberWithDouble: 0.000014f],
                            [NSNumber numberWithDouble: 0.000058f],
                            [NSNumber numberWithDouble:-0.000027f],
                            [NSNumber numberWithDouble: 0.000005f],
                            [NSNumber numberWithDouble: 0.000004f],
                            [NSNumber numberWithDouble:-0.000004f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
                break;
                
            }
            
            a = 334;
            b = 367;
            if (t >= a && t <= b) {
                
                RAArray = @[[NSNumber numberWithDouble:15.610629f],
                            [NSNumber numberWithDouble:13.945965f],
                            [NSNumber numberWithDouble:-0.343769f],
                            [NSNumber numberWithDouble: 0.320330f],
                            [NSNumber numberWithDouble: 0.082060f],
                            [NSNumber numberWithDouble:-0.051068f],
                            [NSNumber numberWithDouble: 0.108223f],
                            [NSNumber numberWithDouble:-0.010479f],
                            [NSNumber numberWithDouble:-0.039542f],
                            [NSNumber numberWithDouble: 0.010381f],
                            [NSNumber numberWithDouble: 0.000957f],
                            [NSNumber numberWithDouble:-0.001695f],
                            [NSNumber numberWithDouble: 0.001555f],
                            [NSNumber numberWithDouble:-0.001441f],
                            [NSNumber numberWithDouble: 0.000106f],
                            [NSNumber numberWithDouble: 0.000678f],
                            [NSNumber numberWithDouble:-0.000301f],
                            [NSNumber numberWithDouble:-0.000023f],
                            [NSNumber numberWithDouble: 0.000063f],
                            [NSNumber numberWithDouble:-0.000046f],
                            [NSNumber numberWithDouble: 0.000029f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble:-0.000016f],
                            [NSNumber numberWithDouble: 0.000009f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble:-0.000002f],
                            [NSNumber numberWithDouble: 0.000001f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                DecArray = @[[NSNumber numberWithDouble: 4.40306f],
                             [NSNumber numberWithDouble:-1.59302f],
                             [NSNumber numberWithDouble:12.42192f],
                             [NSNumber numberWithDouble:11.80356f],
                             [NSNumber numberWithDouble:-6.52098f],
                             [NSNumber numberWithDouble:-1.71572f],
                             [NSNumber numberWithDouble: 0.80212f],
                             [NSNumber numberWithDouble:-0.35149f],
                             [NSNumber numberWithDouble: 0.08926f],
                             [NSNumber numberWithDouble: 0.00011f],
                             [NSNumber numberWithDouble:-0.07631f],
                             [NSNumber numberWithDouble: 0.05937f],
                             [NSNumber numberWithDouble: 0.00687f],
                             [NSNumber numberWithDouble:-0.01490f],
                             [NSNumber numberWithDouble: 0.00570f],
                             [NSNumber numberWithDouble:-0.00114f],
                             [NSNumber numberWithDouble:-0.00065f],
                             [NSNumber numberWithDouble: 0.00134f],
                             [NSNumber numberWithDouble:-0.00085f],
                             [NSNumber numberWithDouble:-0.00007f],
                             [NSNumber numberWithDouble: 0.00030f],
                             [NSNumber numberWithDouble:-0.00013f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble:-0.00003f],
                             [NSNumber numberWithDouble: 0.00002f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble:-0.00001f],
                             [NSNumber numberWithDouble: 0.00000f],
                             [NSNumber numberWithDouble: 0.00000f]];
                
                HPArray = @[[NSNumber numberWithDouble: 0.971167f],
                            [NSNumber numberWithDouble:-0.007136f],
                            [NSNumber numberWithDouble: 0.048277f],
                            [NSNumber numberWithDouble: 0.031163f],
                            [NSNumber numberWithDouble:-0.019416f],
                            [NSNumber numberWithDouble: 0.001204f],
                            [NSNumber numberWithDouble:-0.000583f],
                            [NSNumber numberWithDouble:-0.003446f],
                            [NSNumber numberWithDouble: 0.001140f],
                            [NSNumber numberWithDouble: 0.000284f],
                            [NSNumber numberWithDouble:-0.000239f],
                            [NSNumber numberWithDouble: 0.000158f],
                            [NSNumber numberWithDouble:-0.000013f],
                            [NSNumber numberWithDouble:-0.000023f],
                            [NSNumber numberWithDouble: 0.000019f],
                            [NSNumber numberWithDouble:-0.000008f],
                            [NSNumber numberWithDouble:-0.000002f],
                            [NSNumber numberWithDouble: 0.000003f],
                            [NSNumber numberWithDouble:-0.000001f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f],
                            [NSNumber numberWithDouble: 0.000000f]];
                
                
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
    double a = 0, b = 0;
    
    switch (year) {
        case 2016:
            
            a = 0;
            b = 122;
            
            if (t >= a && t <= b) {
                

                
                RArray = @[[NSNumber numberWithDouble:10.615288f],
                           [NSNumber numberWithDouble: 4.008264f],
                           [NSNumber numberWithDouble:-0.000011f],
                           [NSNumber numberWithDouble: 0.000006f],
                           [NSNumber numberWithDouble: 0.000000f],
                           [NSNumber numberWithDouble: 0.000000f],
                           [NSNumber numberWithDouble: 0.000001f],
                           [NSNumber numberWithDouble: 0.000001f]];
                break;
            }
            
            a = 121;
            b = 245;
            
            
            if (t >= a && t <= b) {
                

                RArray = @[[NSNumber numberWithDouble:18.631851f],
                           [NSNumber numberWithDouble: 4.074014f],
                           [NSNumber numberWithDouble:-0.000003f],
                           [NSNumber numberWithDouble:-0.000006f],
                           [NSNumber numberWithDouble: 0.000000f],
                           [NSNumber numberWithDouble: 0.000001f],
                           [NSNumber numberWithDouble: 0.000002f],
                           [NSNumber numberWithDouble: 0.000001f]];
                break;
            }
            
            a = 244;
            b = 367;
            
            if (t >= a && t <= b) {
                
                
                RArray = @[[NSNumber numberWithDouble: 2.681266f],
                           [NSNumber numberWithDouble: 4.041134f],
                           [NSNumber numberWithDouble: 0.000019f],
                           [NSNumber numberWithDouble: 0.000002f],
                           [NSNumber numberWithDouble:-0.000003f],
                           [NSNumber numberWithDouble:-0.000001f],
                           [NSNumber numberWithDouble: 0.000003f],
                           [NSNumber numberWithDouble: 0.000000f]];
                break;
            }
            
            break;
         
        case 2017:
            
            a = 0;
            b = 121;
            
            if (t >= a && t <= b) {
                
                
                
                RArray = @[[NSNumber numberWithDouble:10.632133f],
                           [NSNumber numberWithDouble: 3.975411f],
                           [NSNumber numberWithDouble:-0.000010f],
                           [NSNumber numberWithDouble: 0.000004f],
                           [NSNumber numberWithDouble: 0.000000f],
                           [NSNumber numberWithDouble:-0.000001f],
                           [NSNumber numberWithDouble: 0.000001f],
                           [NSNumber numberWithDouble:-0.000001f]];
                break;
            }
            
            a = 120;
            b = 244;
            
            
            if (t >= a && t <= b) {
                
                
                RArray = @[[NSNumber numberWithDouble:18.615845f],
                           [NSNumber numberWithDouble: 4.074018f],
                           [NSNumber numberWithDouble:-0.000005f],
                           [NSNumber numberWithDouble:-0.000007f],
                           [NSNumber numberWithDouble: 0.000000f],
                           [NSNumber numberWithDouble:-0.000001f],
                           [NSNumber numberWithDouble: 0.000000f],
                           [NSNumber numberWithDouble:-0.000002f]];
                break;
            }
            
            a = 243;
            b = 367;
            
            if (t >= a && t <= b) {
                
                
                RArray = @[[NSNumber numberWithDouble: 2.665265f],
                           [NSNumber numberWithDouble: 4.041138f],
                           [NSNumber numberWithDouble: 0.000017f],
                           [NSNumber numberWithDouble: 0.000000f],
                           [NSNumber numberWithDouble:-0.000001f],
                           [NSNumber numberWithDouble:-0.000001f],
                           [NSNumber numberWithDouble:-0.000001f],
                           [NSNumber numberWithDouble:-0.000002f]];
                break;
            }
            
            break;
            

            
        default:
            break;
    }
    
    return @{@"RArray":RArray,@"a":[NSNumber numberWithDouble:a],@"b":[NSNumber numberWithDouble:b]};
    
}

+(NSDictionary *)dictionaryOfEbyYear:(int)year
                      tWithoutDeltaT:(double)t {
    NSArray *EArray = [NSArray new];
    double a = 0, b = 0;
    
    switch (year) {
        case 2016:
            
            a = 0;
            b = 122;
            
            if (t >= a && t <= b) {
                
                
                
                EArray = @[[NSNumber numberWithDouble:23.43464f],
                           [NSNumber numberWithDouble: 0.00011f],
                           [NSNumber numberWithDouble:-0.00009f],
                           [NSNumber numberWithDouble:-0.00004f],
                           [NSNumber numberWithDouble: 0.00001f],
                           [NSNumber numberWithDouble:-0.00001f],
                           [NSNumber numberWithDouble: 0.00001f],
                           [NSNumber numberWithDouble:-0.00001f]];
                break;
            }
            
            a = 121;
            b = 245;
            
            
            if (t >= a && t <= b) {
                
                
                EArray = @[[NSNumber numberWithDouble:23.43461f],
                           [NSNumber numberWithDouble: 0.00009f],
                           [NSNumber numberWithDouble: 0.00012f],
                           [NSNumber numberWithDouble:-0.00002f],
                           [NSNumber numberWithDouble:-0.00001f],
                           [NSNumber numberWithDouble:-0.00000f],
                           [NSNumber numberWithDouble: 0.00000f],
                           [NSNumber numberWithDouble:-0.00001f]];
                break;
            }
            
            a = 244;
            b = 367;
            
            if (t >= a && t <= b) {
                
                
                EArray = @[[NSNumber numberWithDouble:23.43468f],
                           [NSNumber numberWithDouble:-0.00015f],
                           [NSNumber numberWithDouble:-0.00002f],
                           [NSNumber numberWithDouble: 0.00004f],
                           [NSNumber numberWithDouble: 0.00000f],
                           [NSNumber numberWithDouble:-0.00001f],
                           [NSNumber numberWithDouble:-0.00000f],
                           [NSNumber numberWithDouble:-0.00002f]];
                break;
            }
            
            break;
            
        case 2017:
            
            a = 0;
            b = 121;
            
            if (t >= a && t <= b) {
                
                
                
                EArray = @[[NSNumber numberWithDouble:23.43477f],
                           [NSNumber numberWithDouble: 0.00016f],
                           [NSNumber numberWithDouble:-0.00011f],
                           [NSNumber numberWithDouble:-0.00004f],
                           [NSNumber numberWithDouble: 0.00002f],
                           [NSNumber numberWithDouble: 0.00000f],
                           [NSNumber numberWithDouble:-0.00001f],
                           [NSNumber numberWithDouble:-0.00001f]];
                break;
            }
            
            a = 120;
            b = 244;
            
            
            if (t >= a && t <= b) {
                
                
                EArray = @[[NSNumber numberWithDouble:23.43483f],
                           [NSNumber numberWithDouble: 0.00012f],
                           [NSNumber numberWithDouble: 0.00010f],
                           [NSNumber numberWithDouble:-0.00001f],
                           [NSNumber numberWithDouble:-0.00001f],
                           [NSNumber numberWithDouble: 0.00000f],
                           [NSNumber numberWithDouble:-0.00002f],
                           [NSNumber numberWithDouble: 0.00000f]];
                break;
            }
            
            a = 243;
            b = 367;
            
            if (t >= a && t <= b) {
                
                
                EArray = @[[NSNumber numberWithDouble:23.43499f],
                           [NSNumber numberWithDouble:-0.00011f],
                           [NSNumber numberWithDouble:-0.00004f],
                           [NSNumber numberWithDouble: 0.00005f],
                           [NSNumber numberWithDouble: 0.00001f],
                           [NSNumber numberWithDouble: 0.00000f],
                           [NSNumber numberWithDouble:-0.00002f],
                           [NSNumber numberWithDouble: 0.00000f]];
                break;
            }
            
            break;
            
            
            
        default:
            break;
    }
    
    return @{@"EArray":EArray,@"a":[NSNumber numberWithDouble:a],@"b":[NSNumber numberWithDouble:b]};
    
}


@end
