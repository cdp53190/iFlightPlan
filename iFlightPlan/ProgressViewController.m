//
//  ProgressViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/10/17.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "ProgressViewController.h"

@interface ProgressViewController ()

@end

@implementation ProgressViewController
{
    NSInteger lastATOidx;
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(planReload) name:@"planReload" object:nil];
    
    
    self.headerHeightConstraint.constant = 50;
    
    //ヘッダ描画
    [self makeHeaderView];
    
    [self planReload];
    
}*/

-(void)planReload{
    
    SaveDataPackage *dataPackage = [SaveDataPackage presentData];
    
    self.navigationItem.title = dataPackage.otherData.flightNumber;
    
    self.planArray = [NSMutableArray arrayWithArray:dataPackage.planArray];
    
    lastATOidx = -1;
    [self.planArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NAVLOGLegComponents * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj.ATO isEqualToString:@""]) {
            lastATOidx = idx;
            *stop = YES;
        }
    }];
    
    [self.planTableView reloadData];
    
    
    
    if(self.planArray.count != 0) {
        [self.planTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    
    
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
    
    NSString *title = @"";
    NAVLOGLegComponents *legComps = (NAVLOGLegComponents *)self.planArray[indexPath.row];
    
    
    for (NSDictionary *dic in self.columnListArray) {
        
        title = dic[@"title"];
        
        DoubleLinePlanColumnView *columnView = [cell.contentView viewWithTag:numberOfColumn];
        
        if([title isEqualToString:@"W/T"]) {
            columnView.upperLabel.text = legComps.Ewindtemp;;
            columnView.lowerLabel.text = legComps.Awindtemp;
            
        } else if ([title isEqualToString:@"W/T+-"]) {
            if ([legComps.AFL isEqualToString:@""]) {
                columnView.upperLabel.text = @"";
                columnView.lowerLabel.text = @"";
            } else {
                double course = legComps.TC.doubleValue;
                
                double planWindDirection = [legComps.Ewindtemp substringToIndex:3].doubleValue;
                double planWindVelocity = [legComps.Ewindtemp substringWithRange:NSMakeRange(4, 3)].doubleValue;
                double planHeadWind = planWindVelocity * cos((planWindDirection - course) / 180 * M_PI);
                
                double actWindDirection = [legComps.Awindtemp substringToIndex:3].doubleValue;
                double actWindVelocity = [legComps.Awindtemp substringWithRange:NSMakeRange(4, 3)].doubleValue;
                double actHeadWind = actWindVelocity * cos((actWindDirection - course) / 180 * M_PI);

                NSString *sign;
                if (planHeadWind > actHeadWind) {
                    sign = @"M";
                } else if (planHeadWind < actHeadWind) {
                    sign = @"P";
                } else {
                    sign = @" ";
                }
                columnView.upperLabel.text = [NSString stringWithFormat:@"%@%02d", sign, (int)fabs(planHeadWind - actHeadWind)];
                
                double planTemp;
                if ([[legComps.Ewindtemp substringWithRange:NSMakeRange(8, 1)] isEqualToString:@"M"]) {
                    planTemp = - [legComps.Ewindtemp substringFromIndex:9].doubleValue;
                } else if ([[legComps.Ewindtemp substringWithRange:NSMakeRange(8, 1)] isEqualToString:@"P"]) {
                    planTemp = [legComps.Ewindtemp substringFromIndex:9].doubleValue;
                } else {
                    planTemp = 0.0;
                }
                
                double actTemp;
                if ([[legComps.Ewindtemp substringWithRange:NSMakeRange(8, 1)] isEqualToString:@"M"]) {
                    actTemp = - [legComps.Ewindtemp substringFromIndex:9].doubleValue;
                } else if ([[legComps.Ewindtemp substringWithRange:NSMakeRange(8, 1)] isEqualToString:@"P"]) {
                    actTemp = [legComps.Ewindtemp substringFromIndex:9].doubleValue;
                } else {
                    actTemp = 0.0;
                }
                
                if (planTemp > actTemp) {
                    sign = @"-";
                } else if (planTemp < actTemp) {
                    sign = @"+";
                } else {
                    sign = @" ";
                }
                columnView.lowerLabel.text = [NSString stringWithFormat:@"%@%02d", sign, (int)fabs(planTemp - actTemp)];;
            }
            
        } else if ([title isEqualToString:@"FL"]) {
            columnView.upperLabel.text = legComps.PFL;
            columnView.lowerLabel.text = legComps.AFL;
        } else if ([title isEqualToString:@"Z/END"]) {
            
            NSArray *waypointArray = [legComps.waypoint componentsSeparatedByString:@"||"];
            
            if (waypointArray.count == 1) {
                columnView.upperLabel.text = waypointArray[0];
                columnView.lowerLabel.text =@"";
            } else {
                columnView.upperLabel.text =waypointArray[0];
                columnView.lowerLabel.text =waypointArray[1];
            }
            
        } else if([title hasPrefix:@"ETO"]){
            
            if ([title isEqualToString:@"ETO3"]) {
                if (lastATOidx == -1 || lastATOidx >= indexPath.row) {
                    columnView.upperLabel.text = @"";
                    columnView.lowerLabel.text = @"";
                } else {
                    
                    int lastATOCTM = [[self class] convertStringToTime:((NAVLOGLegComponents *)self.planArray[lastATOidx]).CTM];
                    int lastATOtime = [[self class] convertStringToTime:((NAVLOGLegComponents *)self.planArray[lastATOidx]).ATO];
                    int legCTM = [[self class] convertStringToTime:legComps.CTM];
                    
                    int legETOtime = lastATOtime + legCTM - lastATOCTM;
                    
                    while (legETOtime >= 1440) {
                        legETOtime -= 1440;
                    }
                    
                    NSString *legETOString = [[self class] convertTimeToString:legETOtime];
                    columnView.upperLabel.text = [legETOString substringToIndex:2];
                    columnView.lowerLabel.text = [legETOString substringFromIndex:2];

                }
                
                
            } else {
                
                NSString *time = [legComps valueForKey:title];
                
                if (time.length == 4) {
                    columnView.upperLabel.text = [time substringToIndex:2];
                    columnView.lowerLabel.text = [time substringFromIndex:2];
                } else {
                    columnView.upperLabel.text = @"";
                    columnView.lowerLabel.text = @"";
                }

            }
            
            if (indexPath.row == 0 && [title isEqualToString:@"ETO2"]) {
                columnView.subTitleLabel.text = @"B/O";
                columnView.subTitleLabel.textColor = [UIColor blueColor];
                columnView.subTitleLabel.hidden = FALSE;
            } else {
                columnView.subTitleLabel.text = @"";
            }
            
            columnView.lowerLabel.textAlignment = NSTextAlignmentCenter;

        } else if([title isEqualToString:@"ATO"]){
            NSString *time = legComps.ATO;
            if (time.length == 4) {
                columnView.upperLabel.text = [time substringToIndex:2];
                columnView.lowerLabel.text = [time substringFromIndex:2];
            } else {
                columnView.upperLabel.text = @"";
                columnView.lowerLabel.text = @"";
            }
            
            if (indexPath.row == 0) {
                columnView.subTitleLabel.text = @"T/O";
                columnView.subTitleLabel.textColor = [UIColor blueColor];
                columnView.subTitleLabel.hidden = FALSE;
            } else {
                columnView.subTitleLabel.text = @"";
            }
            
            columnView.lowerLabel.textAlignment = NSTextAlignmentCenter;
            
        } else if([title isEqualToString:@"ATO+-"]){
            NSString *time = legComps.ATO;
            
            if (time.length == 4 && indexPath.row != 0) {
                int ATOtime = [[self class] convertStringToTime:time];
                int ETOtime = [[self class] convertStringToTime:legComps.ETO];
                
                int differ = ATOtime - ETOtime;
                
                if (differ > 100) {
                    differ -= 1440;
                }
                
                if (differ < -100) {
                    differ += 1440;
                }
                
                if (abs(differ) > 100) {

                    columnView.upperLabel.text = @"";
                    columnView.lowerLabel.text = @"XX";

                } else {

                    if (differ < 0) {
                        columnView.upperLabel.text = @"-";
                    } else if (differ > 0) {
                        columnView.upperLabel.text = @"+";
                    } else {
                        columnView.upperLabel.text = @"+-";
                    }
                    
                    columnView.lowerLabel.text = [NSString stringWithFormat:@"%02d", abs(differ)];

                }
                
            } else {
                columnView.upperLabel.text = @"";
                columnView.lowerLabel.text = @"";
            }
            
            columnView.lowerLabel.textAlignment = NSTextAlignmentCenter;
            
        } else if ([title isEqualToString:@"FRMNG"]){
            columnView.upperLabel.text = legComps.Efuel;
            columnView.lowerLabel.text = legComps.Afuel;
            
        } else if ([title isEqualToString:@"FRMNG+-"]){

            columnView.upperLabel.text = @"";
            if ([legComps.Afuel isEqualToString:@""]) {
                columnView.lowerLabel.text = @"";

            } else {
                
                double fuelDiff = legComps.Afuel.doubleValue - legComps.Efuel.doubleValue;
                
                if (fabs(fuelDiff) > 99.9) {
                    columnView.lowerLabel.text = @"XXX.X";
                } else {
                    
                    if (fuelDiff > 0) {
                        columnView.lowerLabel.text = [NSString stringWithFormat:@"+%04.1f", fabs(fuelDiff)];
                    } else if (fuelDiff < 0) {
                        columnView.lowerLabel.text = [NSString stringWithFormat:@"-%04.1f", fabs(fuelDiff)];
                    } else {
                        columnView.lowerLabel.text = @"+-0.0";
                    }

                }

            }
            
        } else if ([title isEqualToString:@"MEMO"]){
            
            if (legComps.memo1) {
                columnView.upperLabel.text = legComps.memo1;
            } else {
                columnView.upperLabel.text = @"";
            }

            if (legComps.memo2) {
                columnView.lowerLabel.text = legComps.memo2;
            } else {
                columnView.lowerLabel.text = @"";
            }
            
        } else {
            columnView.upperLabel.text = [legComps valueForKey:title];
            columnView.lowerLabel.text = @"";
            
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
            [((DoubleLinePlanColumnView *)columnView).lineView setHidden:YES];
        }
        
        NSString *title = dic[@"title"];
        if ([title isEqualToString:@"W/T+-"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"W/T";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @"Prog.";
        } else if ([title isEqualToString:@"ETO"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"ETOfm";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @" T/O";
        } else if ([title isEqualToString:@"ETO3"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"ETOfm";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @" ATO";
        } else if ([title isEqualToString:@"ATO+-"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"TIME";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @"Prog.";
        } else if ([title isEqualToString:@"FRMNG+-"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"FRMNG";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @"Prog.";
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


-(void)timeEntryViewController:(TimeEntryViewController *)timeEntryViewController
     willDismissWithTimeString:(NSString *)timeString
                   columnTitle:(NSString *)columnTitle
                     rowNumber:(NSInteger)rowNo{
    
    [super timeEntryViewController:timeEntryViewController
         willDismissWithTimeString:timeString
                       columnTitle:columnTitle
                         rowNumber:rowNo];
    
    if (lastATOidx <= rowNo) {
        lastATOidx = rowNo;
        [self.planTableView reloadData];
    }
    
    
}

+(int)convertStringToTime:(NSString *)string{
    
    int returnInt = 0;
    
    returnInt += [string substringToIndex:2].intValue * 60;
    returnInt += [string substringFromIndex:2].intValue;
    
    return returnInt;
}

+(NSString *)convertTimeToString:(int)time{
    
    int hour = time / 60;
    int minute = time - (hour * 60);
    
    return [NSString stringWithFormat:@"%02d%02d",hour,minute];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
