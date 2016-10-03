//
//  PlanColumnView.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/01.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanColumnView : UIView
@property (weak, nonatomic) IBOutlet UILabel *upperLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowerLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
