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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier widthPercentArray:(NSArray *)widthPercentArray {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];

}

+(CGFloat)rowHeight {
    return 50;
}
@end
