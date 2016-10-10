//
//  SummeryViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/09/23.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SELCALPlayer.h"
#import "RouteCopy.h"

@interface SummeryViewController : UIViewController

@property IBOutlet UITextView *mainTextView;

- (IBAction)pushSELCAL:(UIButton *)sender;
- (IBAction)pushRoute:(UIButton *)sender;



@end
