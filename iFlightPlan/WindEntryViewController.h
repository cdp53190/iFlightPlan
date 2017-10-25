//
//  WindEntryViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/10/23.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WindEntryViewController;

@protocol WindEntryViewControllerDelegate <NSObject>

@optional
-(void)willDismissWindEntryViewController;

@required
-(void)windEntryViewController:(WindEntryViewController *)timeEntryViewController
     willDismissWithTimeString:(NSString *)timeString
                   columnTitle:(NSString *)columnTitle
                     rowNumber:(NSInteger)rowNo;

@end



@interface WindEntryViewController : UIViewController

@property (nonatomic, weak) id<WindEntryViewControllerDelegate> delegate;

@property NSString *columnTitle;
@property NSInteger rowNo;


@end
