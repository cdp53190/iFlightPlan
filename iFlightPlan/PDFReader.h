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

@interface PDFReader : NSObject


-(void)testWithPathString:(NSString *)path;

// オペレータコールバック
- (void)operatorTextScanned:(CGPDFScannerRef)scanner;
- (void)operatorFontScanned:(CGPDFScannerRef)scanner;

@end


