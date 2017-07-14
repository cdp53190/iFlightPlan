//
//  ViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/03/23.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "PlanViewController.h"

@interface PlanViewController ()

@end


@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(planReload) name:@"planReload" object:nil];
    
    //ヘッダ描画
    [self makeHeaderView];
    
    _headerHeightConstraint.constant = 50;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];


    [self planReload];
    
}

-(void)planReload {

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    _navigationItem.title = [ud objectForKey:@"dataDic"][@"Flight Number"];

    NSString *planArrayName;
    if ([_cellIdentifier isEqualToString:@"MainNAVLOG"]) {
        planArrayName = @"planArray";
    } else if([_cellIdentifier isEqualToString:@"DivertNAVLOG"]) {
        planArrayName = @"divertPlanArray";
    }
    
    
    _planArray = [NSMutableArray arrayWithArray:[ud objectForKey:planArrayName]];
    
    [_planTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_planArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (!cell) {
        cell = [[PlanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:_cellIdentifier
                                       columnListArray:_columnListArray
                                        viewController:self
                                             rowNumber:indexPath.row];
    } else {
        [(PlanTableViewCell *)cell setRowNumber:(int)indexPath.row];
    }
    
    int numberOfColumn = 1;

    
    for (NSDictionary *dic in _columnListArray) {
    
        NSString *title = dic[@"title"];
        
        
        DoubleLinePlanColumnView *columnView = [cell.contentView viewWithTag:numberOfColumn];
        
        if([title isEqualToString:@"W/T"]) {
            columnView.upperLabel.text =_planArray[indexPath.row][@"Ewindtemp"];
            columnView.lowerLabel.text =_planArray[indexPath.row][@"Awindtemp"];
            
        } else if ([title isEqualToString:@"FL"]) {
            columnView.upperLabel.text =_planArray[indexPath.row][@"PFL"];
            columnView.lowerLabel.text =_planArray[indexPath.row][@"AFL"];
        } else if ([title isEqualToString:@"Z/END"]) {
            
            NSArray *waypointArray = [_planArray[indexPath.row][@"waypoint"] componentsSeparatedByString:@"||"];
            
            if (waypointArray.count == 1) {
                columnView.upperLabel.text = waypointArray[0];
                columnView.lowerLabel.text =@"";
            } else {
                columnView.upperLabel.text =waypointArray[0];
                columnView.lowerLabel.text =waypointArray[1];
            }
            
        } else if ([title isEqualToString:@"WPCOORD"]){
            columnView.upperLabel.text =_planArray[indexPath.row][@"lat"];
            columnView.lowerLabel.text =_planArray[indexPath.row][@"lon"];
        } else if ([title isEqualToString:@"FRMNG"]){
            columnView.upperLabel.text =_planArray[indexPath.row][@"Efuel"];
            columnView.lowerLabel.text =_planArray[indexPath.row][@"Afuel"];
        } else if([title isEqualToString:@"AWYFIR"]){
            columnView.upperLabel.text =_planArray[indexPath.row][@"AWY"];
            columnView.lowerLabel.text =_planArray[indexPath.row][@"FIR"];
            
            
        } else if([title hasPrefix:@"ETO"]){
            NSString *time = _planArray[indexPath.row][title];
            if (time.length == 4) {
                columnView.upperLabel.text = [time substringToIndex:2];
                columnView.lowerLabel.text = [time substringFromIndex:2];
            } else {
                columnView.upperLabel.text = @"";
                columnView.lowerLabel.text = @"";
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
            NSString *time = _planArray[indexPath.row][title];
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
            
        } else {
            columnView.upperLabel.text = _planArray[indexPath.row][title];
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
    for (NSDictionary *dic in _columnListArray) {
        
        UIView *columnView;
        
        UINib *nib = [UINib nibWithNibName:@"DoubleLinePlanColumnView" bundle:nil];
        columnView = [nib instantiateWithOwner:self options:nil][0];
        
        if (numberOfColumn == _columnListArray.count) {
            [((DoubleLinePlanColumnView *)columnView).lineView setHidden:YES];
        }
        
        NSString *title = dic[@"title"];
        
        if ([title isEqualToString:@"AWYFIR"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"AWY";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @"FIR";
        } else if ([title isEqualToString:@"WPCOORD"]) {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = @"WP";
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @"COORD";
        } else {
            ((DoubleLinePlanColumnView *)columnView).upperLabel.text = title;
            ((DoubleLinePlanColumnView *)columnView).lowerLabel.text = @"";
        }
        
        [columnView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        
        
        [columnView setTag:numberOfColumn];
        
        
        [_headerView addSubview:columnView];
        
        NSLayoutConstraint *layoutTop = [NSLayoutConstraint constraintWithItem:columnView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:_headerView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0.0];
        
        NSLayoutConstraint *layoutLeft;
        
        if (numberOfColumn == 1) {
            
            layoutLeft = [NSLayoutConstraint constraintWithItem:columnView
                                                      attribute:NSLayoutAttributeLeft
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:_headerView
                                                      attribute:NSLayoutAttributeLeft
                                                     multiplier:1.0
                                                       constant:0.0];
            
        } else {
            
            layoutLeft = [NSLayoutConstraint constraintWithItem:columnView
                                                      attribute:NSLayoutAttributeLeft
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:[_headerView viewWithTag:numberOfColumn - 1]
                                                      attribute:NSLayoutAttributeRight
                                                     multiplier:1.0
                                                       constant:0.0];
            
        }
        
        NSLayoutConstraint *layoutBottom = [NSLayoutConstraint constraintWithItem:columnView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_headerView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0.0];
        
        NSLayoutConstraint *layoutWidth = [NSLayoutConstraint constraintWithItem:columnView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:_headerView
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:((NSNumber *)dic[@"widthPercent"]).doubleValue
                                                                        constant:0.0];
        
        
        
        NSArray *layoutConstraints = @[layoutTop,
                                       layoutBottom,
                                       layoutLeft,
                                       layoutWidth];
        
        
        [_headerView addConstraints:layoutConstraints];
        
        numberOfColumn++;
        
    }
    
    
    [self drawUnderLine];

    
}

-(void)drawUnderLine {
    
    //下線
    UIView *lineView = [[UIView alloc] init];
    
    lineView.backgroundColor = [UIColor blackColor];
    
    [lineView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_headerView addSubview:lineView];
    
    
    NSLayoutConstraint *layoutLeft = [NSLayoutConstraint constraintWithItem:lineView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_headerView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0
                                                                   constant:0.0];
    
    NSLayoutConstraint *layoutRight = [NSLayoutConstraint constraintWithItem:lineView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_headerView
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0
                                                                    constant:0.0];
    
    NSLayoutConstraint *layoutBottom = [NSLayoutConstraint constraintWithItem:lineView
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:_headerView
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1.0
                                                                     constant:0.0];
    
    NSLayoutConstraint *layoutHeight = [NSLayoutConstraint constraintWithItem:lineView
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0
                                                                     constant:1.0];
    
    NSArray *layoutConstraints = @[layoutLeft,
                                   layoutRight,
                                   layoutBottom,
                                   layoutHeight];
    
    
    
    [_headerView addConstraints:layoutConstraints];

    
}

-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    
    return UIBarPositionTopAttached;
    
}


-(void)touchedDoubleLinePlanColumnView:(DoubleLinePlanColumnView *)doubleLineColumnView
                           columnTitle:(NSString *)columnTitle
                             rowNumber:(NSInteger)rowNumber{
    
    if ([columnTitle isEqualToString:@"ETO"]) {
        return;
    }
    
    if ([columnTitle isEqualToString:@"ETO2"]||[columnTitle isEqualToString:@"ATO"]) {
        TimeEntryViewController *timeEntryViewController = [[TimeEntryViewController alloc] init];
        timeEntryViewController.delegate = self;
        
        timeEntryViewController.placeHolderString = _planArray[rowNumber][@"ETO"];
        
        timeEntryViewController.modalPresentationStyle = UIModalPresentationPopover;
        timeEntryViewController.preferredContentSize = CGSizeMake(262.0, 441.0);
        
        UIPopoverPresentationController *presentationController = timeEntryViewController.popoverPresentationController;
        presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
        presentationController.sourceView = doubleLineColumnView;
        presentationController.sourceRect = doubleLineColumnView.bounds;
        
        timeEntryViewController.columnTitle = columnTitle;
        timeEntryViewController.rowNo = rowNumber;
        
        
        
        [self presentViewController:timeEntryViewController animated:YES completion:NULL];

    }
    
    if ([columnTitle isEqualToString:@"FRMNG"]) {
        
        FuelEntryViewController *fuelEntryViewController = [[FuelEntryViewController alloc] init];
        fuelEntryViewController.delegate = self;
        
        fuelEntryViewController.modalPresentationStyle = UIModalPresentationPopover;
        fuelEntryViewController.preferredContentSize = CGSizeMake(262.0, 441.0);
        
        UIPopoverPresentationController *presentationController = fuelEntryViewController.popoverPresentationController;
        presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
        presentationController.sourceView = doubleLineColumnView;
        presentationController.sourceRect = doubleLineColumnView.bounds;
        
        fuelEntryViewController.columnTitle = columnTitle;
        fuelEntryViewController.rowNo = rowNumber;
        
        
        
        [self presentViewController:fuelEntryViewController animated:YES completion:NULL];

    }

    
    
}

-(void)timeEntryViewController:(TimeEntryViewController *)timeEntryViewController
     willDismissWithTimeString:(NSString *)timeString
                   columnTitle:(NSString *)columnTitle
                     rowNumber:(NSInteger)rowNo{

    NSString *planArrayName;
    if ([_cellIdentifier isEqualToString:@"MainNAVLOG"]) {
        planArrayName = @"planArray";
    } else if([_cellIdentifier isEqualToString:@"DivertNAVLOG"]) {
        planArrayName = @"divertPlanArray";
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:[ud objectForKey:planArrayName]];
    

    if ([columnTitle isEqualToString:@"ATO"] && rowNo == 0){
        newArray = [self makeNewPlanWithATO:timeString planArray:newArray];
    } else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:newArray[rowNo]];
        dic[columnTitle] = timeString;
        newArray[rowNo] = dic;
    }
    
    
    [ud setObject:[newArray copy] forKey:planArrayName];
    [ud synchronize];

    _planArray = [newArray copy];
    [_planTableView reloadData];
    
}

-(void)fuelEntryViewController:(FuelEntryViewController *)fuelEntryViewController
     willDismissWithFuelString:(NSString *)fuelString
                   columnTitle:(NSString *)columnTitle
                     rowNumber:(NSInteger)rowNo {
    
    NSString *planArrayName;
    if ([_cellIdentifier isEqualToString:@"MainNAVLOG"]) {
        planArrayName = @"planArray";
    } else if([_cellIdentifier isEqualToString:@"DivertNAVLOG"]) {
        planArrayName = @"divertPlanArray";
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:[ud objectForKey:planArrayName]];
    
    

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:newArray[rowNo]];
    dic[@"Afuel"] = fuelString;
    newArray[rowNo] = dic;
    
    [ud setObject:[newArray copy] forKey:planArrayName];
    [ud synchronize];
    
    _planArray = [newArray copy];
    [_planTableView reloadData];
    
}

-(NSMutableArray *)makeNewPlanWithATO:(NSString *)timeString planArray:(NSMutableArray *)planArray{
    
    NSMutableArray *returnArray = [NSMutableArray arrayWithArray:planArray];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:returnArray[0]];
    dic[@"ATO"] = timeString;
    returnArray[0] = dic;
    
    int time;
    
    if ([timeString isEqualToString:@""]) {
        time = -1;
    } else {
        time = [PlanViewController convertStringToTime:timeString];
    }
    
    for (int i = 1; i < returnArray.count; i++) {
        if (time != -1) {
            time += [PlanViewController convertStringToTime:[NSString stringWithFormat:@"0%@",planArray[i][@"ZTM"]]];
        }
        
        while (time >= 1440) {//60*24
            time -= 1440;
        }
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:returnArray[i]];
        if (time == -1) {
            dic[@"ETO"] = @"";
        } else {
            dic[@"ETO"] = [PlanViewController convertTimeToString:time];
        }
        returnArray[i] = dic;

    }
    
    
    return returnArray;
    
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






@end
