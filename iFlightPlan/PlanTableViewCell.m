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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier columnListArray:(NSArray *)columnListArray{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        
        NSInteger numberOfColumn = 1;
        
        for (NSDictionary *dic in columnListArray) {
            
            UIView *columnView;
            
            if ([reuseIdentifier isEqualToString:@"NAVLOG"]) {
                UINib *nib;
                if ([dic[@"title"] isEqualToString:@"ETO"] || [dic[@"title"] isEqualToString:@"ATO"]) {
                    nib = [UINib nibWithNibName:@"ETOATOColumnView" bundle:nil];
                } else {
                    nib = [UINib nibWithNibName:@"DoubleLinePlanColumnView" bundle:nil];
                }
                columnView = [nib instantiateWithOwner:self options:nil][0];
                ((DoubleLinePlanColumnView *)columnView).columnTitle = dic[@"title"];
                
                if (numberOfColumn == columnListArray.count) {
                    [((DoubleLinePlanColumnView *)columnView).lineView setHidden:YES];
                }
            } else if ([reuseIdentifier isEqualToString:@"SunMoon"]) {

                UINib *nib = [UINib nibWithNibName:@"SingleLinePlanColumnView" bundle:nil];
                columnView = [nib instantiateWithOwner:self options:nil][0];
                
                if (numberOfColumn == columnListArray.count) {
                    [((SingleLinePlanColumnView *)columnView).lineView setHidden:YES];
                }
                
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
                                                                          multiplier:((NSNumber *)dic[@"widthPercent"]).doubleValue
                                                                            constant:0.0];
            
            
            
            NSArray *layoutConstraints = @[layoutTop,
                                           layoutBottom,
                                           layoutLeft,
                                           layoutWidth];
            
            
            [self.contentView addConstraints:layoutConstraints];
            
            numberOfColumn++;
            
            
        }

        
        UIView *lineView = [[UIView alloc] init];
        
        lineView.backgroundColor = [UIColor blackColor];
        
        [lineView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.contentView addSubview:lineView];
        
        
        NSLayoutConstraint *layoutLeft = [NSLayoutConstraint constraintWithItem:lineView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.contentView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0.0];
        
        NSLayoutConstraint *layoutRight = [NSLayoutConstraint constraintWithItem:lineView
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.contentView
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0.0];
        
        NSLayoutConstraint *layoutBottom = [NSLayoutConstraint constraintWithItem:lineView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
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
        
        
        
        [self.contentView addConstraints:layoutConstraints];

        
        
        
        
    }
    
    return self;
}

@end
