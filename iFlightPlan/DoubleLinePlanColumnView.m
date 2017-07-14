//
//  PlanColumnView.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/01.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "DoubleLinePlanColumnView.h"

@implementation DoubleLinePlanColumnView

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    

    if ([self.delegate respondsToSelector:@selector(touchedDoubleLinePlanColumnView:columnTitle:rowNumber:)]) {
        [self.delegate touchedDoubleLinePlanColumnView:self
                                           columnTitle:_columnTitle
                                             rowNumber:_rowNo];
    }
    
}
         

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
