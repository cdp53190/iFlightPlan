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
    NSArray<LandmarkPassData *> *landmarkArray;
    SaveDataPackage *presentData;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selcalPlayer = [[SELCALPlayer alloc] init];
    
    [self planReload];
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            obj.layer.borderColor = [UIColor blackColor].CGColor;
            obj.layer.borderWidth = .5;
        }
    }];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(planReload) name:@"planReload" object:nil];

    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    /*
    [presentData = [SaveDataPackage presentData];
     
     [self setSunRiseSunSet];
     [self setMoonRiseSetPhase];
     [self setWeatherForcast];*/
    
    [self planReload];
    
    
}

-(void)planReload{
    
    presentData = [SaveDataPackage presentData];

    routeCopy = [[RouteCopy alloc] init];
    legsArray = [routeCopy arrayOfFMCLegs];
    landmarkArray = presentData.landmarkPassArray;

    
    
    _navigationItem.title = presentData.otherData.flightNumber;
    
    [_legsTableView reloadData];
    [_landmarkTableView reloadData];
    
    _regNoLabel.text = presentData.otherData.aircraftNumber;
    _blockTimeLabel.text = presentData.otherData.blockTime;
    _flightTimeLabel.text = [NSString stringWithFormat:@"%@+%@(%@)",
                             [presentData.fuelTimeData.dest.time substringToIndex:2],
                             [presentData.fuelTimeData.dest.time substringFromIndex:2],
                             presentData.otherData.timeMargin];
    _depRWYLabel.text = presentData.otherData.takeoffRunway;
    if (presentData.otherData.SID && ![presentData.otherData.SID isEqualToString:@""]) {
        _SIDLabel.text = presentData.otherData.SID;
    } else {
        _SIDLabel.text = @"N/A";
    }
    
    NSString *type = presentData.otherData.aircraftType;
    double reserveFuel = presentData.fuelTimeData.firstAlternate.fuel.doubleValue;
    
    if ([type isEqualToString:@"788"] || [type isEqualToString:@"789"]) {
        reserveFuel += 8.0;
        _STDReserveLabel.text = [NSString stringWithFormat:@"%.01f",reserveFuel];
    } else {
        _STDReserveLabel.text = @"N/A";
    }
    
    _initialAltLabel.text = presentData.otherData.initialFL;
    [self setSunRiseSunSet];
    [self setMoonRiseSetPhase];
    [self setAPOTime];
    [self setFMCCourse];
    [self setWeatherForcast];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushSELCAL:(UIButton *)sender {
    
    [selcalPlayer playMuteSound];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"音が鳴ります"
                                                                             message:@"iPadの音量設定に従い音が出ます。よろしいですか？"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                      
                                                          [selcalPlayer stopSound];
                                                      
                                                      }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          [selcalPlayer stopSound];
                                                          
                                                          [selcalPlayer playWithSELCALString:presentData.otherData.SELCAL];
                                                  
                                                      
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

- (IBAction)pushWeatherForcast:(id)sender {
    
    WeatherForcastData *forcast = presentData.otherData.forcast;
    
    if ([forcast.posteriorWeatherForcastSummery isEqualToString:@""]) {
        WeatherForcast *wf = [[WeatherForcast alloc] init];
        
        wf.delegate = self;
        
        
        [wf weatherForcastRequestWithDataPackage:presentData];

    } else {
        
        [self setWeatherForcast];
        
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _legsTableView) {
        return legsArray.count;
    } else if (tableView == _landmarkTableView) {
        return landmarkArray.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _legsTableView) {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"legsCell"];
        
        
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                         reuseIdentifier:@"legsCell"];
            
        }
        
        
        cell.textLabel.text = legsArray[indexPath.row][@"route"];
        cell.detailTextLabel.text = legsArray[indexPath.row][@"WPT"];
        
        cell.detailTextLabel.textColor = [UIColor blackColor];
        
        return cell;
    } else if (tableView == _landmarkTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"landmarkCell"];

        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                         reuseIdentifier:@"landmarkCell"];
            
        }

        LandmarkPassData *landmarkPassData = landmarkArray[indexPath.row];
        
        NSString *mainText = [NSString stringWithFormat:@"%@(%@)", landmarkPassData.name, [PreFlightViewController convertTimeToString:landmarkPassData.CTM]];
        cell.textLabel.text = mainText.copy;
        
        NSMutableString *detailText = [NSMutableString new];
    
        if (![landmarkPassData.direction isEqualToString:@""]) {
            [detailText appendFormat:@"%@-%dNM", landmarkPassData.direction, (int)landmarkPassData.distance];
        }
                
        cell.detailTextLabel.text = detailText;
        
        cell.detailTextLabel.textColor = [UIColor blackColor];

        return cell;
    }
    
    return nil;
}

-(void)setSunRiseSunSet{
    NSMutableString *returnString = [NSMutableString new];
    
    NSArray<SunMoonPointComponents *> *sunMoonArray = presentData.sunMoonPlanArray;
    
    NSString *lastSunStatus = sunMoonArray[0].SunSTATUS;
    for (SunMoonPointComponents *sunMoonComps in sunMoonArray) {
        
        if (![sunMoonComps.SunSTATUS isEqualToString:lastSunStatus]) {
            if ([sunMoonComps.SunSTATUS isEqualToString:@"Day"]) {
                [returnString appendString:@"SunRise:"];
                [returnString appendFormat:@"%@+%@ ",
                 [sunMoonComps.CTMString substringToIndex:2],
                 [sunMoonComps.CTMString substringFromIndex:2]];
            }
            
            if ([lastSunStatus isEqualToString:@"Day"]) {
                [returnString appendString:@"SunSet:"];
                [returnString appendFormat:@"%@+%@ ",
                 [sunMoonComps.CTMString substringToIndex:2],
                 [sunMoonComps.CTMString substringFromIndex:2]];
                
            }
        }
        
        lastSunStatus = sunMoonComps.SunSTATUS;
        
    }
    
    if (returnString.length == 0) {
        if ([lastSunStatus isEqualToString:@"Day"]) {
            _sunRiseSetLabel.text = @"All Day";
        } else {
            _sunRiseSetLabel.text = @"All Night";
        }
    } else {
        _sunRiseSetLabel.text = [returnString substringToIndex:returnString.length - 1];
    }
    
    
}

-(void)setMoonRiseSetPhase
{
    NSMutableString *returnString = [NSMutableString new];
    
    NSArray<SunMoonPointComponents *> *sunMoonArray = presentData.sunMoonPlanArray;
    
    NSString *lastMoonStatus = sunMoonArray[0].MoonSTATUS;
    
    for (SunMoonPointComponents *sunMoonComps in sunMoonArray) {
        
        if (![sunMoonComps.MoonSTATUS isEqualToString:lastMoonStatus]) {
            if ([sunMoonComps.MoonSTATUS isEqualToString:@"Over"]) {
                [returnString appendString:@"MoonRise:"];
                [returnString appendFormat:@"%@+%@ ",
                 [sunMoonComps.CTMString substringToIndex:2],
                 [sunMoonComps.CTMString substringFromIndex:2]];
            }
            
            if ([lastMoonStatus isEqualToString:@"Over"]) {
                [returnString appendString:@"MoonSet:"];
                [returnString appendFormat:@"%@+%@ ",
                 [sunMoonComps.CTMString substringToIndex:2],
                 [sunMoonComps.CTMString substringFromIndex:2]];
                
            }
        }
        
        lastMoonStatus = sunMoonComps.MoonSTATUS;
        
    }
    
    if (returnString.length == 0) {
        if ([lastMoonStatus isEqualToString:@"Over"]) {
            [returnString appendString:@"Moon above Horizon "];
        } else {
            [returnString appendString:@"No Moon "];
        }
    }
    
    [returnString appendFormat:@"(Moon Phase:%.01fday(s))", presentData.moonPhase];
    
    _moonRiseSetPhaseLabel.text = returnString;
                                                        
  
}


-(void)setWeatherForcast{
    
    if([presentData.otherData.forcast.previousWeatherForcastSummery isEqualToString:@""] ||
       presentData.otherData.forcast.previousWeatherForcastSummery == nil) {
        
        _previousForcastLabel.text = @"NO DATA";
        _posteriorForcastLabel.text = @"NO DATA";
        _getWeatherForcastButton.hidden = false;
        
    } else {

        WeatherForcastData *forcast = presentData.otherData.forcast;
        
        NSMutableString *returnString = [NSMutableString new];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
        NSCalendarUnitHour | NSCalendarUnitMinute;
        NSDateComponents *compsUTCPrevious, *compsLCLPrevious, *compsUTCPosterior, *compsLCLPosterior;
        
        NSTimeZone *tz = [NSTimeZone defaultTimeZone];
        NSTimeZone *localTimezone = [NSTimeZone timeZoneWithName:forcast.timezone];
        
        NSDate *previousUTC = [NSDate dateWithTimeInterval:-tz.secondsFromGMT sinceDate:forcast.previousForcastDate];
        NSDate *previousLCL = [NSDate dateWithTimeInterval:localTimezone.secondsFromGMT sinceDate:previousUTC];
        NSDate *posteriorUTC = [NSDate dateWithTimeInterval:-tz.secondsFromGMT sinceDate:forcast.posteriorForcastDate];
        NSDate *posteriorLCL = [NSDate dateWithTimeInterval:localTimezone.secondsFromGMT sinceDate:posteriorUTC];

        
        compsUTCPrevious = [calendar components:flags fromDate:previousUTC];
        compsLCLPrevious = [calendar components:flags fromDate:previousLCL];
        compsUTCPosterior = [calendar components:flags fromDate:posteriorUTC];
        compsLCLPosterior = [calendar components:flags fromDate:posteriorLCL];
        
        [returnString appendFormat:@"%04d/%02d/%02d-%02d:%02dZ",
         (int)compsUTCPrevious.year,
         (int)compsUTCPrevious.month,
         (int)compsUTCPrevious.day,
         (int)compsUTCPrevious.hour,
         (int)compsUTCPrevious.minute];

        [returnString appendFormat:@"(%02d:%02dL",
         (int)compsLCLPrevious.hour,
         (int)compsLCLPrevious.minute];
        
        NSInteger dayDiffer = compsUTCPrevious.day - compsLCLPrevious.day;
        if ((dayDiffer < 0 && dayDiffer > -27)|| dayDiffer > 27 ) {
            [returnString appendString:@" +1day"];
        } else if (dayDiffer > 0 || dayDiffer < -27) {
            [returnString appendString:@" -1day"];
        }
        
        [returnString appendString:@"):"];
        
        
        [returnString appendFormat:@"%@ %d℃ (Powered by Dark Sky)",
         forcast.previousWeatherForcastSummery,
         (int)round(forcast.previousTempForcast.doubleValue)];
        
        _previousForcastLabel.text = returnString;
        
        returnString = [NSMutableString new];
        
        [returnString appendFormat:@"%04d/%02d/%02d-%02d:%02dZ",
         (int)compsUTCPosterior.year,
         (int)compsUTCPosterior.month,
         (int)compsUTCPosterior.day,
         (int)compsUTCPosterior.hour,
         (int)compsUTCPosterior.minute];
        
        [returnString appendFormat:@"(%02d:%02dL",
         (int)compsLCLPosterior.hour,
         (int)compsLCLPosterior.minute];
        
        dayDiffer = compsUTCPosterior.day - compsLCLPosterior.day;
        if ((dayDiffer < 0 && dayDiffer > -27)|| dayDiffer > 27 ) {
            [returnString appendString:@" +1day"];
        } else if (dayDiffer > 0 || dayDiffer < -27) {
            [returnString appendString:@" -1day"];
        }
        
        [returnString appendString:@"):"];

        [returnString appendFormat:@"%@ %d℃ (Powered by Dark Sky)",
         forcast.posteriorWeatherForcastSummery,
         (int)round(forcast.posteriorTempForcast.doubleValue)];
        
        _posteriorForcastLabel.text = returnString;
        
        _getWeatherForcastButton.hidden = true;
    }
    


}

-(void)setAPOTime {
    
    _depAPOLabel.text = [NSString stringWithFormat:@"%@/%@",
                         presentData.atcData.depAPO4, presentData.otherData.depAPO3];
    _arrAPOLabel.text = [NSString stringWithFormat:@"%@/%@",
                         presentData.atcData.arrAPO4, presentData.otherData.arrAPO3];
    
    _depTimeLabel.text = presentData.otherData.STD;
    _arrTimeLabel.text = presentData.otherData.STA;
    
}

-(void)setFMCCourse {
    
    _FMCCourseLabel.text = presentData.otherData.FMCCourse;
    
}


-(void)receiveForcastWithForcastData:(WeatherForcastData *)forcast {
    
    presentData.otherData.forcast = forcast;
    
    [SaveDataPackage savePresentDataWithOtherData:presentData.otherData];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self setWeatherForcast];
    });



    
}

-(void)receiveWeatherForcastErrorWithData:(NSData *)data error:(WeatherForcastError)error response:(NSURLResponse *)response {
    
    _previousForcastLabel.text = @"NO DATA";
    _posteriorForcastLabel.text = @"NO DATA";
    _getWeatherForcastButton.hidden = false;
    
    NSString *errorMsg = [NSString stringWithFormat:@"データを取得できません。\nエラーコード:%ld",(long)error];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"読み込みエラー"
                                                                             message:errorMsg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                      }]];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:^{}];


}

+(NSString *)convertTimeToString:(int)time{
    
    int hour = time / 60;
    int minute = time - (hour * 60);
    
    return [NSString stringWithFormat:@"%02d+%02d",hour,minute];
    
}

+(int)convertStringToTime:(NSString *)string{
    
    int returnInt = 0;
    
    returnInt += [string substringToIndex:2].intValue * 60;
    returnInt += [string substringFromIndex:2].intValue;
    
    return returnInt;
}


-(IBAction)pushMapTest:(id)sender{
    
    SaveDataPackage *dataPkg = [SaveDataPackage presentData];
    
    NSArray<NAVLOGLegComponents *> *planArray = dataPkg.planArray;

    NSMutableString *testURL = [NSMutableString new];
    [testURL appendString:@"https://maps.googleapis.com/maps/api/staticmap?"];
    /*
    double centerLat = ([[self class] convertStringToLat:planArray[0].latString] + [[self class] convertStringToLat:planArray.lastObject.latString]) / 2.0;
    double centerLon = ([[self class] convertStringToLon:planArray[0].lonString] + [[self class] convertStringToLon:planArray.lastObject.lonString]) / 2.0
    
    //[testURL appendFormat:@"&center=%.5f,%.5f",centerLat, centerLon];*/
    //[testURL appendString:@"&zoom=2"];
    //[testURL appendString:@"&size=640x640"];
    [testURL appendString:@"&size=302x640"];//640 / 1.41421356 / 3 * 2
    //[testURL appendString:@"&format=PNG"];
    [testURL appendString:@"&scale=2"];
    //[testURL appendString:@"&maptype=roadmap"];
    /*
    [testURL appendString:@"https://chart.apis.google.com/chart?chst=d_map_pin_icon%26chld=cafe%257C996600%7C224+West+20th+Street+NY%7C75+9th+Ave+NY%7C700+E+9th+St+NY&path=color:0x0000ff|weight:5|40.737102,-73.990318|40.749825,-73.987963|40.752946,-73.987384|40.755823,-73.986397&key=AIzaSyAjv4LpnqIuvaoiK6ot5i4Wf9Mf8BGZ1go"];*/
    
    [testURL appendString:@"&path="];
    
    __block const NSInteger lastLegIdx = planArray.count - 1;
    [planArray enumerateObjectsUsingBlock:^(NAVLOGLegComponents * _Nonnull comps, NSUInteger idx, BOOL * _Nonnull stop) {
        [testURL appendFormat:@"%.5f,%.5f",
         [[self class] convertStringToLat:comps.latString],
         [[self class] convertStringToLon:comps.lonString]];
        if (idx != lastLegIdx) {
            [testURL appendString:@"|"];
        }
    }];
    
    //[testURL appendString:@"|geodesic"];
    
    [testURL appendString:@"&key=AIzaSyAjv4LpnqIuvaoiK6ot5i4Wf9Mf8BGZ1go"];
    
    NSURL *url = [NSURL URLWithString:[testURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
    }];
    
    
}

+(NSString *)convertLatToString:(double)lat {
    NSMutableString *returnString = [NSMutableString new];
    
    double tmp = lat;
    
    if (tmp < 0) {
        [returnString appendString:@"S"];
        tmp = - tmp;
    } else {
        [returnString appendString:@"N"];
    }
    
    int tmp1 = (int)floor(tmp);
    int tmp2 = (int)round((tmp - tmp1) * 600);
    
    if (tmp2 == 600) {
        tmp2 = 0;
        tmp1++;
    }
    
    [returnString appendString:[NSString stringWithFormat:@"%02d",tmp1]];
    [returnString appendString:[NSString stringWithFormat:@"%03d",tmp2]];
    
    return [returnString copy];
    
    
}

+(NSString *)convertLonToString:(double)lon {
    NSMutableString *returnString = [NSMutableString new];
    
    double tmp = lon;
    
    if (tmp < 0) {
        [returnString appendString:@"W"];
        tmp = - tmp;
    } else {
        [returnString appendString:@"E"];
    }
    
    int tmp1 = (int)floor(tmp);
    int tmp2 = (int)round((tmp - tmp1) * 600);
    
    if (tmp2 == 600) {
        tmp2 = 0;
        tmp1++;
    }
    
    [returnString appendString:[NSString stringWithFormat:@"%03d",tmp1]];
    [returnString appendString:[NSString stringWithFormat:@"%03d",tmp2]];
    
    return [returnString copy];
    
}

+(double)convertStringToLat:(NSString *)string{
    
    if ([string isEqualToString:@""]) {
        return 0;
    }
    
    
    double returnValue = 0;
    
    
    returnValue += [string substringWithRange:NSMakeRange(1, 2)].doubleValue;
    returnValue += [string substringWithRange:NSMakeRange(3, 2)].doubleValue / 60;
    returnValue += [string substringWithRange:NSMakeRange(5, 1)].doubleValue / 600;
    
    if ([string hasPrefix:@"N"]) {
        return returnValue;
    } else if([string hasPrefix:@"S"]){
        return -returnValue;
    }
    
    return 0;
    
}

+(double)convertStringToLon:(NSString *)string{
    
    double returnValue = 0;
    
    if ([string isEqualToString:@""]) {
        return 0;
    }
    
    returnValue += [string substringWithRange:NSMakeRange(1, 3)].doubleValue;
    returnValue += [string substringWithRange:NSMakeRange(4, 2)].doubleValue / 60;
    returnValue += [string substringWithRange:NSMakeRange(6, 1)].doubleValue / 600;
    
    if ([string hasPrefix:@"E"]) {
        return returnValue;
    } else if([string hasPrefix:@"W"]){
        return -returnValue;
    }
    
    return 0;
    
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
