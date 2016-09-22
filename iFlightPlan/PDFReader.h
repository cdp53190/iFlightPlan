//
//  PDFReader.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/09/21.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PDFReader : NSObject


-(void)test;

// オペレータコールバック
- (void)operatorTextScanned:(CGPDFScannerRef)scanner;


@end


