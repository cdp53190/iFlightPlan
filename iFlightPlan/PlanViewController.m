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
    _navigationBar.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
    
    //test
    //PDFReader *test = [[PDFReader alloc]init];
    //[test testWithPathString:[[NSBundle mainBundle] pathForResource:@"314662" ofType:@"pdf"]];

    


    
    //ヘッダ描画
    [self makeHeaderView];
    
    if ([_cellIdentifier isEqualToString:@"NAVLOG"]) {
        _headerHeightConstraint.constant = 50;
    } else if ([_cellIdentifier isEqualToString:@"SunMoon"]){
        _headerHeightConstraint.constant = 50;
        
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Set T/O Time"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(setTakeOffTime)
         ];

        _navigationItem.leftBarButtonItem = btn;

        
    }
    
    _navigationItem.title = [[NSUserDefaults standardUserDefaults] objectForKey:@"dataDic"][@"Flight Number"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_cellIdentifier isEqualToString:@"NAVLOG"]) {
        return 50;
    } else if ([_cellIdentifier isEqualToString:@"SunMoon"]) {
        return 25;
    }
    
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
                                       columnListArray:_columnListArray];
    }
    
    int numberOfColumn = 1;
    for (NSDictionary *dic in _columnListArray) {
    
        NSString *title = dic[@"title"];
        
        if ([_cellIdentifier isEqualToString:@"NAVLOG"]) {
            
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
                
                
            } else {
                columnView.upperLabel.text = _planArray[indexPath.row][title];
                columnView.lowerLabel.text = @"";
                
            }

        } else if([_cellIdentifier isEqualToString:@"SunMoon"]) {
            
            SingleLinePlanColumnView *columnView = [cell.contentView viewWithTag:numberOfColumn];
            
            if ([title isEqualToString:@"CTM"]) {
                columnView.label.text = _planArray[indexPath.row][@"CTMString"];
            } else if ([title isEqualToString:@"TIME"]) {
                columnView.label.text = _planArray[indexPath.row][@"TIMEString"];
            } else if ([title isEqualToString:@"LAT"]) {
                columnView.label.text = _planArray[indexPath.row][@"latString"];
            } else if ([title isEqualToString:@"LON"]) {
                columnView.label.text = _planArray[indexPath.row][@"lonString"];
            } else if ([title isEqualToString:@"FL"]) {
                columnView.label.text = _planArray[indexPath.row][@"FLString"];
            } else {
                columnView.label.text = _planArray[indexPath.row][title];
            }
            
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
        
        if ([_cellIdentifier isEqualToString:@"NAVLOG"]) {
            
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
            
        } else if ([_cellIdentifier isEqualToString:@"SunMoon"]) {
            
            UINib *nib = [UINib nibWithNibName:@"DoubleLinePlanColumnView" bundle:nil];
            columnView = [nib instantiateWithOwner:self options:nil][0];
            
            if (numberOfColumn == _columnListArray.count) {
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

-(void)setTakeOffTime {
    
    if (_planArray == nil) {
        return;
    }

    NSArray *sunMoonArray = [SunMoon makeSunMoonPlanArrayWithTakeOffYear:2016
                                                                   month:4
                                                                     day:5
                                                                    hour:10
                                                                  minute:15];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:sunMoonArray forKey:@"sunMoonPlanArray"];
    [ud synchronize];
    
    _planArray = [sunMoonArray mutableCopy];
    
    
    [_planTableView reloadData];
    
}

@end
