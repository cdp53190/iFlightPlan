//
//  PreFlightViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/07/21.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "PreFlightViewController.h"

@interface PreFlightViewController ()

@end

@implementation PreFlightViewController
{
    
    SELCALPlayer *selcalPlayer;
    RouteCopy *routeCopy;
    NSArray *legsArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selcalPlayer = [[SELCALPlayer alloc] init];
    
    routeCopy = [[RouteCopy alloc] init];
    
    legsArray = [routeCopy arrayOfFMCLegs];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(planReload) name:@"planReload" object:nil];

    
}

-(void)planReload{
    
    routeCopy = [[RouteCopy alloc] init];
    legsArray = [routeCopy arrayOfFMCLegs];
    [_legsTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushSELCAL:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"音が鳴ります"
                                                                             message:@"iPadの音量設定に従い音が出ます。よろしいですか？"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {}]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          SaveDataPackage *dataPackage = [SaveDataPackage presentData];
                                                          
                                                          [selcalPlayer playWithSELCALString:dataPackage.otherData.SELCAL];
                                                  
                                                      
                                                      }]];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:^{}];

    
}

- (IBAction)pushRoute:(UIButton *)sender {
    
    NSString *routeString = [routeCopy stringOfJeppsenRoute];
    
    if ([routeString isEqualToString:@""]) {
        return;
    }
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    [pasteboard setValue:routeString forPasteboardType:@"public.text"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Route Copied"
                                                                             message:routeString
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {}]];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:^{}];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return legsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                     reuseIdentifier:@"cell"];
        
    }

    
    cell.textLabel.text = legsArray[indexPath.row][@"route"];
    cell.detailTextLabel.text = legsArray[indexPath.row][@"WPT"];
    
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    return cell;
    
}

-(NSArray *)arrayOfSunRiseSet{
    NSMutableArray *returnArray = [NSMutableArray new];
    
    return [returnArray copy];
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
