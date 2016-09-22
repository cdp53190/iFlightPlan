//
//  PlanHeaderView.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/09/21.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "PlanHeaderView.h"

@implementation PlanHeaderView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    CGFloat Xichi = 0;
    CGFloat labelHeight = [PlanTableViewCell rowHeight] / 2 - 8;
    NSInteger numberOfColumn = 0;
    
    for (NSNumber *widthPercent in _widthPercentArray) {
        
        
        CGFloat actWidth = self.frame.size.width * widthPercent.doubleValue;
        
        UILabel *label1, *label2;
        
        label1 = [[UILabel alloc]initWithFrame:CGRectMake(Xichi + 4, 4, actWidth - 8.0, labelHeight)];
        label2 = [[UILabel alloc]initWithFrame:CGRectMake(Xichi + 4, labelHeight + 12, actWidth - 8, labelHeight)];
        
        label1.font = [UIFont systemFontOfSize:20];
        label1.adjustsFontSizeToFitWidth = YES;
        label1.minimumScaleFactor = 0.5;
        
        label2.font = [UIFont systemFontOfSize:20];
        label2.adjustsFontSizeToFitWidth = YES;
        label2.minimumScaleFactor = 0.5;
        
        if (numberOfColumn < _upperLabelTitleArray.count) {
            label1.text = _upperLabelTitleArray[numberOfColumn];
        }
        
        if (numberOfColumn < _lowerLabelTitleArray.count) {
            label2.text = _lowerLabelTitleArray[numberOfColumn];
        }
        
        [self addSubview:label1];
        [self addSubview:label2];
        
        Xichi += actWidth;
        
         if (Xichi != self.frame.size.width){
         
             // create bezierPath instance
             UIBezierPath *aPath = [UIBezierPath bezierPath];
             
             // set render color and style
             [[UIColor blackColor] setStroke];
             aPath.lineWidth = 0.8;
             
             // set start point
             [aPath moveToPoint:CGPointMake(Xichi, 0)];
             
             //draw line
             [aPath addLineToPoint:CGPointMake(Xichi, self.frame.size.height)];
             
             //rendering
             [aPath stroke];
             
             [aPath moveToPoint:CGPointMake(0,self.frame.size.height)];
             [aPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
             [aPath stroke];
        
         }
        numberOfColumn++;
        
        
    }
    




}


@end
