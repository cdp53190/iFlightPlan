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
    

    
    self.headerHeightConstraint.constant = 50;
    
    //ヘッダ描画
    [self makeHeaderView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [self planReload];
}


-(void)planReload {

    SaveDataPackage *dataPackage = [SaveDataPackage presentData];
    
    self.navigationItem.title = dataPackage.otherData.flightNumber;
    
    self.planArray = [NSMutableArray arrayWithArray:dataPackage.sunMoonPlanArray];
    
    TakeoffTimeData *takeoffData = dataPackage.sunMoonTakeoffDate;
    
    _takeoffDate = [takeoffData date];
    
    [self.planTableView reloadData];
    
    [self setTakeoffTimeBtnTitle];
    
    double moonPhase = dataPackage.moonPhase;
    
    //moonPhase計算値がなかったら計算させる
    if (moonPhase == -1.0) {
        moonPhase = [SunMoon moonPhaseWithDate:_takeoffDate];
        
        [SaveDataPackage savePresentDataWithMoonPhase:moonPhase];
        
    }
    
    _moonPhaseLabel.text = [NSString stringWithFormat:@"Moon Phase at T/O : %.1fday(s)", moonPhase];

    if(self.planArray.count != 0) {
        [self.planTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }

    
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
        
        SunMoonPointComponents *sunMoonComps = (SunMoonPointComponents *)self.planArray[indexPath.row];
        
        if ([title isEqualToString:@"CTM"]) {
            columnView.label.text = sunMoonComps.CTMString;
        } else if ([title isEqualToString:@"TIME"]) {
            columnView.label.text = sunMoonComps.timeString;
        } else if ([title isEqualToString:@"LAT"]) {
            columnView.label.text = sunMoonComps.latString;
        } else if ([title isEqualToString:@"LON"]) {
            columnView.label.text = sunMoonComps.lonString;
        } else if ([title isEqualToString:@"FL"]) {
            columnView.label.text = sunMoonComps.FLString;
        } else {
            columnView.label.text = [sunMoonComps valueForKey:title];
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
    
    if (self.planArray.count == 0) {
        return;
    }
    
    SaveDataPackage *dataPackage = [SaveDataPackage presentData];
    
    SunMoon *sunMoonObj = [[SunMoon alloc] initWithCourseArray:dataPackage.courseArray];
    NSArray<SunMoonPointComponents *> *sunMoonArray = [sunMoonObj makeSunMoonPlanArrayWithTakeOffDate:_takeoffDate];
    
    
    self.planArray = [NSMutableArray arrayWithArray:sunMoonArray];
    [self.planTableView reloadData];
    [self setTakeoffTimeBtnTitle];
    
    //月齢計算
    double moonPhase = [SunMoon moonPhaseWithDate:_takeoffDate];
    
    self.moonPhaseLabel.text = [NSString stringWithFormat:@"Moon Phase at T/O : %.1fday(s)", moonPhase];
    
    //synchronize
    [SaveDataPackage savePresentDataWithSunMoonPlanArray:sunMoonArray];
    [SaveDataPackage savePresentDataWithSunMoonTakeoffDate:[TakeoffTimeData dataOfdate:_takeoffDate]];
    [SaveDataPackage savePresentDataWithMoonPhase:moonPhase];
    
    
}

-(IBAction)takeoffTimeBackForward:(UIBarButtonItem *)sender {
    
    if (self.planArray.count == 0) {
        return;
    }
    
    NSTimeInterval timeInterval = 60.0;
    
    if (sender.tag == 1) {
        timeInterval = timeInterval * -1.0;
    }
    
    _takeoffDate =  [NSDate dateWithTimeInterval:timeInterval sinceDate:_takeoffDate];
    
    [self sunMoonPlanTakeoffTimeChange];
}

-(void)setTakeoffTimeBtnTitle {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger flags;
    NSDateComponents *comps;
    
    flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute;
    
    if (!_takeoffDate) {
        _takeoffDate = [NSDate date];
    }

    
    comps = [calendar components:flags fromDate:_takeoffDate];
    
    [_takeoffTimeBtn setTitle:[NSString stringWithFormat:@"T/O : %04d/%02d/%02d %02d%02dZ",
                                   (int)comps.year,
                                   (int)comps.month,
                                   (int)comps.day,
                                   (int)comps.hour,
                                   (int)comps.minute]];

    
    
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
