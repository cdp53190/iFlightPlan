//
//  ViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/03/23.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSString *cellIdentifier;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _planArray = [NSMutableArray arrayWithArray:@[@{@"Ewindtemp":@"",
                                                    @"Awindtemp":@"",
                                                    @"PFL":@"",
                                                    @"AFL":@"",
                                                    @"TC":@"000",
                                                    @"MC":@"000",
                                                    @"waypoint":@"RJBB",
                                                    @"AWY":@"TOMOH1",
                                                    @"FIR":@"",
                                                    @"lat":@"N34261",
                                                    @"lon":@"E135140",
                                                    @"DST":@"000",
                                                    @"ZTM":@"007",
                                                    @"ETO":@"",
                                                    @"ATO":@"",
                                                    @"CTM":@"0000",
                                                    @"Efuel":@"117.5",
                                                    @"Afuel":@""},
                                                  @{@"Ewindtemp":@"174/007 P22",
                                                    @"Awindtemp":@"",
                                                    @"PFL":@"CL",
                                                    @"AFL":@"",
                                                    @"TC":@"076",
                                                    @"MC":@"083",
                                                    @"waypoint":@"EEP",
                                                    @"AWY":@"TOMOH1",
                                                    @"FIR":@"",
                                                    @"lat":@"N34262",
                                                    @"lon":@"E135146",
                                                    @"DST":@"002",
                                                    @"ZTM":@"001",
                                                    @"ETO":@"",
                                                    @"ATO":@"",
                                                    @"CTM":@"0001",
                                                    @"Efuel":@"117.0",
                                                    @"Afuel":@""},
                                                  @{@"Ewindtemp":@"174/007 P22",
                                                    @"Awindtemp":@"",
                                                    @"PFL":@"CL",
                                                    @"AFL":@"",
                                                    @"TC":@"074",
                                                    @"MC":@"082",
                                                    @"waypoint":@"N34265||E135159",
                                                    @"AWY":@"TOMOH1",
                                                    @"FIR":@"",
                                                    @"lat":@"N34265",
                                                    @"lon":@"E135159",
                                                    @"DST":@"001",
                                                    @"ZTM":@"000",
                                                    @"ETO":@"",
                                                    @"ATO":@"",
                                                    @"CTM":@"0001",
                                                    @"Efuel":@"116.8",
                                                    @"Afuel":@""},]];
    
    _columnListArray = @[@{@"title":@"W/T",@"widthPercent":@0.17},
                         @{@"title":@"FL",@"widthPercent":@0.04},
                         @{@"title":@"TC",@"widthPercent":@0.05},
                         @{@"title":@"MC",@"widthPercent":@0.05},
                         @{@"title":@"Z/END",@"widthPercent":@0.10},
                         @{@"title":@"AWYFIR",@"widthPercent":@0.10},
                         @{@"title":@"WPCOORD",@"widthPercent":@0.10},
                         @{@"title":@"DST",@"widthPercent":@0.04},
                         @{@"title":@"ZTM",@"widthPercent":@0.04},
                         @{@"title":@"ETO",@"widthPercent":@0.10},
                         @{@"title":@"ATO",@"widthPercent":@0.10},
                         @{@"title":@"CTM",@"widthPercent":@0.05},
                         @{@"title":@"FRMNG",@"widthPercent":@0.06}];
    
    int year = 2016;
    int month = 4;
    int day = 5;
    int hour = 0;
    int minute = 7;
    double latitude = -20;
    double longitude = -150;
    int altitude = 0;
    
    
    Class classname;
    id obj;
    
    if ([SunMoonCalc2Data existDataOfYear:year]) {
        classname = NSClassFromString(@"SunMoonCalc2");
    } else {
        classname = NSClassFromString(@"SunMoonCalc");
    }

    obj = [[classname alloc]initWithYear:year
                                   month:month
                                     day:day
                                    hour:hour
                                  minute:minute
                                latitude:latitude
                               longitude:longitude
                                altitude:altitude];
    
    while (latitude < 80) {
    
        [obj setLat:latitude];
        
    [obj calcSun];
    NSLog(@"Sun  Status:%@ Direction:%f Height:%f",[obj status],[obj directionDeg],[obj heightDeg]);

    [obj calcMoon];
    NSLog(@"Moon Status:%@ Direction:%f Height:%f",[obj status],[obj directionDeg],[obj heightDeg]);
    
        latitude +=99.9;
        
    }

    // カスタムセルをテーブルビューにセット
    UINib *nib = [UINib nibWithNibName:@"PlanTableViewCell" bundle:nil];
    cellIdentifier = @"customCell";
    [_planTableView registerNib:nib forCellReuseIdentifier:cellIdentifier];

    _planTableView.tableFooterView = [[UIView alloc] init];
    
    //ヘッダ描画

    
    
    _headerHeightConstraint.constant = [PlanTableViewCell rowHeight];
    
    NSMutableArray *widthPercentArray = [NSMutableArray new];
    NSMutableArray *upperLabelTitleArray = [NSMutableArray new];
    NSMutableArray *lowerLabelTitleArray = [NSMutableArray new];
    
    for (NSDictionary *dic in _columnListArray) {

        [widthPercentArray addObject:dic[@"widthPercent"]];
        
        NSString *title = dic[@"title"];
        
        if ([title isEqualToString:@"AWYFIR"]) {
            [upperLabelTitleArray addObject:@"AWY"];
            [lowerLabelTitleArray addObject:@"FIR"];
        } else if ([title isEqualToString:@"WPCOORD"]) {
            [upperLabelTitleArray addObject:@"WP"];
            [lowerLabelTitleArray addObject:@"COORD"];
        } else {
            [upperLabelTitleArray addObject:title];
            [lowerLabelTitleArray addObject:@""];
        }

    }
    
    _headerView.widthPercentArray = [widthPercentArray copy];
    _headerView.upperLabelTitleArray = [upperLabelTitleArray copy];
    _headerView.lowerLabelTitleArray = [lowerLabelTitleArray copy];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PlanTableViewCell rowHeight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_planArray count] + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

 
    if(indexPath.row == 0) {
        return cell;
    }
    
    NSMutableArray *widthPercentArray = [NSMutableArray new];
    NSMutableArray *upperLabelTitleArray = [NSMutableArray new];
    NSMutableArray *lowerLabelTitleArray = [NSMutableArray new];
    
    
    for (NSDictionary *dic in _columnListArray) {
        
        [widthPercentArray addObject:dic[@"widthPercent"]];
    
        NSString *title = dic[@"title"];
        
        if([title isEqualToString:@"W/T"]) {
            [upperLabelTitleArray addObject:_planArray[indexPath.row - 1][@"Ewindtemp"]];
            [lowerLabelTitleArray addObject:_planArray[indexPath.row - 1][@"Awindtemp"]];
        } else if ([title isEqualToString:@"FL"]) {
            [upperLabelTitleArray addObject:_planArray[indexPath.row - 1][@"PFL"]];
            [lowerLabelTitleArray addObject:_planArray[indexPath.row - 1][@"AFL"]];
        } else if ([title isEqualToString:@"Z/END"]) {
            
            NSArray *waypointArray = [_planArray[indexPath.row - 1][@"waypoint"] componentsSeparatedByString:@"||"];
            
            if (waypointArray.count == 1) {
                [upperLabelTitleArray addObject:waypointArray[0]];
                [lowerLabelTitleArray addObject:@""];
            } else {
                [upperLabelTitleArray addObject:waypointArray[0]];
                [lowerLabelTitleArray addObject:waypointArray[1]];
            }
            
        } else if ([title isEqualToString:@"WPCOORD"]){
            [upperLabelTitleArray addObject:_planArray[indexPath.row - 1][@"lat"]];
            [lowerLabelTitleArray addObject:_planArray[indexPath.row - 1][@"lon"]];
            
        } else if ([title isEqualToString:@"FRMNG"]){
            [upperLabelTitleArray addObject:_planArray[indexPath.row - 1][@"Efuel"]];
            [lowerLabelTitleArray addObject:_planArray[indexPath.row - 1][@"Afuel"]];
            
        } else if([title isEqualToString:@"AWYFIR"]){
            
            [upperLabelTitleArray addObject:_planArray[indexPath.row - 1][@"AWY"]];
            [lowerLabelTitleArray addObject:_planArray[indexPath.row - 1][@"FIR"]];
            
            
            
        } else {
            [upperLabelTitleArray addObject:_planArray[indexPath.row - 1][title]];
            [lowerLabelTitleArray addObject:@""];
            
        }
    
    }
    
    cell.widthPercentArray = [widthPercentArray copy];
    cell.upperLabelTitleArray = [upperLabelTitleArray copy];
    cell.lowerLabelTitleArray = [lowerLabelTitleArray copy];
    
/*    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }*/
    
/*    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }*/
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    

    
    return cell;
}

@end
