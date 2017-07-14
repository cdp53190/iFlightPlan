//
//  PlanColumnView.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/01.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DoubleLinePlanColumnView;

@protocol DoubleLinePlanColumnViewDelegate <NSObject>

@optional

-(void)touchedDoubleLinePlanColumnView:(DoubleLinePlanColumnView *)doubleLineColumnView
                           columnTitle:(NSString *)columnTitle
                             rowNumber:(NSInteger)rowNumber;

@end

@interface DoubleLinePlanColumnView : UIView

@property (nonatomic, weak) id<DoubleLinePlanColumnViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet UILabel *upperLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowerLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property NSInteger rowNo;
@property NSArray *columnListArray;
@property NSString *columnTitle;

@end
