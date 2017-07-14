//
//  SunMoonViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/03/25.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "SunMoonViewController.h"

@interface SunMoonViewController ()

@end

@implementation SunMoonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(planReload) name:@"planReload" object:nil];

    
    self.headerHeightConstraint.constant = 50;
    
    //ヘッダ描画
    [self makeHeaderView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)planReload {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    self.navigationItem.title = [ud objectForKey:@"dataDic"][@"Flight Number"];
    
    self.planArray = [NSMutableArray arrayWithArray:[ud objectForKey:@"sunMoonPlanArray"]];
    
    [self.planTableView reloadData];
    
    _takeoffYear = [[ud objectForKey:@"sunMoonTakeoffYear"] intValue];
    _takeoffMonth = [[ud objectForKey:@"sunMoonTakeoffMonth"] intValue];
    _takeoffDay = [[ud objectForKey:@"sunMoonTakeoffDay"] intValue];
    _takeoffHour = [[ud objectForKey:@"sunMoonTakeoffHour"] intValue];
    _takeoffMinute = [[ud objectForKey:@"sunMoonTakeoffMinute"] intValue];
    
    [self.takeoffTimeBtn setTitle:[NSString stringWithFormat:@"T/O : %04d/%02d/%02d %02d%02dZ",
                                   _takeoffYear,
                                   _takeoffMonth,
                                   _takeoffDay,
                                   _takeoffHour,
                                   _takeoffMinute]];
    
    double moonPhase = [[ud objectForKey:@"moonPhase"]doubleValue];
    
    if (moonPhase == -1.0) {
        moonPhase = [SunMoon moonPhaseWithYear:_takeoffYear
                                         month:_takeoffMonth
                                           day:_takeoffDay
                                          hour:_takeoffHour
                                        minute:_takeoffMinute];
        
        [ud setObject:[NSNumber numberWithDouble:moonPhase] forKey:@"moonPhase"];
        [ud synchronize];
        
    }
    
    _moonPhaseLabel.text = [NSString stringWithFormat:@"Moon Phase at T/O : %.1fday(s)", moonPhase];

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    return 25;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    PlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    if (!cell) {
        cell = [[PlanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:self.cellIdentifier
                                       columnListArray:self.columnListArray
                                        viewController:self
                                             rowNumber:indexPath.row];
    } else {
        [(PlanTableViewCell *)cell setRowNumber:(int)indexPath.row];
    }
    
    int numberOfColumn = 1;
    
    
    for (NSDictionary *dic in self.columnListArray) {
        
        NSString *title = dic[@"title"];
        
        SingleLinePlanColumnView *columnView = [cell.contentView viewWithTag:numberOfColumn];
        
        if ([title isEqualToString:@"CTM"]) {
            columnView.label.text = self.planArray[indexPath.row][@"CTMString"];
        } else if ([title isEqualToString:@"TIME"]) {
            columnView.label.text = self.planArray[indexPath.row][@"TIMEString"];
        } else if ([title isEqualToString:@"LAT"]) {
            columnView.label.text = self.planArray[indexPath.row][@"latString"];
        } else if ([title isEqualToString:@"LON"]) {
            columnView.label.text = self.planArray[indexPath.row][@"lonString"];
        } else if ([title isEqualToString:@"FL"]) {
            columnView.label.text = self.planArray[indexPath.row][@"FLString"];
        } else {
            columnView.label.text = self.planArray[indexPath.row][title];
        }
        
        numberOfColumn++;
        
    }
    
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return cell;

    
    
    
}


-(void)makeHeaderView {
    
    NSInteger numberOfColumn = 1;
    for (NSDictionary *dic in self.columnListArray) {
        
        UIView *columnView;
        
        
        UINib *nib = [UINib nibWithNibName:@"DoubleLinePlanColumnView" bundle:nil];
        columnView = [nib instantiateWithOwner:self options:nil][0];
        
        if (numberOfColumn == self.columnListArray.count) {
            [((SingleLinePlanColumnView *)columnView).lineView setHidden:YES];
        }
        
        NSString *title = dic[@"title"];
        if ([title isEqualToString:@"SunDIR"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"Sun DIR";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @" (deg)";
        } else if ([title isEqualToString:@"SunALT"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"Sun ALT";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @" (deg)";
        } else if ([title isEqualToString:@"SunSTATUS"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"Sun";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @"STATUS";
        } else if ([title isEqualToString:@"MoonDIR"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"MoonDIR";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @" (deg)";
        } else if ([title isEqualToString:@"MoonALT"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"MoonALT";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @" (deg)";
        } else if ([title isEqualToString:@"MoonSTATUS"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"Moon";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @"STATUS";
        } else {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = title;
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @"";
        }
        
        [columnView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        
        
        [columnView setTag:numberOfColumn];
        
        
        [self.headerView addSubview:columnView];
        
        NSLayoutConstraint *layoutTop = [NSLayoutConstraint constraintWithItem:columnView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.headerView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0.0];
        
        NSLayoutConstraint *layoutLeft;
        
        if (numberOfColumn == 1) {
            
            layoutLeft = [NSLayoutConstraint constraintWithItem:columnView
                                                      attribute:NSLayoutAttributeLeft
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.headerView
                                                      attribute:NSLayoutAttributeLeft
                                                     multiplier:1.0
                                                       constant:0.0];
            
        } else {
            
            layoutLeft = [NSLayoutConstraint constraintWithItem:columnView
                                                      attribute:NSLayoutAttributeLeft
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:[self.headerView viewWithTag:numberOfColumn - 1]
                                                      attribute:NSLayoutAttributeRight
                                                     multiplier:1.0
                                                       constant:0.0];
            
        }
        
        NSLayoutConstraint *layoutBottom = [NSLayoutConstraint constraintWithItem:columnView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.headerView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0.0];
        
        NSLayoutConstraint *layoutWidth = [NSLayoutConstraint constraintWithItem:columnView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.headerView
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:((NSNumber *)dic[@"widthPercent"]).doubleValue
                                                                        constant:0.0];
        
        
        
        NSArray *layoutConstraints = @[layoutTop,
                                       layoutBottom,
                                       layoutLeft,
                                       layoutWidth];
        
        
        [self.headerView addConstraints:layoutConstraints];
        
        numberOfColumn++;
        
    }
    
    
    [self drawUnderLine];
    
    
}


- (IBAction)unwindSegue:(UIStoryboardSegue *)segue
{
    if ([segue.identifier isEqualToString:@"doneSegue"] && self.planArray != nil) {
        
        [self sunMoonPlanTakeoffTimeChange];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"TakeoffTimeSegue"]) {
        UIViewController *VC = segue.destinationViewController;
        
        VC.preferredContentSize = CGSizeMake(500, 200);
        
        
    }
    
    
    
}

-(void)sunMoonPlanTakeoffTimeChange {
    
    NSArray *sunMoonArray = [SunMoon makeSunMoonPlanArrayWithTakeOffYear:_takeoffYear
                                                                   month:_takeoffMonth
                                                                     day:_takeoffDay
                                                                    hour:_takeoffHour
                                                                  minute:_takeoffMinute];
    
    
    self.planArray = [sunMoonArray mutableCopy];
    [self.planTableView reloadData];
    
    [self.takeoffTimeBtn setTitle:[NSString stringWithFormat:@"T/O : %04d/%02d/%02d %02d%02dZ",
                               _takeoffYear,
                               _takeoffMonth,
                               _takeoffDay,
                               _takeoffHour,
                               _takeoffMinute]];
    
    
    //月齢計算
    double moonPhase = [SunMoon moonPhaseWithYear:_takeoffYear
                                            month:_takeoffMonth
                                              day:_takeoffDay
                                             hour:_takeoffHour
                                           minute:_takeoffMinute];
    
    self.moonPhaseLabel.text = [NSString stringWithFormat:@"Moon Phase at T/O : %.1fday(s)",
                            moonPhase];
    
    
    //synchronize
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:sunMoonArray forKey:@"sunMoonPlanArray"];
    [ud setObject:[NSNumber numberWithInt:_takeoffYear] forKey:@"sunMoonTakeoffYear"];
    [ud setObject:[NSNumber numberWithInt:_takeoffMonth] forKey:@"sunMoonTakeoffMonth"];
    [ud setObject:[NSNumber numberWithInt:_takeoffDay] forKey:@"sunMoonTakeoffDay"];
    [ud setObject:[NSNumber numberWithInt:_takeoffHour] forKey:@"sunMoonTakeoffHour"];
    [ud setObject:[NSNumber numberWithInt:_takeoffMinute] forKey:@"sunMoonTakeoffMinute"];
    [ud setObject:[NSNumber numberWithDouble:moonPhase] forKey:@"moonPhase"];
    [ud synchronize];
    
    
    
}

-(IBAction)takeoffTimeBackForward:(UIBarButtonItem *)sender {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setDateFormat:@"yyyyMMddHHmm"];

    NSDate *takeOffDate = [formatter dateFromString:[NSString stringWithFormat:@"%04d%02d%02d%02d%02d",
                                                     [[ud objectForKey:@"sunMoonTakeoffYear"] intValue],
                                                     [[ud objectForKey:@"sunMoonTakeoffMonth"] intValue],
                                                     [[ud objectForKey:@"sunMoonTakeoffDay"] intValue],
                                                     [[ud objectForKey:@"sunMoonTakeoffHour"] intValue],
                                                     [[ud objectForKey:@"sunMoonTakeoffMinute"] intValue]]];
    
    NSTimeInterval timeInterval = 60.0;
    
    if (sender.tag == 1) {
        timeInterval = timeInterval * -1.0;
    }
    
    NSDate *newTakeOffDate =  [NSDate dateWithTimeInterval:timeInterval sinceDate:takeOffDate];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger flags;
    NSDateComponents *comps;
    
    flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute;
    
    comps = [calendar components:flags fromDate:newTakeOffDate];
    
    _takeoffYear = (int)comps.year;
    _takeoffMonth = (int)comps.month;
    _takeoffDay = (int)comps.day;
    _takeoffHour = (int)comps.hour;
    _takeoffMinute = (int)comps.minute;
    
    [self sunMoonPlanTakeoffTimeChange];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
