//
//  FuelEntryViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/13.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FuelEntryViewController;

@protocol FuelEntryViewControllerDelegate <NSObject>

@optional
-(void)willDismissFuelEntryViewController;

@required
-(void)fuelEntryViewController:(FuelEntryViewController *)fuelEntryViewController
     willDismissWithFuelString:(NSString *)fuelString
                   columnTitle:(NSString *)columnTitle
                     rowNumber:(NSInteger)rowNo;


@end


@interface FuelEntryViewController : UIViewController

@property (nonatomic, weak) id<FuelEntryViewControllerDelegate> delegate;

@property NSString *columnTitle;
@property NSInteger rowNo;
@property NSMutableString *returnString;
@property NSString *Efuel;

@property IBOutlet UIButton *pointButton;
@property IBOutlet UIButton *BSButton;
@property IBOutlet UIBarButtonItem *doneButton;

-(IBAction)pushDigit:(UIButton *)sender;
-(IBAction)pushBS:(id)sender;
-(IBAction)pushCancel:(UIBarButtonItem *)sender;
-(IBAction)pushDone:(UIBarButtonItem *)sender;

@end
