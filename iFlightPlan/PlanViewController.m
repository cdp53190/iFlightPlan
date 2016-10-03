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
{
    NSString *cellIdentifier;
    NSMutableArray *widthPercentArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //test
/*    PDFReader *test = [[PDFReader alloc]init];
    [test testWithPathString:[[NSBundle mainBundle] pathForResource:@"292650" ofType:@"pdf"]];*/
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _planArray = [NSMutableArray arrayWithArray:[ud objectForKey:@"planArray"]];

    _columnListArray = @[@{@"title":@"W/T",@"widthPercent":@0.15},
                         @{@"title":@"FL",@"widthPercent":@0.04},
                         @{@"title":@"TC",@"widthPercent":@0.05},
                         @{@"title":@"MC",@"widthPercent":@0.05},
                         @{@"title":@"Z/END",@"widthPercent":@0.10},
                         @{@"title":@"AWYFIR",@"widthPercent":@0.10},
                         @{@"title":@"WPCOORD",@"widthPercent":@0.10},
                         @{@"title":@"DST",@"widthPercent":@0.05},
                         @{@"title":@"ZTM",@"widthPercent":@0.05},
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
    cellIdentifier = @"PlanCell";
    [_planTableView registerClass: [PlanTableViewCell class] forCellReuseIdentifier: cellIdentifier];

    
    //ヘッダ描画

    _headerHeightConstraint.constant = [PlanTableViewCell rowHeight];
    
    widthPercentArray = [NSMutableArray new];
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
    
    [ud setObject:_columnListArray forKey:@"columnListArray"];
    
    [ud setObject:[widthPercentArray copy] forKey:@"widthPercentArray"];
    [ud synchronize];
    
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
    return [_planArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    int numberOfColumn = 1;
    for (NSDictionary *dic in _columnListArray) {
        
        [widthPercentArray addObject:dic[@"widthPercent"]];
    
        NSString *title = dic[@"title"];
        PlanColumnView *columnView = [cell.contentView viewWithTag:numberOfColumn];

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



@end
