//
//  routeCopy.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/10.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "RouteCopy.h"

@implementation RouteCopy


-(NSString *)stringOfRoute {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *orgString = [ud objectForKey:@"dataDic"][@"ATC Route"];
    
    NSMutableString *returnString = [NSMutableString new];
    
    NSArray *routeArray = [orgString componentsSeparatedByString:@" "];
    
    NSString *oldOldRoute, *oldRoute;
    oldOldRoute = @"";
    oldRoute = @"";
    
    for (int i = 0; i < routeArray.count; i++) {
        NSString *string = routeArray[i];
        
        if (i == 0) continue;
        if ([string isEqualToString:@"DCT"])continue;

        NSArray *array = [string componentsSeparatedByString:@"/"];
        
        string = array[0];
        
        if ([string isEqualToString:oldOldRoute]) {
            [returnString deleteCharactersInRange:NSMakeRange(returnString.length - oldRoute.length - 1, oldRoute.length + 1)];
            continue;
        }
        
        oldOldRoute = oldRoute;
        oldRoute = string;
        
        /*//RWY入れたいけどつながらないことも多々ありなのでとりあえずSTARの始点までで作成することにする。
         if (i == routeArray.count - 1) {
            
            if (string.length == 1) {
                continue;
            } else if ([RouteCopy isCharacter:[string substringToIndex:string.length - 1]] &&
                        [RouteCopy isDigit:[string substringFromIndex:string.length - 1]]){
                
                
                [returnString deleteCharactersInRange:NSMakeRange(returnString.length - 1, 1)];
                [returnString appendString:@"."];
                [returnString appendString:string];
                [returnString appendString:@"."];
                [returnString appendString:[ud objectForKey:@"dataDic"][@"L/D RWY"]];
                [returnString appendString:@" "];
                continue;
                
            }
        }*/
        
        [returnString appendString:string];
        [returnString appendString:@" "];
        continue;
        
        
    }
    
    
    return [returnString substringToIndex:returnString.length - 1];
    
}

+(BOOL)isDigit:(NSString *)text
{
    NSCharacterSet *digitCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    NSScanner *aScanner = [NSScanner localizedScannerWithString:text];
    [aScanner setCharactersToBeSkipped:nil];
    
    [aScanner scanCharactersFromSet:digitCharSet intoString:NULL];
    return [aScanner isAtEnd];
}

+(BOOL)isCharacter:(NSString *)text
{
    NSCharacterSet *digitCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    
    NSScanner *aScanner = [NSScanner localizedScannerWithString:text];
    [aScanner setCharactersToBeSkipped:nil];
    
    [aScanner scanCharactersFromSet:digitCharSet intoString:NULL];
    return [aScanner isAtEnd];
}


@end
