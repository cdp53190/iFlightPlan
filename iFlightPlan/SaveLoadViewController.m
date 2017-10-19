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
    NSMutableArray<SaveLoadViewData *> *SLViewDataArray;
    NSMutableArray<NSString *> *fileNameArray;
    NSInteger planNumber;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _navigationItem.rightBarButtonItem = [self editButtonItem];
    _navigationItem.title = @"Save & Load";
    
    ud = [NSUserDefaults standardUserDefaults];

    
    UINib *nib = [UINib nibWithNibName:@"SaveLoadTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    [self planReload];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self planReload];
}

-(void)planReload{
    
    SLViewDataArray = [NSMutableArray arrayWithArray:[SaveDataPackage SLViewDataArray]];
    fileNameArray = [NSMutableArray arrayWithArray:[SaveDataPackage savedFileNameArray]];
    
    planNumber = [[ud objectForKey:@"planNumber"] integerValue];
    
    [_tableView reloadData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    return SLViewDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SaveLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    SaveLoadViewData *data = SLViewDataArray[indexPath.row];
    
    cell.dateLabel.text = [NSString stringWithFormat:@"STD:%@",data.depTime];
    cell.flightLabel.text = data.flightNumber;
    cell.depLabel.text = data.depAPO3;
    cell.arrLabel.text = data.arrAPO3;
    
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


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    if (sourceIndexPath.row == destinationIndexPath.row) {
        return;
    }
    
    if (sourceIndexPath.row > destinationIndexPath.row) {
        [fileNameArray insertObject:fileNameArray[sourceIndexPath.row] atIndex:destinationIndexPath.row];
        [fileNameArray removeObjectAtIndex:sourceIndexPath.row + 1];
        
        [SLViewDataArray insertObject:SLViewDataArray[sourceIndexPath.row] atIndex:destinationIndexPath.row];
        [SLViewDataArray removeObjectAtIndex:sourceIndexPath.row + 1];
        
        if (sourceIndexPath.row > planNumber && destinationIndexPath.row <= planNumber) {
            planNumber++;
        } else if (sourceIndexPath.row == planNumber) {
            planNumber = destinationIndexPath.row;
        }
        
    } else if (sourceIndexPath.row < destinationIndexPath.row){
        
        [fileNameArray insertObject:fileNameArray[sourceIndexPath.row] atIndex:destinationIndexPath.row + 1];
        [fileNameArray removeObjectAtIndex:sourceIndexPath.row];
        
        [SLViewDataArray insertObject:SLViewDataArray[sourceIndexPath.row] atIndex:destinationIndexPath.row + 1];
        [SLViewDataArray removeObjectAtIndex:sourceIndexPath.row];

        if (sourceIndexPath.row < planNumber && destinationIndexPath.row >= planNumber) {
            planNumber--;
        } else if (sourceIndexPath.row == planNumber) {
            planNumber = destinationIndexPath.row;
        }
        
    }
    
    [ud setObject:fileNameArray.copy forKey:@"savedFileNameArray"];
    [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:SLViewDataArray.copy] forKey:@"SLViewDataArray"];
    [ud setObject:[NSNumber numberWithInteger:planNumber] forKey:@"planNumber"];
    [ud synchronize];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row == planNumber) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"削除エラー"
                                                                                     message:@"現在利用中のプランは削除できません"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  
                                                              }]];
            
            [self presentViewController:alertController
                               animated:YES
                             completion:^{}];

        } else {
            
            NSString *fileName = [NSString stringWithFormat:@"%@.data", fileNameArray[indexPath.row]];
            NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
            NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];

            NSFileManager *fm = [NSFileManager defaultManager];
            if (![fm fileExistsAtPath:filePath]) {
                NSLog(@"no file");
                return;//エラー処理未実装
            }
            
            NSError *error=nil;
            [fm removeItemAtPath:filePath error:&error];
            if (error!=nil) {//failed
                NSLog(@"failed to remove %@",[error localizedDescription]);//エラー処理未実装
            }else{
                NSLog(@"Successfully removed:%@",filePath);
            }
            
            [fileNameArray removeObjectAtIndex:indexPath.row];
            [SLViewDataArray removeObjectAtIndex:indexPath.row];
            
            [ud setObject:fileNameArray.copy forKey:@"savedFileNameArray"];
            [ud setObject:[NSKeyedArchiver archivedDataWithRootObject:SLViewDataArray.copy] forKey:@"SLViewDataArray"];

            if (indexPath.row < planNumber) {
                planNumber--;
                [ud setObject:[NSNumber numberWithInteger:planNumber] forKey:@"planNumber"];
            }
            
            [ud synchronize];
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
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

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    [_tableView setEditing:editing animated:animated];
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
