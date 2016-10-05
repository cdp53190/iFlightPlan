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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        _widthPercentArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"widthPercentArray"];
        
        NSInteger numberOfColumn = 1;
        
        for (NSNumber *widthPercent in _widthPercentArray) {
            
            UIView *columnView;
            
            if ([reuseIdentifier isEqualToString:@"NAVLOG"]) {
                UINib *nib = [UINib nibWithNibName:@"DoubleLinePlanColumnView" bundle:nil];
                columnView = [nib instantiateWithOwner:self options:nil][0];
                
                if (numberOfColumn == _widthPercentArray.count) {
                    [((DoubleLinePlanColumnView *)columnView).lineView setHidden:YES];
                }
            } else if (1) {
                
            }
        


            [columnView setTag:numberOfColumn];
            
            [columnView setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            
            [self.contentView addSubview:columnView];
            
            NSLayoutConstraint *layoutTop = [NSLayoutConstraint constraintWithItem:columnView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.contentView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:0.0];
            
            NSLayoutConstraint *layoutLeft;
            
            if (numberOfColumn == 1) {
                
                layoutLeft = [NSLayoutConstraint constraintWithItem:columnView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.contentView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0];
                
            } else {
                
                layoutLeft = [NSLayoutConstraint constraintWithItem:columnView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self.contentView viewWithTag:numberOfColumn - 1]
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0];
                
            }
            
            NSLayoutConstraint *layoutBottom = [NSLayoutConstraint constraintWithItem:columnView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.contentView
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1.0
                                                                             constant:0.0];
            
            NSLayoutConstraint *layoutWidth = [NSLayoutConstraint constraintWithItem:columnView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.contentView
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:widthPercent.doubleValue
                                                                            constant:0.0];
            
            
            
            NSArray *layoutConstraints = @[layoutTop,
                                           layoutBottom,
                                           layoutLeft,
                                           layoutWidth];
            
            
            [self.contentView addConstraints:layoutConstraints];
            
            numberOfColumn++;
            
            
        }

        
        
        
        
        
        
    }
    
    return self;
}

+(CGFloat)rowHeight {
    return 50;
}
@end
