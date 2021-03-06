//
//  TimeEntryViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/10.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimeEntryViewController;

@protocol TimeEntryViewControllerDelegate <NSObject>

@optional
-(void)willDismissTimeEntryViewController;

@required
-(void)timeEntryViewController:(TimeEntryViewController *)timeEntryViewController
     willDismissWithTimeString:(NSString *)timeString
                   columnTitle:(NSString *)columnTitle
                     rowNumber:(NSInteger)rowNo;


@end


@interface TimeEntryViewController : UIViewController

@property (nonatomic, weak) id<TimeEntryViewControllerDelegate> delegate;

@property NSString *columnTitle;
@property NSInteger rowNo;
@property NSMutableString *returnString;
@property NSString *placeHolderString;

@property IBOutlet UIButton *BSButton;
@property IBOutlet UIBarButtonItem *doneButton;

-(IBAction)pushDigit:(UIButton *)sender;
-(IBAction)pushBS:(id)sender;
-(IBAction)pushCancel:(UIBarButtonItem *)sender;
-(IBAction)pushDone:(UIBarButtonItem *)sender;

@end
