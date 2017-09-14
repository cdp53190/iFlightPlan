//
//  routeCopy.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/10.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "RouteCopy.h"


@implementation RouteCopy
{
    
    NSMutableArray *routeArray;
    
}
-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        routeArray = [NSMutableArray new];
        
        SaveDataPackage *dataPackage = [SaveDataPackage presentData];

        
        NSString *orgString = dataPackage.atcData.speedLevelRoute;
        
        NSArray *tempRouteArray = [orgString componentsSeparatedByString:@" "];
        
        BOOL routeFlag = NO;
        
        NSInteger tempRouteArrayCount = tempRouteArray.count;

        for (int i = 0; i < tempRouteArrayCount; i++) {
            NSString *string = tempRouteArray[i];
            
            if (i == 0) {
                
                [routeArray addObject:@{@"category":@"SpeedAlt",@"value":string}];
                continue;
            }
            
            if (i == 1) {
                if ([RouteCopy isSIDorSTAR:string]) {
                    [routeArray addObject:@{@"category":@"SID",@"value":string}];
                    
                } else if ([string isEqualToString:@"DCT"]){
                    [routeArray addObject:@{@"category":@"route",@"value":@"DCT"}];
                } else {
                    [routeArray addObject:@{@"category":@"route",@"value":@"DCT"}];
                    [routeArray addObject:@{@"category":@"WPT",@"value":string}];
                    routeFlag = YES;
                }

                continue;
            }
            
            if ( i == tempRouteArrayCount) {
                if ([RouteCopy isSIDorSTAR:string]) {
                    [routeArray addObject:@{@"category":@"STAR",@"value":string}];
                } else {
                    [routeArray addObject:@{@"category":@"route",@"value":string}];
                }
                
                continue;
                
            }
            
            if (routeFlag) {
                [routeArray addObject:@{@"category":@"route",@"value":string}];
                routeFlag = NO;
            } else {
                NSArray *array = [string componentsSeparatedByString:@"/"];

                if (array.count == 1) {
                    [routeArray addObject:@{@"category":@"WPT",@"value":string}];
                    
                } else {
                    [routeArray addObject:@{@"category":@"WPT",@"value":array[0]}];
                    [routeArray addObject:@{@"category":@"SpeedAlt",@"value":array[1]}];
                }

                routeFlag = YES;
                
            }
            
        }

        
        
        
        
    }
    
    return self;
    
}

-(NSString *)stringOfJeppsenRoute {
    
    if (routeArray.count == 0) {
        return @"";
    }
    
    NSMutableString *returnString = [NSMutableString new];
    
    NSString *oldRoute, *oldWPT;
    oldRoute = @"";
    oldWPT = @"";
    
    for (int i = 0; i < routeArray.count; i++) {
        NSString *category = routeArray[i][@"category"];
        NSString *value = routeArray[i][@"value"];

        if ([category isEqualToString:@"SpeedAlt"]) continue;
        
        if ([value isEqualToString:@"DCT"] && [category isEqualToString:@"route"]) {
            oldRoute = @"";
            oldWPT = @"";
            continue;
        }

        if ([value isEqualToString:oldRoute] && [category isEqualToString:@"route"]) {
            [returnString deleteCharactersInRange:
             NSMakeRange(returnString.length - oldWPT.length - 1, oldWPT.length + 1)];
            oldWPT = @"";
            continue;
        }
        
        [returnString appendString:value];
        [returnString appendString:@" "];
        
        if ([category isEqualToString:@"route"]) {
            oldRoute = value;
        } else if ([category isEqualToString:@"WPT"]) {
            oldWPT = value;
        }
        
        
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
        
    }
    
    
    return [returnString substringToIndex:returnString.length - 1];
    
}

-(NSArray *)arrayOfATCRoute {
    
    NSMutableArray *returnArray = [NSMutableArray new];
    NSMutableArray *routeNameArray = [NSMutableArray new];
    NSMutableArray *WPTArray = [NSMutableArray new];
    NSString *SPDAlt = @"";
    
    SaveDataPackage *dataPackage = [SaveDataPackage presentData];
    
    NSString *ATCDepAPO4 = dataPackage.atcData.depAPO4;
    NSString *ATCArrAPO4 = dataPackage.atcData.arrAPO4;
    
    if (!ATCDepAPO4) {
        ATCDepAPO4 = @"";
    }
    
    if (!ATCArrAPO4) {
        ATCArrAPO4 = @"";
    }
    
    [routeNameArray addObject:@""];
    [WPTArray addObject:ATCDepAPO4];
    
    for (int i = 0; i < routeArray.count; i++) {
        NSString *category = routeArray[i][@"category"];
        NSString *value = routeArray[i][@"value"];
        
        if ([category isEqualToString:@"SpeedAlt"]) {
            
            if (i != 0) {
                
                [returnArray addObject:@{@"SPDAlt":SPDAlt,
                                         @"routeArray":routeNameArray,
                                         @"WPTArray":WPTArray}];
                
                routeNameArray = [NSMutableArray new];
                
                WPTArray = [NSMutableArray new];

            }
            

            SPDAlt = value;

            continue;
        }
        
        if ([category isEqualToString:@"route"]) {

            [routeNameArray addObject:value];
            continue;
        }
        
        if ([category isEqualToString:@"WPT"]) {
            [WPTArray addObject:value];
            continue;
        }

    }

    if (WPTArray.count == routeNameArray.count){

        
        [routeNameArray addObject:@"DCT"];
        
    }
    
    [WPTArray addObject:ATCArrAPO4];
    
    [returnArray addObject:@{@"SPDAlt":SPDAlt,
                             @"routeArray":routeNameArray,
                             @"WPTArray":WPTArray}];

    
    return returnArray;
}

-(NSArray *)arrayOfFMCLegs {
    
    if (routeArray.count == 0) {
        return @[];
    }
    
    NSMutableArray *returnArray = [NSMutableArray new];
    NSMutableDictionary *routeWPTDic = [NSMutableDictionary new];
    
    for (int i = 0; i < routeArray.count; i++) {
        NSString *category = routeArray[i][@"category"];
        NSString *value = routeArray[i][@"value"];
        
        if ([category isEqualToString:@"SpeedAlt"]) continue;
        
        if (i == 1) {
            routeWPTDic[@"route"] = @"-----";
            continue;
        }
        
        if ([category isEqualToString:@"route"]) {
            
            if (![value isEqualToString:routeWPTDic[@"route"]]) {
                
                [returnArray addObject:[routeWPTDic copy]];
                
                if ([value isEqualToString:@"DCT"]) {
                    routeWPTDic[@"route"] = @"DIRECT";
                } else {
                    routeWPTDic[@"route"] = value;
                }
            }
        } else if ([category isEqualToString:@"WPT"]) {
            NSString *LatLonString = [RouteCopy LEGSLatLonByATCLatLon:value];
            if ([LatLonString isEqualToString:@""]) {
                routeWPTDic[@"WPT"] = value;
            } else {
                routeWPTDic[@"WPT"] = LatLonString;
            }
        }
    }
    
    if (![routeArray[routeArray.count - 1][@"category"] isEqualToString:@"route"]) {
        [returnArray addObject:[routeWPTDic copy]];
    }

    return returnArray;
}


+(BOOL)isSIDorSTAR:(NSString *)text {

    if ([text isEqualToString:@"DCT"]) {
        return NO;
    }
    
    if (text.length == 2) {
        return NO;
    }
    
    if ([RouteCopy isDigit:[text substringWithRange:NSMakeRange(text.length - 1, 1)]]) {
        if ([RouteCopy isCharacter:[text substringWithRange:NSMakeRange(0, text.length - 1)]]) {
            return YES;
        }
    }
    
    if ([RouteCopy isDigit:[text substringWithRange:NSMakeRange(text.length - 1, 1)]]) {
        if ([RouteCopy isCharacter:[text substringWithRange:NSMakeRange(0, text.length - 1)]]) {
            return YES;
        }
    }
    
    return NO;
    
}

+(NSString *)LEGSLatLonByATCLatLon:(NSString *)string {
    
    NSString *searchPattern = @"^([0-9]+)([NS])([0-9]+)([EW])$";
    
    NSError *matchError = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:searchPattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&matchError];
    
    if (matchError != nil){
        
        return @"Regex-Error";
        
    }
    
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    if (matches.count != 1) {
        return @"";
    }
    
    NSString *latDigit = [string substringWithRange:[matches[0] rangeAtIndex:1]];
    NSString *NorS = [string substringWithRange:[matches[0] rangeAtIndex:2]];
    NSString *lonDigit = [string substringWithRange:[matches[0] rangeAtIndex:3]];
    NSString *EorW = [string substringWithRange:[matches[0] rangeAtIndex:4]];
    
    NSMutableString *returnString = [NSMutableString new];
    
    [returnString appendString:NorS];
    
    if (latDigit.length == 2 || latDigit.length == 4) {
        [returnString appendString:latDigit];
    } else {
        return @"latDigit-Error";
    }
    
    [returnString appendString:EorW];
    
    if (lonDigit.length == 3 || lonDigit.length == 5) {
        [returnString appendString:lonDigit];
    } else {
        return @"lonDigit-Error";
    }
    
    return returnString;
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
