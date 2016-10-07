//
//  PlanTableViewCell.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/05/01.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleLinePlanColumnView.h"
#import "DoubleLinePlanColumnView.h"


@interface PlanTableViewCell : UITableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier columnListArray:(NSArray *)columnListArray;

@end
