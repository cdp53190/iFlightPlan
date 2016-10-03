//
//  PlanHeaderView.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/09/21.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "PlanHeaderView.h"

@implementation PlanHeaderView



-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSArray *widthPercentArray = [ud objectForKey:@"widthPercentArray"];
    
    NSInteger numberOfColumn = 1;
    
    for (NSNumber *widthPercent in widthPercentArray) {
        
        
        UINib *nib = [UINib nibWithNibName:@"PlanColumnView" bundle:nil];
        PlanColumnView *columnView = [nib instantiateWithOwner:self options:nil][0];
        
        [columnView setTag:numberOfColumn];
        
        [columnView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        if (numberOfColumn == widthPercentArray.count) {
            [columnView.lineView setHidden:YES];
        }
        

        
        [self addSubview:columnView];
        
        NSLayoutConstraint *layoutTop = [NSLayoutConstraint constraintWithItem:columnView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0.0];
        
        NSLayoutConstraint *layoutLeft;
        
        if (numberOfColumn == 1) {
            
            layoutLeft = [NSLayoutConstraint constraintWithItem:columnView
                                                      attribute:NSLayoutAttributeLeft
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self
                                                      attribute:NSLayoutAttributeLeft
                                                     multiplier:1.0
                                                       constant:0.0];
            
        } else {
            
            layoutLeft = [NSLayoutConstraint constraintWithItem:columnView
                                                      attribute:NSLayoutAttributeLeft
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:[self viewWithTag:numberOfColumn - 1]
                                                      attribute:NSLayoutAttributeRight
                                                     multiplier:1.0
                                                       constant:0.0];
            
        }
        
        NSLayoutConstraint *layoutBottom = [NSLayoutConstraint constraintWithItem:columnView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0.0];
        
        NSLayoutConstraint *layoutWidth = [NSLayoutConstraint constraintWithItem:columnView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:widthPercent.doubleValue
                                                                        constant:0.0];
        
        
        
        NSArray *layoutConstraints = @[layoutTop,
                                       layoutBottom,
                                       layoutLeft,
                                       layoutWidth];
        
        
        [self addConstraints:layoutConstraints];
        
        numberOfColumn++;
        
        
    }
    
    
    
    UIView *lineView = [[UIView alloc] init];
    
    lineView.backgroundColor = [UIColor blackColor];
    
    [lineView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:lineView];
    
  
    NSLayoutConstraint *layoutLeft = [NSLayoutConstraint constraintWithItem:lineView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0
                                                                   constant:0.0];
        
    NSLayoutConstraint *layoutRight = [NSLayoutConstraint constraintWithItem:lineView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0
                                                                    constant:0.0];
    
    NSLayoutConstraint *layoutBottom = [NSLayoutConstraint constraintWithItem:lineView
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1.0
                                                                     constant:0.0];
    
    NSLayoutConstraint *layoutHeight = [NSLayoutConstraint constraintWithItem:lineView
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0
                                                                     constant:1.0];
    
    NSArray *layoutConstraints = @[layoutLeft,
                                   layoutRight,
                                   layoutBottom,
                                   layoutHeight];
    
    
    
    [self addConstraints:layoutConstraints];

    
    
    
    
}





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    
    for (int numberOfColumn = 0; numberOfColumn < _upperLabelTitleArray.count; numberOfColumn++) {
        
        ((PlanColumnView *)[self viewWithTag:numberOfColumn+1]).upperLabel.text = _upperLabelTitleArray[numberOfColumn];

        if (numberOfColumn < _lowerLabelTitleArray.count) {
            ((PlanColumnView *)[self viewWithTag:numberOfColumn+1]).lowerLabel.text = _lowerLabelTitleArray[numberOfColumn];
        }
        
        
    }

    
    
}


@end
