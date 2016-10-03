//
//  PlanTableViewCell.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/05/01.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanColumnView.h"

@interface PlanTableViewCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier widthPercentArray:(NSArray *)widthPercentArray;


+(CGFloat)rowHeight;

@end
