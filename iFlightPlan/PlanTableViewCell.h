//
//  PlanTableViewCell.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/05/01.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubleLinePlanColumnView.h"

@interface PlanTableViewCell : UITableViewCell

@property NSArray *widthPercentArray;

+(CGFloat)rowHeight;

@end
