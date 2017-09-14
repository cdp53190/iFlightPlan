//
//  SaveLoadViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2017/08/29.
//  Copyright © 2017年 Another Sky. All rights reserved.
//

#import "SaveLoadViewController.h"

@interface SaveLoadViewController ()

@end

@implementation SaveLoadViewController
{
    NSUserDefaults *ud;
    NSMutableArray<SaveDataPackage *> *savedPlanArray;
    NSInteger planNumber;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ud = [NSUserDefaults standardUserDefaults];

    if(![ud objectForKey:@"savedPlanArray"]) {
        [ud setObject:[NSData new] forKey:@"savedPlanArray"];
        [ud synchronize];
    }
    
    UINib *nib = [UINib nibWithNibName:@"SaveLoadTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    [self planReload];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self planReload];
}

-(void)planReload{
    
    savedPlanArray = [NSMutableArray arrayWithArray:[SaveDataPackage savedPlanArray]];
    
    planNumber = [[ud objectForKey:@"planNumber"] integerValue];
    
    [_tableView reloadData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    return savedPlanArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SaveLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    SaveDataPackage *saveDataPkg = savedPlanArray[indexPath.row];
    
    NSMutableString *depTime = [NSMutableString stringWithString:@"STD:"];
    
    NSString *atcDOF = saveDataPkg.atcData.DOF;
    
    NSString *searchPattern = @"^([0-9][0-9])([0-9][0-9])([0-9][0-9])$";
    NSError *matchError = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:searchPattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&matchError];
    
    if (matchError != nil){
        
        [depTime appendString:@"00-00-00 "];
        
    } else {
        
        if (!atcDOF) {
            [depTime appendString:@"00-00-00 "];
        } else {
            
            NSArray *matches = [regex matchesInString:atcDOF options:0 range:NSMakeRange(0, atcDOF.length)];
            
            if (matches.count != 1) {
                [depTime appendString:@"00-00-00 "];
            } else {
                [depTime appendFormat:@"%@-%@-%@ ",
                 [atcDOF substringWithRange:[matches[0] rangeAtIndex:1]],
                 [atcDOF substringWithRange:[matches[0] rangeAtIndex:2]],
                 [atcDOF substringWithRange:[matches[0] rangeAtIndex:3]]];
            }
            
        }
        
    }
    
    [depTime appendString:saveDataPkg.otherData.STD];
    [depTime appendString:@"Z"];
    
    cell.dateLabel.text = (NSString *)depTime;
    cell.flightLabel.text = saveDataPkg.otherData.flightNumber;
    cell.depLabel.text = [saveDataPkg.otherData.FMCCourse substringToIndex:3];
    cell.arrLabel.text = [saveDataPkg.otherData.FMCCourse substringWithRange:NSMakeRange(3, 3)];
    
    if (indexPath.row == planNumber) {
        cell.backgroundColor = [UIColor greenColor];
    } else {
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == planNumber) {
        return NO;
    } else {
        return YES;
    }

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存済みPlanを読み込む"
                                                                             message:@"選択されたPlanを読み込みます。"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                      
                                                          [tableView deselectRowAtIndexPath:indexPath animated:YES];
                                                          
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          
                                                          [SaveDataPackage savePresentPlanWithPlanNumber:planNumber];
                                                          
                                                          [SaveDataPackage loadPlanOfPlanNumber:indexPath.row];

                                                          
                                                      }]];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:^{}];

    
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
