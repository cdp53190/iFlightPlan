//
//  PDFReader.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/09/21.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "CourseCalc.h"
#import "SunMoon.h"
#import "SaveDataPackage.h"
#import "WeatherForcast.h"


@interface PDFReader : NSObject<WeatherForcastDelegate>


-(void)readPDFWithPathString:(NSString *)path;

// オペレータコールバック
- (void)operatorTextScanned:(CGPDFScannerRef)scanner;
- (void)operatorFontScanned:(CGPDFScannerRef)scanner;

@end


