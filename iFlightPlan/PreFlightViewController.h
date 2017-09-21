//
//  PreFlightViewController.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/07/21.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteCopy.h"
#import "SELCALPlayer.h"
#import "SaveDataPackage.h"
#import "WeatherForcast.h"

@interface PreFlightViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSURLSessionTaskDelegate, WeatherForcastDelegate>

@property IBOutlet UITableView *legsTableView;
@property IBOutlet UILabel *sunRiseSetLabel;
@property IBOutlet UILabel *moonRiseSetPhaseLabel;
@property IBOutlet UILabel *previousForcastLabel;
@property IBOutlet UILabel *posteriorForcastLabel;
@property IBOutlet UILabel *depAPOLabel, *depTimeLabel;
@property IBOutlet UILabel *arrAPOLabel, *arrTimeLabel;
@property IBOutlet UILabel *FMCCourseLabel;


@property IBOutlet UIButton *getWeatherForcastButton;


@end
