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
    
    [self planReload];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(planReload) name:@"planReload" object:nil];
    [nc addObserver:self selector:@selector(setWeatherForcast) name:@"forcastReceive" object:nil];

    
}

-(void)planReload{
    
    routeCopy = [[RouteCopy alloc] init];
    legsArray = [routeCopy arrayOfFMCLegs];
    [_legsTableView reloadData];
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

- (IBAction)pushWeatherForcast:(id)sender {
    
    WeatherForcastData *forcast = [SaveDataPackage presentData].otherData.forcast;
    
    if ([forcast.posteriorWeatherForcastSummery isEqualToString:@""]) {
        WeatherForcast *wf = [[WeatherForcast alloc] init];
        
        wf.delegate = self;
        
        
        [wf weatherForcastRequestWithDataPackage:[SaveDataPackage presentData]];

    } else {
        
        [self setWeatherForcast];
        
    }
    
    
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

-(void)setSunRiseSunSet{
    NSMutableString *returnString = [NSMutableString new];
    
    NSArray<SunMoonPointComponents *> *sunMoonArray = [SaveDataPackage presentData].sunMoonPlanArray;
    
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
    
    NSArray<SunMoonPointComponents *> *sunMoonArray = [SaveDataPackage presentData].sunMoonPlanArray;
    
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
    
    [returnString appendFormat:@"(Moon Phase:%.01fday(s))",
     [SaveDataPackage presentData].moonPhase];
    
    _moonRiseSetPhaseLabel.text = returnString;
                                                        
  
}


-(void)setWeatherForcast{
    SaveDataPackage *presentData = [SaveDataPackage presentData];
    
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
    
    SaveDataPackage *dataPackage = [SaveDataPackage presentData];
    
    _depAPOLabel.text = [NSString stringWithFormat:@"%@/%@",
                         dataPackage.atcData.depAPO4, dataPackage.otherData.depAPO3];
    _arrAPOLabel.text = [NSString stringWithFormat:@"%@/%@",
                         dataPackage.atcData.arrAPO4, dataPackage.otherData.arrAPO3];
    
    _depTimeLabel.text = dataPackage.otherData.STD;
    _arrTimeLabel.text = dataPackage.otherData.STA;
    
}

-(void)setFMCCourse {
    
    _FMCCourseLabel.text = [SaveDataPackage presentData].otherData.FMCCourse;
    
}


-(void)receiveForcastWithForcastData:(WeatherForcastData *)forcast {
    
    OtherData *otherData = [SaveDataPackage presentData].otherData;
    
    otherData.forcast = forcast;
    
    [SaveDataPackage savePresentDataWithOtherData:otherData];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
