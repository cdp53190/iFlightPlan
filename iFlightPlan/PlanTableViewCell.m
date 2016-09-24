//
//  PlanTableViewCell.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/05/01.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "PlanTableViewCell.h"

@implementation PlanTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat Xichi = 0;
    CGFloat labelHeight = [PlanTableViewCell rowHeight] / 2 - 8;
    NSInteger numberOfColumn = 1;

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

        label1.tag = numberOfColumn;
        label2.tag = numberOfColumn + 100;
                
        [self.contentView addSubview:label1];
        [self.contentView addSubview:label2];
        
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
            [aPath addLineToPoint:CGPointMake(Xichi, [PlanTableViewCell rowHeight])];
            
            //rendering
            [aPath stroke];
        }
        numberOfColumn++;

        
    }
    

}

+(CGFloat)rowHeight {
    return 60;
}
@end
