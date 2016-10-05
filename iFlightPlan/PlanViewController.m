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
    NSMutableArray *widthPercentArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //test
    //PDFReader *test = [[PDFReader alloc]init];
    //[test testWithPathString:[[NSBundle mainBundle] pathForResource:@"314662" ofType:@"pdf"]];

    


    /*
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
        
    }*/

    // カスタムセルをテーブルビューにセット
    [_planTableView registerClass: [PlanTableViewCell class] forCellReuseIdentifier: _cellIdentifier];

    
    //ヘッダ描画&widthPercentArrayセット
    
    _headerHeightConstraint.constant = [PlanTableViewCell rowHeight];
    
    widthPercentArray = [NSMutableArray new];

    
    NSInteger numberOfColumn = 1;    
    for (NSDictionary *dic in _columnListArray) {

        UIView *columnView;
        
        if ([_cellIdentifier isEqualToString:@"NAVLOG"]) {
            
            UINib *nib = [UINib nibWithNibName:@"DoubleLinePlanColumnView" bundle:nil];
            columnView = [nib instantiateWithOwner:self options:nil][0];
            
            if (numberOfColumn == widthPercentArray.count) {
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
        
        [widthPercentArray addObject:dic[@"widthPercent"]];
        
        numberOfColumn++;

    }
    
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

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:widthPercentArray forKey:@"widthPercentArray"];
    
    
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
    
    PlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    cell.widthPercentArray = widthPercentArray;
    
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
