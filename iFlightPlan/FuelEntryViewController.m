//
//  FuelEntryViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/13.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "FuelEntryViewController.h"

@interface FuelEntryViewController ()

@end

@implementation FuelEntryViewController
{
    bool pushedPoint;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _returnString = [NSMutableString new];
    pushedPoint = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pushDigit:(UIButton *)sender {
    
    NSString *pushedDigit;
    if (sender.tag == 10) {
        pushedDigit = @"0";
    } else {
        pushedDigit = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    }
    
    NSInteger letters = _returnString.length;
    
    if (letters == 0) {
        
        _BSButton.enabled = true;
        _doneButton.enabled = true;
        
    } else if ([[_returnString substringFromIndex:letters - 1] isEqualToString:@"."]) {
        for (int i = 1; i <= 10; i++) {
            ((UIButton *)[self.view viewWithTag:i]).enabled = false;
        }
        
    } else if (letters == 2) {
        
        if (![[_returnString substringToIndex:1] isEqualToString:@"0"] &&
            ![[_returnString substringToIndex:1] isEqualToString:@"1"] &&
            ![[_returnString substringToIndex:1] isEqualToString:@"2"]) {
            
            [_returnString appendString:@"."];
            
            for (int i = 1; i <= 10; i++) {
                ((UIButton *)[self.view viewWithTag:i]).enabled = false;
            }
            _pointButton.enabled = false;
        }
    } else if (letters == 3) {

        [_returnString appendString:@"."];
        
        for (int i = 1; i <= 10; i++) {
            ((UIButton *)[self.view viewWithTag:i]).enabled = false;
        }
        _pointButton.enabled = false;
    }
    
    [_returnString appendString:pushedDigit];
    [self makeDigitDisplay];
    
    
}

-(IBAction)pushBS:(id)sender {
    
    NSInteger letters = _returnString.length;
    
    if ([[_returnString substringFromIndex:letters - 1] isEqualToString:@"."]) {
        pushedPoint = false;
        _pointButton.enabled = true;
    }

    if ([[_returnString substringWithRange:NSMakeRange(letters - 2, 1)] isEqualToString:@"."]) {
        if (pushedPoint == false) {
            [_returnString deleteCharactersInRange:NSMakeRange(letters - 1, 1)];
            letters--;
            _pointButton.enabled = true;
        }
        
        for (int i = 1; i <= 10; i++) {

            ((UIButton *)[self.view viewWithTag:i]).enabled = true;

        }
        
    }
    
    
    [_returnString deleteCharactersInRange:NSMakeRange(letters - 1 , 1)];
    [self makeDigitDisplay];
    
    if (_returnString.length == 0) {
        
        _BSButton.enabled = false;
        _doneButton.enabled = false;
    }
    
    
}

-(IBAction)pushPoint:(id)sender {
    
    [_returnString appendString:@"."];
    [self makeDigitDisplay];
    
    pushedPoint = true;
    _pointButton.enabled = false;
    _BSButton.enabled = true;
    _doneButton.enabled = true;
    
}

-(IBAction)pushCancel:(UIBarButtonItem *)sender{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
    
}

-(IBAction)pushDone:(UIBarButtonItem *)sender {
    
    if (_returnString.length != 0) {
        
        NSMutableArray *stringArray = (NSMutableArray *)[_returnString componentsSeparatedByString:@"."];
        
        NSString *blw0Str;
        if (stringArray.count == 1 || [stringArray[1] isEqualToString:@""]) {
            blw0Str = @"0";
        } else {
            blw0Str = stringArray[1];
        }
        
        NSMutableString *over0Str = [NSMutableString stringWithString:stringArray[0]];
        
        while (over0Str.length < 3) {
            [over0Str insertString:@"0" atIndex:0];
        }
        
        _returnString = [NSMutableString stringWithFormat:@"%@.%@",over0Str,blw0Str];

    }
    
    [self makeDigitDisplay];
    
    [self.delegate fuelEntryViewController:self
                 willDismissWithFuelString:[_returnString copy]
                               columnTitle:_columnTitle
                                 rowNumber:_rowNo];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    
}

-(void)makeDigitDisplay {
    
    if (_returnString.length == 0) {
        for (int i = 0; i <= 4; i++) {
            ((UILabel *)[self.view viewWithTag:100 + i]).text = @"";
        }
        return;
    }
    
    NSArray *digitArray = [_returnString componentsSeparatedByString:@"."];
    
    if (digitArray.count == 2) {
        ((UILabel *)[self.view viewWithTag:100]).text = @"●";
        ((UILabel *)[self.view viewWithTag:104]).text = (NSString *)digitArray[1];
    } else {
        ((UILabel *)[self.view viewWithTag:100]).text = @"";
        ((UILabel *)[self.view viewWithTag:104]).text = @"";
    }
    
    
    NSInteger length = ((NSString *)digitArray[0]).length;
    
    for (int i = 1; i <= 3; i++) {
        if (i + length - 4 < 0) {
            ((UILabel *)[self.view viewWithTag:100 + i]).text = @"";
        } else {
            ((UILabel *)[self.view viewWithTag:100 + i]).text =
            [((NSString *)digitArray[0]) substringWithRange:NSMakeRange(i + length - 4, 1)];
        }
    }
    
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
