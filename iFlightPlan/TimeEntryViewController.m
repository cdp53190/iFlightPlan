//
//  TimeEntryViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/10.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "TimeEntryViewController.h"

@interface TimeEntryViewController ()
@end

@implementation TimeEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _returnString = [NSMutableString new];
    
    [self makeDigitDisplay];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)pushDigit:(UIButton *)sender {
    
    if (sender.tag == 10) {
        [_returnString appendString:@"0"];
    } else {
        [_returnString appendString:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
    [self makeDigitDisplay];

    NSInteger letters = _returnString.length;

    if (letters == 1) {
        if (sender.tag == 2) {
            for (int i = 1; i <= 10; i++) {
                if (i <= 3 || i == 10) {
                    ((UIButton *)[self.view viewWithTag:i]).enabled = true;
                } else {
                    ((UIButton *)[self.view viewWithTag:i]).enabled = false;
                }
            }
        } else {
            for (int i = 1; i <= 10; i++) {
                ((UIButton *)[self.view viewWithTag:i]).enabled = true;
            }
        }
        
        _BSButton.enabled = true;
        _doneButton.enabled = false;
        
        return;
        
    }

    if (letters == 2) {
        
        for (int i = 1; i <= 10; i++) {
            if (i <= 5 || i == 10) {
                ((UIButton *)[self.view viewWithTag:i]).enabled = true;
            } else {
                ((UIButton *)[self.view viewWithTag:i]).enabled = false;
            }
        }
        
        return;
    }

    if (letters == 3) {
        
        for (int i = 1; i <= 10; i++) {
            ((UIButton *)[self.view viewWithTag:i]).enabled = true;
        }
        
        return;
    }

    if (letters == 4) {
        
        for (int i = 1; i <= 10; i++) {
            ((UIButton *)[self.view viewWithTag:i]).enabled = false;
        }
        
        _doneButton.enabled = true;
        
        return;
    }

}

-(IBAction)pushBS:(id)sender {
    
    [_returnString deleteCharactersInRange:NSMakeRange(_returnString.length - 1 , 1)];
    [self makeDigitDisplay];
    
    NSInteger letters = _returnString.length;
    
    if (letters == 0) {
        for (int i = 1; i <= 10; i++) {
            if (i <= 2 || i == 10) {
                ((UIButton *)[self.view viewWithTag:i]).enabled = true;
            } else {
                ((UIButton *)[self.view viewWithTag:i]).enabled = false;
            }
        }
        
        _BSButton.enabled = false;
        _doneButton.enabled = true;
        
        return;
    }
    
    if (letters == 1) {
        if ([_returnString intValue] == 2) {
            for (int i = 1; i <= 10; i++) {
                if (i <= 3 || i == 10) {
                    ((UIButton *)[self.view viewWithTag:i]).enabled = true;
                } else {
                    ((UIButton *)[self.view viewWithTag:i]).enabled = false;
                }
            }
        } else {
            for (int i = 1; i <= 10; i++) {
                ((UIButton *)[self.view viewWithTag:i]).enabled = true;
            }
        }
        
        return;
        
    }
    
    if (letters == 2) {
        
        for (int i = 1; i <= 10; i++) {
            if (i <= 5 || i == 10) {
                ((UIButton *)[self.view viewWithTag:i]).enabled = true;
            } else {
                ((UIButton *)[self.view viewWithTag:i]).enabled = false;
            }
        }
        
        return;
    }
    
    if (letters == 3) {
        
        for (int i = 1; i <= 10; i++) {
            ((UIButton *)[self.view viewWithTag:i]).enabled = true;
        }

        _doneButton.enabled = false;
        return;
    }
    

}

-(IBAction)pushCancel:(UIBarButtonItem *)sender{
    
    /*
    [self.delegate timeEntryViewController:self
                 willDismissWithTimeString:@""
                               columnTitle:_columnTitle
                                 rowNumber:_rowNo];
    */
    
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
    
}

-(IBAction)pushDone:(UIBarButtonItem *)sender {
    
    [self.delegate timeEntryViewController:self
                 willDismissWithTimeString:[_returnString copy]
                               columnTitle:_columnTitle
                                 rowNumber:_rowNo];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    
}

-(void)makeDigitDisplay {
    
    NSInteger length = _returnString.length;
    
    BOOL placeHolder = false;
    
    if (_placeHolderString.length == 4) {
        placeHolder = true;
    }
    
    for (int i = 1; i <= 4; i++) {
        if (i <= length) {
            ((UILabel *)[self.view viewWithTag:100 + i]).text = [_returnString substringWithRange:NSMakeRange(i - 1, 1)];
            ((UILabel *)[self.view viewWithTag:100 + i]).textColor = [UIColor blackColor];
        } else {
            if (placeHolder) {
                ((UILabel *)[self.view viewWithTag:100 + i]).text = [_placeHolderString substringWithRange:NSMakeRange(i - 1, 1)];
                ((UILabel *)[self.view viewWithTag:100 + i]).textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.1];
            } else {
                ((UILabel *)[self.view viewWithTag:100 + i]).text = @"";
            }
            
            
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
