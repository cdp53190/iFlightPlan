//
//  ATCViewController.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/18.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "ATCViewController.h"

@interface ATCViewController ()

@end

@implementation ATCViewController
{
    NSMutableArray *itemArray;
    NSArray *routeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self planReload];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(planReload) name:@"planReload" object:nil];

    
}

-(void)planReload{
    
    routeArray = [[[RouteCopy alloc]init] arrayOfATCRoute];
    
    [self reloadATC];
    
    _navigationItem.title = [SaveDataPackage presentData].otherData.flightNumber;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([tableView isEqual:_detailTableView] &&
        [(NSString *)itemArray[_titleTableView.indexPathForSelectedRow.row][@"title"] isEqualToString:@"Speed/Level/Route"]) {
        return routeArray.count;
    } else {
        return 1;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_titleTableView]) {
        return itemArray.count;
    } else if ([tableView isEqual:_detailTableView]) {
        
        if ([(NSString *)itemArray[_titleTableView.indexPathForSelectedRow.row][@"title"] isEqualToString:@"Speed/Level/Route"]) {
            return ((NSArray *)routeArray[section][@"WPTArray"]).count;
        } else {
            return ((NSArray *)itemArray[_titleTableView.indexPathForSelectedRow.row][@"detail"]).count;
        }
        
        
    }
    
    return 0;
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([tableView isEqual:_detailTableView] &&
        [(NSString *)itemArray[_titleTableView.indexPathForSelectedRow.row][@"title"] isEqualToString:@"Speed/Level/Route"]) {
        
        return [ATCViewController altSpeedFromString:routeArray[section][@"SPDAlt"]];
        
    } else {
        return @"";
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                    reuseIdentifier:@"cell"];

    }
    
    
    
    if ([tableView isEqual:_titleTableView]) {
        
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:itemArray[indexPath.row][@"title"]];;

        if ([itemArray[indexPath.row][@"disable"] boolValue]) {
            [titleString addAttribute:NSStrikethroughStyleAttributeName
                                value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                range:NSMakeRange(0, titleString.length)];
            cell.backgroundColor = [UIColor lightGrayColor];
        } else {
            cell.backgroundColor = [UIColor clearColor];
        }
        
        cell.textLabel.attributedText = titleString;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.minimumScaleFactor = .5;
        
        
    } else if ([tableView isEqual:_detailTableView]) {
        
        
        NSMutableAttributedString *titleString, *detailString;

        if ([(NSString *)itemArray[_titleTableView.indexPathForSelectedRow.row][@"title"] isEqualToString:@"Speed/Level/Route"]) {
            
            titleString = [[NSMutableAttributedString alloc] initWithString:routeArray[indexPath.section][@"routeArray"][indexPath.row]];
            detailString = [[NSMutableAttributedString alloc] initWithString:routeArray[indexPath.section][@"WPTArray"][indexPath.row]];
            
            cell.backgroundColor = [UIColor clearColor];
            
        } else {
            NSDictionary *dic = ((NSArray *)itemArray[_titleTableView.indexPathForSelectedRow.row][@"detail"])[indexPath.row];
            
            titleString = [[NSMutableAttributedString alloc] initWithString:dic[@"title"]];
            detailString = [[NSMutableAttributedString alloc] initWithString:dic[@"detail"]];
            
            
            if ([dic[@"disable"] boolValue]) {
                [titleString addAttribute:NSStrikethroughStyleAttributeName
                                    value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                    range:NSMakeRange(0, titleString.length)];
                [titleString addAttribute:NSFontAttributeName
                                    value:[UIFont fontWithName:@"Arial" size:17]
                                    range:NSMakeRange(0, titleString.length)];
                
                [detailString addAttribute:NSStrikethroughStyleAttributeName
                                     value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                     range:NSMakeRange(0, detailString.length)];
                [detailString addAttribute:NSFontAttributeName
                                     value:[UIFont fontWithName:@"Arial" size:17]
                                     range:NSMakeRange(0, detailString.length)];

                cell.backgroundColor = [UIColor lightGrayColor];
                
            } else {
                cell.backgroundColor = [UIColor clearColor];
            }
            
        }
        

        
        cell.textLabel.attributedText = titleString;
        cell.detailTextLabel.attributedText = detailString;
        cell.detailTextLabel.textColor = [UIColor blackColor];
        
    }
    
    return cell;
    
    
}

-(void)reloadATC {
    
    SaveDataPackage *dataPackage = [SaveDataPackage presentData];
    
    ATCData *data = dataPackage.atcData;
    
    if (!data) {
        return;
    }
    
    itemArray = [NSMutableArray new];
    
    ////////////////
    [itemArray addObject:@{@"title":@"Aircraft ID",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"ID",@"detail":data.aircraftID,@"disable":@NO}]}];
    
    ////////////////
    NSMutableDictionary *disableDic = [NSMutableDictionary new];
    
    disableDic[@"I"] = @YES;
    disableDic[@"V"] = @YES;
    disableDic[@"Y"] = @YES;
    disableDic[@"Z"] = @YES;
    
    disableDic[data.flightRules] = @NO;
    
    [itemArray addObject:@{@"title":@"Flight Rules",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"I",@"detail":@"IFR",@"disable":disableDic[@"I"]},
                                       @{@"title":@"V",@"detail":@"VFR",@"disable":disableDic[@"V"]},
                                       @{@"title":@"Y",@"detail":@"initially IFR then change the flight rule",@"disable":disableDic[@"Y"]},
                                       @{@"title":@"Z",@"detail":@"initially VFR then change the flight rule",@"disable":disableDic[@"Z"]}]}];
    
    ////////////////
    disableDic = [NSMutableDictionary new];
    
    disableDic[@"S"] = @YES;
    disableDic[@"N"] = @YES;
    disableDic[@"G"] = @YES;
    disableDic[@"M"] = @YES;
    disableDic[@"X"] = @YES;
    
    disableDic[data.typeOfFlight] = @NO;
    
    [itemArray addObject:@{@"title":@"Type of Flight",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"S",@"detail":@"scheduled air service",@"disable":disableDic[@"S"]},
                                       @{@"title":@"N",@"detail":@"non-scheduled air transport operation",@"disable":disableDic[@"N"]},
                                       @{@"title":@"G",@"detail":@"general aviation",@"disable":disableDic[@"G"]},
                                       @{@"title":@"M",@"detail":@"military",@"disable":disableDic[@"M"]},
                                       @{@"title":@"X",@"detail":@"other then above",@"disable":disableDic[@"X"]}]}];
    
    ////////////////
    [itemArray addObject:@{@"title":@"Number of Aircraft",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"Number",@"detail":data.numberOfAircraft,@"disable":@NO}]}];
    
    ////////////////
    [itemArray addObject:@{@"title":@"Type(s) of Aircraft",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"Type",@"detail":data.typeOfAircraft,@"disable":@NO}]}];
    
    ////////////////
    disableDic = [NSMutableDictionary new];
    
    disableDic[@"J"] = @YES;
    disableDic[@"H"] = @YES;
    disableDic[@"M"] = @YES;
    disableDic[@"L"] = @YES;
    
    disableDic[data.wakeCategory] = @NO;
    
    [itemArray addObject:@{@"title":@"Wake Turbulence Category",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"J",@"detail":@"Super Heavy(A380[Max take-off Weight = 560000kg])",@"disable":disableDic[@"J"]},
                                       @{@"title":@"H",@"detail":@"Heavy([Max take-off Weight] >= 136000kg)",@"disable":disableDic[@"H"]},
                                       @{@"title":@"M",@"detail":@"Medium(7000kg < [Max take-off Weight] < 136000kg)",@"disable":disableDic[@"M"]},
                                       @{@"title":@"L",@"detail":@"Light([Max take-off Weight] <= 7000kg)",@"disable":disableDic[@"L"]}]}];
    
    ////////////////
    disableDic = [NSMutableDictionary new];
    
    disableDic[@"N"] = @YES;
    disableDic[@"S"] = @YES;
    disableDic[@"A"] = @YES;
    disableDic[@"B"] = @YES;
    disableDic[@"C"] = @YES;
    disableDic[@"D"] = @YES;
    disableDic[@"E1"] = @YES;
    disableDic[@"E2"] = @YES;
    disableDic[@"E3"] = @YES;
    disableDic[@"F"] = @YES;
    disableDic[@"G"] = @YES;
    disableDic[@"H"] = @YES;
    disableDic[@"I"] = @YES;
    disableDic[@"J1"] = @YES;
    disableDic[@"J2"] = @YES;
    disableDic[@"J3"] = @YES;
    disableDic[@"J4"] = @YES;
    disableDic[@"J5"] = @YES;
    disableDic[@"J6"] = @YES;
    disableDic[@"J7"] = @YES;
    disableDic[@"K"] = @YES;
    disableDic[@"L"] = @YES;
    disableDic[@"M1"] = @YES;
    disableDic[@"M2"] = @YES;
    disableDic[@"M3"] = @YES;
    disableDic[@"O"] = @YES;
    disableDic[@"R"] = @YES;
    disableDic[@"T"] = @YES;
    disableDic[@"U"] = @YES;
    disableDic[@"V"] = @YES;
    disableDic[@"W"] = @YES;
    disableDic[@"X"] = @YES;
    disableDic[@"Y"] = @YES;
    disableDic[@"Z"] = @YES;
    
    NSString *atcString = data.COMNAVEquip;
    NSInteger length = atcString.length;
    
    NSString *oldLetter = @"";
    
    for (int i = 0; i < length; i++) {
        
        NSString *letter = [atcString substringWithRange:NSMakeRange(i, 1)];
        
        if ([ATCViewController isDigit:letter]) {
            disableDic[[oldLetter stringByAppendingString:letter]] = @NO;
        } else {
            if (![oldLetter isEqualToString:@""]) {
                disableDic[oldLetter] = @NO;
            }
        }
        
        oldLetter = letter;
        
    }
    
    if (![ATCViewController isDigit:oldLetter]) {
        disableDic[oldLetter] = @NO;
    }
    
    [itemArray addObject:@{@"title":@"Radio & Navigation Aids",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"N",@"detail":@"no COM/NAV/Approach aid equipment",@"disable":disableDic[@"N"]},
                                       @{@"title":@"S",@"detail":@"standard COM/NAV/Approach aid([VHF RTF]/VOR/ILS)",@"disable":disableDic[@"S"]},
                                       @{@"title":@"A",@"detail":@"GBAS landing system",@"disable":disableDic[@"A"]},
                                       @{@"title":@"B",@"detail":@"LPV(APV with SBAS)",@"disable":disableDic[@"B"]},
                                       @{@"title":@"C",@"detail":@"LORAN C",@"disable":disableDic[@"C"]},
                                       @{@"title":@"D",@"detail":@"DME",@"disable":disableDic[@"D"]},
                                       @{@"title":@"E1",@"detail":@"FMC WPR(Waypoint Position Reporting) ACARS",@"disable":disableDic[@"E1"]},
                                       @{@"title":@"E2",@"detail":@"D-FIS ACARS",@"disable":disableDic[@"E2"]},
                                       @{@"title":@"E3",@"detail":@"PDC ACARS",@"disable":disableDic[@"E3"]},
                                       @{@"title":@"F",@"detail":@"ADF",@"disable":disableDic[@"F"]},
                                       @{@"title":@"G",@"detail":@"GNSS",@"disable":disableDic[@"G"]},
                                       @{@"title":@"H",@"detail":@"HF RTF(Radio Telephony)",@"disable":disableDic[@"H"]},
                                       @{@"title":@"I",@"detail":@"Inertial Navigation",@"disable":disableDic[@"I"]},
                                       @{@"title":@"J1",@"detail":@"CPDLC ATN VDL(VHF Datalink) Mode 2",@"disable":disableDic[@"J1"]},
                                       @{@"title":@"J2",@"detail":@"CPDLC FANS 1/A HFDL(HF DataLink)",@"disable":disableDic[@"J2"]},
                                       @{@"title":@"J3",@"detail":@"CPDLC FANS 1/A VDL(VHF DataLink) Mode A",@"disable":disableDic[@"J3"]},
                                       @{@"title":@"J4",@"detail":@"CPDLC FANS 1/A VDL(VHF DataLink) Mode 2",@"disable":disableDic[@"J4"]},
                                       @{@"title":@"J5",@"detail":@"CPDLC FANS 1/A SATCOM(INMARSAT)",@"disable":disableDic[@"J5"]},
                                       @{@"title":@"J6",@"detail":@"CPDLC FANS 1/A SATCOM(MTSAT)",@"disable":disableDic[@"J6"]},
                                       @{@"title":@"J7",@"detail":@"CPDLC FANS 1/A SATCOM(Iridium)",@"disable":disableDic[@"J7"]},
                                       @{@"title":@"K",@"detail":@"MLS",@"disable":disableDic[@"K"]},
                                       @{@"title":@"L",@"detail":@"ILS",@"disable":disableDic[@"L"]},
                                       @{@"title":@"M1",@"detail":@"ATC RTF(Radio Telephony) SATCOM(INMARSAT)",@"disable":disableDic[@"M1"]},
                                       @{@"title":@"M2",@"detail":@"ATC RTF(Radio Telephony) SATCOM(MTSAT)",@"disable":disableDic[@"M2"]},
                                       @{@"title":@"M3",@"detail":@"ATC RTF(Radio Telephony) SATCOM(Iridium)",@"disable":disableDic[@"M3"]},
                                       @{@"title":@"O",@"detail":@"VOR",@"disable":disableDic[@"O"]},
                                       @{@"title":@"R",@"detail":@"PBN approved",@"disable":disableDic[@"R"]},
                                       @{@"title":@"T",@"detail":@"TACAN",@"disable":disableDic[@"T"]},
                                       @{@"title":@"U",@"detail":@"UHF RTF(Radio Telephony)",@"disable":disableDic[@"U"]},
                                       @{@"title":@"V",@"detail":@"VHF RTF(Radio Telephony)",@"disable":disableDic[@"V"]},
                                       @{@"title":@"W",@"detail":@"RVSM approved",@"disable":disableDic[@"W"]},
                                       @{@"title":@"X",@"detail":@"MNPS approved",@"disable":disableDic[@"X"]},
                                       @{@"title":@"Y",@"detail":@"VHF with 8.33kHz channel spacing",@"disable":disableDic[@"Y"]},
                                       @{@"title":@"Z",@"detail":@"Other equipment carried or capabilities",@"disable":disableDic[@"Z"]}]}];
    
    ////////////////
    disableDic = [NSMutableDictionary new];
    
    disableDic[@"N"] = @YES;
    disableDic[@"A"] = @YES;
    disableDic[@"C"] = @YES;
    disableDic[@"E"] = @YES;
    disableDic[@"H"] = @YES;
    disableDic[@"L"] = @YES;
    disableDic[@"S"] = @YES;
    disableDic[@"I"] = @YES;
    disableDic[@"P"] = @YES;
    disableDic[@"X"] = @YES;
    disableDic[@"B1"] = @YES;
    disableDic[@"B2"] = @YES;
    disableDic[@"U1"] = @YES;
    disableDic[@"U2"] = @YES;
    disableDic[@"V1"] = @YES;
    disableDic[@"V2"] = @YES;
    disableDic[@"D1"] = @YES;
    disableDic[@"G1"] = @YES;
    
    NSString *surString = data.surveillanceEquip;
    length = surString.length;
    
    oldLetter = @"";
    
    for (int i = 0; i < length; i++) {
        
        NSString *letter = [surString substringWithRange:NSMakeRange(i, 1)];
        
        if ([ATCViewController isDigit:letter]) {
            disableDic[[oldLetter stringByAppendingString:letter]] = @NO;
        } else {
            if (![oldLetter isEqualToString:@""]) {
                disableDic[oldLetter] = @NO;
            }
        }
        
        oldLetter = letter;
        
    }
    
    if (![ATCViewController isDigit:oldLetter]) {
        disableDic[oldLetter] = @NO;
    }
    
    [itemArray addObject:@{@"title":@"Surveillance equipment",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"N",@"detail":@"no surveillance equipment",@"disable":disableDic[@"N"]},
                                       @{@"title":@"A",@"detail":@"Transponder Mode A",@"disable":disableDic[@"A"]},
                                       @{@"title":@"C",@"detail":@"Transponder Mode A and Mode C",@"disable":disableDic[@"C"]},
                                       @{@"title":@"E",@"detail":@"Transponder Mode S(Aircraft ID/ALT/ADS-B)",@"disable":disableDic[@"E"]},
                                       @{@"title":@"H",@"detail":@"Transponder Mode S(Aircraft ID/ALT/enhanced capability)",@"disable":disableDic[@"H"]},
                                       @{@"title":@"L",@"detail":@"Transponder Mode S(Aircraft ID/ALT/ADS-B/enhanced capability)",@"disable":disableDic[@"L"]},
                                       @{@"title":@"S",@"detail":@"Transponder Mode S(Aircraft ID/ALT)",@"disable":disableDic[@"S"]},
                                       @{@"title":@"I",@"detail":@"Transponder Mode S(Aircraft ID/NO ALT)",@"disable":disableDic[@"I"]},
                                       @{@"title":@"P",@"detail":@"Transponder Mode S(NO Aircraft ID/ALT)",@"disable":disableDic[@"P"]},
                                       @{@"title":@"X",@"detail":@"Transponder Mode S(NO Aircraft ID/NO ALT)",@"disable":disableDic[@"X"]},
                                       @{@"title":@"B1",@"detail":@"ADS-B out using 1090MHz",@"disable":disableDic[@"B1"]},
                                       @{@"title":@"B2",@"detail":@"ADS-B out/in using 1090MHz",@"disable":disableDic[@"B2"]},
                                       @{@"title":@"U1",@"detail":@"ADS-B out using UAT(Universal Access Transceiver)",@"disable":disableDic[@"U1"]},
                                       @{@"title":@"U2",@"detail":@"ADS-B out/in using UAT(Universal Access Transceiver)",@"disable":disableDic[@"U2"]},
                                       @{@"title":@"V1",@"detail":@"ADS-B out using VDL(VHF DataLink) Mode4",@"disable":disableDic[@"V1"]},
                                       @{@"title":@"V2",@"detail":@"ADS-B out/in using VDL(VHF DataLink) Mode4",@"disable":disableDic[@"V2"]},
                                       @{@"title":@"D1",@"detail":@"ADS-C with FANS 1/A",@"disable":disableDic[@"D1"]},
                                       @{@"title":@"G1",@"detail":@"ADS-C with ATN",@"disable":disableDic[@"G1"]}]}];
    
    ////////////////
    if ([data.depAPO4 isEqualToString:@"ZZZZ"]) {
        if (![data.DEP isEqualToString:@""]) {
            [itemArray addObject:@{@"title":@"Departure",
                                   @"disable":@NO,
                                   @"detail":@[@{@"title":@"Aerodrome",@"detail":@"ZZZZ",@"disable":@YES},
                                               @{@"title":@"Place",@"detail":data.DEP,@"disable":@NO},
                                               @{@"title":@"Time",@"detail":data.depTime,@"disable":@NO}]}];
            
        } else {
            [itemArray addObject:@{@"title":@"Departure",
                                   @"disable":@NO,
                                   @"detail":@[@{@"title":@"Aerodrome",@"detail":@"ZZZZ",@"disable":@YES},
                                               @{@"title":@"Place",@"detail":@"",@"disable":@NO},
                                               @{@"title":@"Time",@"detail":data.depTime,@"disable":@NO}]}];
            
        }
    } else {
        [itemArray addObject:@{@"title":@"Departure",
                               @"disable":@NO,
                               @"detail":@[@{@"title":@"Aerodrome",@"detail":data.depAPO4,@"disable":@NO},
                                           @{@"title":@"Place",@"detail":@"",@"disable":@YES},
                                           @{@"title":@"Time",@"detail":data.depTime,@"disable":@NO}]}];
    }
    
    ////////////////
    [itemArray addObject:@{@"title":@"Speed/Level/Route",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"",@"detail":@"",@"disable":@NO}]}];
    
    ////////////////
    if ([data.arrAPO4 isEqualToString:@"ZZZZ"]) {
        if (![data.DEST isEqualToString:@""]) {
            [itemArray addObject:@{@"title":@"Destination",
                                   @"disable":@NO,
                                   @"detail":@[@{@"title":@"Aerodrome",@"detail":@"ZZZZ",@"disable":@YES},
                                               @{@"title":@"Place",@"detail":data.DEST,@"disable":@NO}]}];
        } else {
            [itemArray addObject:@{@"title":@"Destination",
                                   @"disable":@NO,
                                   @"detail":@[@{@"title":@"Aerodrome",@"detail":@"ZZZZ",@"disable":@YES},
                                               @{@"title":@"Place",@"detail":@"",@"disable":@NO}]}];
            
        }
    } else {
        [itemArray addObject:@{@"title":@"Destination",
                               @"disable":@NO,
                               @"detail":@[@{@"title":@"Aerodrome",@"detail":data.arrAPO4,@"disable":@NO},
                                           @{@"title":@"Place",@"detail":@"",@"disable":@YES}]}];
    }
    
    ////////////////
    [itemArray addObject:@{@"title":@"Elapsed time",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"Time",@"detail":data.elapsedTime,@"disable":@NO}]}];
    
    ////////////////
    NSMutableArray *displayArray = [NSMutableArray new];
    
    
    if ([data.firstAlternateAPO4 isEqualToString:@""]) {
        disableDic[@"ALTN"] = @YES;
    } else if ([data.firstAlternateAPO4 isEqualToString:@"ZZZZ"]) {
        disableDic[@"ALTN"] = @NO;
        if (![data.ALTN isEqualToString:@""]) {
            [displayArray addObject:@{@"title":@"1st Alternate Aerodrome",@"detail":@"ZZZZ",@"disable":@YES}];
            [displayArray addObject:@{@"title":@"1st Alternate Place",@"detail":data.ALTN,@"disable":@NO}];
        } else {
            [displayArray addObject:@{@"title":@"1st Alternate Aerodrome",@"detail":@"ZZZZ",@"disable":@YES}];
            [displayArray addObject:@{@"title":@"1st Alternate Place",@"detail":@"",@"disable":@NO}];
        }
    } else {
        disableDic[@"ALTN"] = @NO;
        [displayArray addObject:@{@"title":@"1st Alternate Aerodrome",@"detail":data.firstAlternateAPO4,@"disable":@NO}];
        [displayArray addObject:@{@"title":@"1st Alternate Place",@"detail":@"",@"disable":@YES}];
    }
    
    if ([data.secondAlternateAPO4 isEqualToString:@""]) {
        [displayArray addObject:@{@"title":@"2nd Alternate Aerodrome",@"detail":@"",@"disable":@YES}];
        [displayArray addObject:@{@"title":@"2nd Alternate Place",@"detail":@"",@"disable":@YES}];
        
    } else if ([data.secondAlternateAPO4 isEqualToString:@"ZZZZ"]) {
        if (![data.ALTN isEqualToString:@""]) {
            [displayArray addObject:@{@"title":@"2nd Alternate Aerodrome",@"detail":@"ZZZZ",@"disable":@YES}];
            [displayArray addObject:@{@"title":@"2nd Alternate Place",@"detail":data.ALTN,@"disable":@NO}];
        } else {
            [displayArray addObject:@{@"title":@"2nd Alternate Aerodrome",@"detail":@"ZZZZ",@"disable":@YES}];
            [displayArray addObject:@{@"title":@"2nd Alternate Place",@"detail":@"",@"disable":@NO}];
        }
    } else {
        [displayArray addObject:@{@"title":@"2nd Alternate Aerodrome",@"detail":data.secondAlternateAPO4,@"disable":@NO}];
        [displayArray addObject:@{@"title":@"2nd Alternate Place",@"detail":@"",@"disable":@YES}];
    }
    
    [itemArray addObject:@{@"title":@"Alternate",
                           @"disable":disableDic[@"ALTN"],
                           @"detail":displayArray}];
    
    ////////////////
    if (!data.otherInfoExist) {
        [itemArray addObject:@{@"title":@"No other information",
                               @"disable":@NO,
                               @"detail":@[@{@"title":@"Other information",@"detail":@"nil",@"disable":@NO}]}];
    } else {
        [itemArray addObject:@{@"title":@"No other information",
                               @"disable":@YES,
                               @"detail":@[@{@"title":@"Other information",@"detail":@"nil",@"disable":@YES}]}];
    }
    
    ////////////////
    disableDic = [NSMutableDictionary new];
    
    disableDic[@"ALTRV"] = @YES;
    disableDic[@"ATFMX"] = @YES;
    disableDic[@"FFR"] = @YES;
    disableDic[@"FLTCK"] = @YES;
    disableDic[@"HAZMAT"] = @YES;
    disableDic[@"HEAD"] = @YES;
    disableDic[@"HOSP"] = @YES;
    disableDic[@"HUM"] = @YES;
    disableDic[@"MARSA"] = @YES;
    disableDic[@"MEDEVAC"] = @YES;
    disableDic[@"NONRVSM"] = @YES;
    disableDic[@"SAR"] = @YES;
    disableDic[@"STATE"] = @YES;
    disableDic[@"STS"] = @YES;
    
    if (![data.STS isEqualToString:@""]) {
        
        NSArray *array = [data.STS componentsSeparatedByString:@" "];
        
        for (NSString *string in array) {
            disableDic[string] = @NO;
        }
        disableDic[@"STS"] = @NO;
    }
    
    [itemArray addObject:@{@"title":@"Special handling(STS/)",
                           @"disable":disableDic[@"STS"],
                           @"detail":@[@{@"title":@"ALTRV",@"detail":@"with altitude reservation",@"disable":disableDic[@"ALTRV"]},
                                       @{@"title":@"ATFMX",@"detail":@"exemption from ATFM measures",@"disable":disableDic[@"ATFMX"]},
                                       @{@"title":@"FFR",@"detail":@"fire-fighting",@"disable":disableDic[@"FFR"]},
                                       @{@"title":@"FLTCK",@"detail":@"flight check of navaids",@"disable":disableDic[@"FLTCK"]},
                                       @{@"title":@"HAZMAT",@"detail":@"carrying hazardous material",@"disable":disableDic[@"HAZMAT"]},
                                       @{@"title":@"HEAD",@"detail":@"with Head of State status",@"disable":disableDic[@"HEAD"]},
                                       @{@"title":@"HOSP",@"detail":@"medical flight declared by medical authorities",@"disable":disableDic[@"HOSP"]},
                                       @{@"title":@"HUM",@"detail":@"humanitarian mission",@"disable":disableDic[@"HUM"]},
                                       @{@"title":@"MARSA",@"detail":@"military assumes responsibility for separation of military aircraft",@"disable":disableDic[@"MARSA"]},
                                       @{@"title":@"MEDEVAC",@"detail":@"life critical medical emergency evacuation",@"disable":disableDic[@"MEDEVAC"]},
                                       @{@"title":@"NONRVSM",@"detail":@"non-RVSM capable flight intending to operate in RVSM airspace",@"disable":disableDic[@"NONRVSM"]},
                                       @{@"title":@"SAR",@"detail":@"search and rescue mission",@"disable":disableDic[@"SAR"]},
                                       @{@"title":@"STATE",@"detail":@"military, customs or police services",@"disable":disableDic[@"STATE"]}]}];
    
    ////////////////
    disableDic = [NSMutableDictionary new];
    
    disableDic[@"A1"] = @YES;
    disableDic[@"B1"] = @YES;
    disableDic[@"B2"] = @YES;
    disableDic[@"B3"] = @YES;
    disableDic[@"B4"] = @YES;
    disableDic[@"B5"] = @YES;
    disableDic[@"B6"] = @YES;
    disableDic[@"C1"] = @YES;
    disableDic[@"C2"] = @YES;
    disableDic[@"C3"] = @YES;
    disableDic[@"C4"] = @YES;
    disableDic[@"D1"] = @YES;
    disableDic[@"D2"] = @YES;
    disableDic[@"D3"] = @YES;
    disableDic[@"D4"] = @YES;
    disableDic[@"L1"] = @YES;
    disableDic[@"O1"] = @YES;
    disableDic[@"O2"] = @YES;
    disableDic[@"O3"] = @YES;
    disableDic[@"O4"] = @YES;
    disableDic[@"S1"] = @YES;
    disableDic[@"S2"] = @YES;
    disableDic[@"T1"] = @YES;
    disableDic[@"T2"] = @YES;
    
    disableDic[@"PBN"] = @YES;
    
    if (![data.PBN isEqualToString:@""]) {
        
        NSString *string = data.PBN;
        
        NSString *string0 = @"";
        
        for (int i = 0; i < string.length; i++) {
            
            if (i % 2 == 0) {
                
                string0 = [string substringWithRange:NSMakeRange(i, 1)];
            } else {
                
                disableDic[[string0 stringByAppendingString:[string substringWithRange:NSMakeRange(i, 1)]]] = @NO;
            }
            
            
        }
        
        disableDic[@"PBN"] = @NO;
    }
    
    [itemArray addObject:@{@"title":@"RNAV/RNP capabilities(PBN/)",
                           @"disable":disableDic[@"PBN"],
                           @"detail":@[@{@"title":@"A1",@"detail":@"RNAV10(RNP10)",@"disable":disableDic[@"A1"]},
                                       @{@"title":@"B1",@"detail":@"RNAV5 all permitted sensors",@"disable":disableDic[@"B1"]},
                                       @{@"title":@"B2",@"detail":@"RNAV5 GNSS",@"disable":disableDic[@"B2"]},
                                       @{@"title":@"B3",@"detail":@"RNAV5 DME/DME",@"disable":disableDic[@"B3"]},
                                       @{@"title":@"B4",@"detail":@"RNAV5 VOR/DME",@"disable":disableDic[@"B4"]},
                                       @{@"title":@"B5",@"detail":@"RNAV5 INS or IRS",@"disable":disableDic[@"B5"]},
                                       @{@"title":@"B6",@"detail":@"RNAV5 LORAN-C",@"disable":disableDic[@"B6"]},
                                       @{@"title":@"C1",@"detail":@"RNAV2 all permitted sensors",@"disable":disableDic[@"C1"]},
                                       @{@"title":@"C2",@"detail":@"RNAV2 GNSS",@"disable":disableDic[@"C2"]},
                                       @{@"title":@"C3",@"detail":@"RNAV2 DME/DME",@"disable":disableDic[@"C3"]},
                                       @{@"title":@"C4",@"detail":@"RNAV2 DME/DME/IRU",@"disable":disableDic[@"C4"]},
                                       @{@"title":@"D1",@"detail":@"RNAV1 all permitted sensors",@"disable":disableDic[@"D1"]},
                                       @{@"title":@"D2",@"detail":@"RNAV1 GNSS",@"disable":disableDic[@"D2"]},
                                       @{@"title":@"D3",@"detail":@"RNAV1 DME/DME",@"disable":disableDic[@"D3"]},
                                       @{@"title":@"D4",@"detail":@"RNAV1 DME/DME/IRU",@"disable":disableDic[@"D4"]},
                                       @{@"title":@"L1",@"detail":@"RNP4",@"disable":disableDic[@"L1"]},
                                       @{@"title":@"O1",@"detail":@"Basic RNP1 all permitted sensors",@"disable":disableDic[@"O1"]},
                                       @{@"title":@"O2",@"detail":@"Basic RNP1 GNSS",@"disable":disableDic[@"O2"]},
                                       @{@"title":@"O3",@"detail":@"Basic RNP1 DME/DME",@"disable":disableDic[@"O3"]},
                                       @{@"title":@"O4",@"detail":@"Basic RNP1 DME/DME/IRU",@"disable":disableDic[@"O4"]},
                                       @{@"title":@"S1",@"detail":@"RNP APCH",@"disable":disableDic[@"S1"]},
                                       @{@"title":@"S2",@"detail":@"RNP APCH with BARO-VNAV",@"disable":disableDic[@"S2"]},
                                       @{@"title":@"T1",@"detail":@"RNP AR APCH with RF(Radious to fix)",@"disable":disableDic[@"T1"]},
                                       @{@"title":@"T2",@"detail":@"RNP AR APCH without RF(Radious to fix)",@"disable":disableDic[@"T2"]}]}];
    
    ////////////////
    disableDic = [NSMutableDictionary new];
    
    disableDic[@"GBAS"] = @YES;
    disableDic[@"SBAS"] = @YES;
    disableDic[@"RNP2"] = @YES;
    
    disableDic[@"NAV"] = @YES;
    
    if (![data.NAV isEqualToString:@""]) {
        
        NSArray *array = [data.NAV componentsSeparatedByString:@" "];
        
        for (NSString *string in array) {
            disableDic[string] = @NO;
        }
        
        disableDic[@"NAV"] = @NO;
    }
    
    [itemArray addObject:@{@"title":@"Navigation equipment(NAV/)",
                           @"disable":disableDic[@"NAV"],
                           @"detail":@[@{@"title":@"GBAS",@"detail":@"Ground Based Augmentation System",@"disable":disableDic[@"GBAS"]},
                                       @{@"title":@"SBAS",@"detail":@"Satellite Based Augmentation System",@"disable":disableDic[@"SBAS"]},
                                       @{@"title":@"RNP2",@"detail":@"RNP2 capability",@"disable":disableDic[@"RNP2"]}]}];
    
    ////////////////
    disableDic = [NSMutableDictionary new];
    
    disableDic[@"COM"] = @YES;
    disableDic[@"COMdetail"] = @YES;
    
    if (![data.COM isEqualToString:@""]) {
        
        disableDic[@"COMdetail"] = @NO;
        
        disableDic[@"COM"] = @NO;
    }
    [itemArray addObject:@{@"title":@"Com applications(COM/)",
                           @"disable":disableDic[@"COM"],
                           @"detail":@[@{@"title":@"",@"detail":@"",@"disable":disableDic[@"COMdetail"]}]}];
    
    ////////////////
    disableDic = [NSMutableDictionary new];
    
    disableDic[@"1VOICE"] = @YES;
    disableDic[@"1PDC"] = @YES;
    disableDic[@"1FANS"] = @YES;
    disableDic[@"1FANSP"] = @YES;
    disableDic[@"1FANSP2PDC"] = @YES;
    
    disableDic[@"DAT"] = @YES;
    
    if (![data.DAT isEqualToString:@""]) {
        
        NSArray *array = [data.DAT componentsSeparatedByString:@" "];
        
        for (NSString *string in array) {
            disableDic[string] = @NO;
        }
        
        disableDic[@"DAT"] = @NO;
    }
    [itemArray addObject:@{@"title":@"Data applications(DAT/)",
                           @"disable":@NO,
                           @"detail":@[@{@"title":@"1VOICE",@"detail":@"Equipped ACARS & FANS but wants voice only",@"disable":disableDic[@"1VOICE"]},
                                       @{@"title":@"1PDC",@"detail":@"ACARS-PDC only, or PDC via other means",@"disable":disableDic[@"1PDC"]},
                                       @{@"title":@"1FANS",@"detail":@"FANS 1/A only, for CPDLC-DCL",@"disable":disableDic[@"1FANS"]},
                                       @{@"title":@"1FANSP",@"detail":@"FANS 1/A+ only, for CPDLC-DCL",@"disable":disableDic[@"1FANSP"]},
                                       @{@"title":@"1FANSP2PDC",@"detail":@"FANS 1/A+ CPDLC-DCL & backup ACARS-PDC",@"disable":disableDic[@"1FANSP2PDC"]}]}];
    
    ////////////////
    disableDic = [NSMutableDictionary new];
    
    disableDic[@"SUR"] = @YES;
    disableDic[@"SURdetail"] = @YES;
    
    if (![data.SUR isEqualToString:@""]) {
        
        disableDic[@"SURdetail"] = @NO;
        
        disableDic[@"SUR"] = @NO;
    }
    [itemArray addObject:@{@"title":@"Surveillance app.(SUR/)",
                           @"disable":disableDic[@"SUR"],
                           @"detail":@[@{@"title":@"",@"detail":@"",@"disable":disableDic[@"SURdetail"]}]}];
    
    ////////////////
    disableDic[@"DOF"] = @YES;
    disableDic[@"DOFdetail"] = @YES;
    
    NSString *detailString = @"";
    
    if (![data.DOF isEqualToString:@""]) {
        
        disableDic[@"DOF"] = @NO;
        
        detailString = [NSString stringWithFormat:@"%@-%@-%@",
                        [data.DOF substringWithRange:NSMakeRange(0, 2)],
                        [data.DOF substringWithRange:NSMakeRange(2, 2)],
                        [data.DOF substringWithRange:NSMakeRange(4, 2)]];
        
        disableDic[@"DOFdetail"] = @NO;
        
        
    }
    [itemArray addObject:@{@"title":@"Date of flight(DOF/)",
                           @"disable":disableDic[@"DOF"],
                           @"detail":@[@{@"title":@"Year-Month-Day",@"detail":detailString,@"disable":disableDic[@"DOFdetail"]}]}];
    
    ////////////////
    disableDic[@"REG"] = @YES;
    disableDic[@"REGdetail"] = @YES;
    
    detailString = @"";
    
    if (![data.REG isEqualToString:@""]) {
        
        disableDic[@"REG"] = @NO;
        
        detailString = data.REG;
        disableDic[@"REGdetail"] = @NO;
        
    }
    [itemArray addObject:@{@"title":@"Registration(REG/)",
                           @"disable":disableDic[@"REG"],
                           @"detail":@[@{@"title":@"Registration No.",@"detail":detailString,@"disable":disableDic[@"REGdetail"]}]}];
    
    ////////////////
    disableDic[@"EET"] = @YES;
    
    displayArray = [NSMutableArray new];
    
    if (![data.EET isEqualToString:@""]) {
        
        disableDic[@"EET"] = @NO;
        
        [displayArray addObject:@{@"title":@"FIR",
                                  @"detail":@"Elapsed Time",
                                  @"disable":@NO}];
        
        NSArray *eetArray = [data.EET componentsSeparatedByString:@" "];
        
        for (NSString *string in eetArray) {
            [displayArray addObject:@{@"title":[string substringToIndex:4],
                                      @"detail":[NSString stringWithFormat:@"%@+%@",
                                                 [string substringWithRange:NSMakeRange(4, 2)],
                                                 [string substringFromIndex:6]],
                                      @"disable":@NO}];
        }
        
        
    } else {
        
        [displayArray addObject:@{@"title":@"FIR",
                                  @"detail":@"Elapsed Time",
                                  @"disable":@YES}];
        
    }
    [itemArray addObject:@{@"title":@"Time of FIR boundary(EET/)",
                           @"disable":disableDic[@"EET"],
                           @"detail":displayArray}];
    
    ////////////////
    disableDic[@"SEL"] = @YES;
    disableDic[@"SELdetail"] = @YES;
    
    detailString = @"";
    
    if (![data.SEL isEqualToString:@""]) {
        
        disableDic[@"SEL"] = @NO;
        
        detailString = data.SEL;
        
        disableDic[@"SELdetail"] = @NO;
        
    }
    [itemArray addObject:@{@"title":@"SELCAL(SEL/)",
                           @"disable":disableDic[@"SEL"],
                           @"detail":@[@{@"title":@"Code",@"detail":detailString,@"disable":disableDic[@"SELdetail"]}]}];
    
    ////////////////
    disableDic[@"CODE"] = @YES;
    disableDic[@"CODEdetail"] = @YES;
    
    detailString = @"";
    
    if (![data.CODE isEqualToString:@""]) {
        
        disableDic[@"CODE"] = @NO;
        
        detailString = data.CODE;
        
        disableDic[@"CODEdetail"] = @NO;
        
    }
    [itemArray addObject:@{@"title":@"Aircraft address(CODE/)",
                           @"disable":disableDic[@"CODE"],
                           @"detail":@[@{@"title":@"address",@"detail":detailString,@"disable":disableDic[@"CODEdetail"]}]}];
    
    ////////////////
    disableDic[@"DLE"] = @YES;
    
    displayArray = [NSMutableArray new];
    
    if (![data.DLE isEqualToString:@""]) {
        
        disableDic[@"DLE"] = @NO;
        
        [displayArray addObject:@{@"title":@"At",
                                  @"detail":@"Time",
                                  @"disable":@NO}];
        
        NSArray *dleArray = [data.DLE componentsSeparatedByString:@" "];
        
        for (NSString *string in dleArray) {
            [displayArray addObject:@{@"title":[string substringToIndex:string.length - 4],
                                      @"detail":[NSString stringWithFormat:@"%@+%@",
                                                 [string substringWithRange:NSMakeRange(string.length - 4, 2)],
                                                 [string substringWithRange:NSMakeRange(string.length - 2, 2)]],
                                      @"disable":@NO}];
        }
        
        
    } else {
        
        [displayArray addObject:@{@"title":@"At",
                                  @"detail":@"Time",
                                  @"disable":@YES}];
        
    }
    [itemArray addObject:@{@"title":@"Planned Enroute Hold(DLE/)",
                           @"disable":disableDic[@"DLE"],
                           @"detail":displayArray}];
    
    ////////////////
    disableDic[@"OPR"] = @YES;
    disableDic[@"OPRdetail"] = @YES;
    
    detailString = @"";
    
    if (![data.OPR isEqualToString:@""]) {
        
        disableDic[@"OPR"] = @NO;
        
        detailString = data.OPR;
        
        disableDic[@"OPRdetail"] = @NO;
        
    }
    [itemArray addObject:@{@"title":@"Operationg Agency(OPR/)",
                           @"disable":disableDic[@"OPR"],
                           @"detail":@[@{@"title":@"Agency",@"detail":detailString,@"disable":disableDic[@"OPRdetail"]}]}];
    
    ////////////////
    disableDic[@"ORGN"] = @YES;
    disableDic[@"ORGNdetail"] = @YES;
    
    detailString = @"";
    
    if (![data.ORGN isEqualToString:@""]) {
        
        disableDic[@"ORGN"] = @NO;
        
        detailString = data.ORGN;
        
        disableDic[@"ORGNdetail"] = @NO;
        
    }
    [itemArray addObject:@{@"title":@"Originator's Address(ORGN/)",
                           @"disable":disableDic[@"ORGN"],
                           @"detail":@[@{@"title":@"Address",@"detail":detailString,@"disable":disableDic[@"ORGNdetail"]}]}];
    
    ////////////////
    disableDic[@"PER"] = @YES;
    disableDic[@"PERdetail"] = @YES;
    
    detailString = @"";
    
    if (![data.PER isEqualToString:@""]) {
        
        disableDic[@"PER"] = @NO;
        
        detailString = data.PER;
        
        disableDic[@"PERdetail"] = @NO;
        
    }
    [itemArray addObject:@{@"title":@"Performance data(PER/)",
                           @"disable":disableDic[@"PER"],
                           @"detail":@[@{@"title":@"",@"detail":detailString,@"disable":disableDic[@"PERdetail"]}]}];
    
    ////////////////
    disableDic[@"RALT"] = @YES;
    
    displayArray = [NSMutableArray new];
    
    if (![data.RALT isEqualToString:@""]) {
        
        disableDic[@"RALT"] = @NO;
        
        [displayArray addObject:@{@"title":@"Enroute Alternate",
                                  @"detail":@"Aerodrome",
                                  @"disable":@NO}];
        
        NSArray *RALTArray = [data.RALT componentsSeparatedByString:@" "];
        
        for (NSString *string in RALTArray) {
            [displayArray addObject:@{@"title":@"",
                                      @"detail":string,
                                      @"disable":@NO}];
        }
        
        
    } else {
        
        [displayArray addObject:@{@"title":@"Enroute Alternate",
                                  @"detail":@"Aerodrome",
                                  @"disable":@YES}];
        
    }
    [itemArray addObject:@{@"title":@"Enroute Alternate(RALT/)",
                           @"disable":disableDic[@"RALT"],
                           @"detail":displayArray}];
    
    ////////////////
    disableDic[@"TALT"] = @YES;
    disableDic[@"TALTdetail"] = @YES;
    
    detailString = @"";
    
    if (![data.TALT isEqualToString:@""]) {
        
        disableDic[@"TALT"] = @NO;
        
        detailString = data.TALT;
        
        disableDic[@"TALTdetail"] = @NO;
        
    }
    [itemArray addObject:@{@"title":@"Takeoff Alternate(TALT/)",
                           @"disable":disableDic[@"TALT"],
                           @"detail":@[@{@"title":@"Takeoff Alternate",@"detail":detailString,@"disable":disableDic[@"TALTdetail"]}]}];
    
    /////////////////
    disableDic[@"RIF"] = @YES;
    disableDic[@"RIFdetail"] = @YES;
    
    detailString = @"";
    
    if (![data.RIF isEqualToString:@""]) {
        
        disableDic[@"RIF"] = @NO;
        
        detailString = data.RIF;
        
        disableDic[@"RIFdetail"] = @NO;
        
    }

    [itemArray addObject:@{@"title":@"Route to revised dest.(RIF/)",
                           @"disable":disableDic[@"RIF"],
                           @"detail":@[@{@"title":@"",@"detail":detailString,@"disable":disableDic[@"RIFdetail"]}]}];
    
    /////////////////
    disableDic[@"RMK"] = @YES;
    disableDic[@"RMKdetail"] = @YES;
    
    detailString = @"";
    
    if (![data.RMK isEqualToString:@""]) {
        
        disableDic[@"RMK"] = @NO;
        
        detailString = data.RMK;
        
        disableDic[@"RMKdetail"] = @NO;
        
    }
    [itemArray addObject:@{@"title":@"Other remarks(RMK/)",
                           @"disable":disableDic[@"RMK"],
                           @"detail":@[@{@"title":@"",@"detail":detailString,@"disable":disableDic[@"RMKdetail"]}]}];
    
    
    
    
    [_titleTableView reloadData];
    [_detailTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_detailTableView reloadData];
    
}

+(NSString *)altSpeedFromString:(NSString *)string{
    
    NSMutableString *returnString = [NSMutableString new];

    NSString *firstLetter = [string substringToIndex:1];
    NSString *otherString = [string substringFromIndex:1];
    
    NSString *altString;
    
    if ([firstLetter isEqualToString:@"K"]) {
        [returnString appendFormat:@"%dkm/h",[[otherString substringToIndex:4] intValue]];
        altString = [otherString substringFromIndex:4];
    } else if ([firstLetter isEqualToString:@"N"]) {
        [returnString appendFormat:@"%dkt",[[otherString substringToIndex:4] intValue]];
        altString = [otherString substringFromIndex:4];
    } else if ([firstLetter isEqualToString:@"M"]) {
        NSString *speed = [NSString stringWithFormat:@"%@.%@",
                           [otherString substringToIndex:1],
                           [otherString substringWithRange:NSMakeRange(1, 2)]];
        [returnString appendFormat:@"Mach%@",speed];
        altString = [otherString substringFromIndex:3];
    } else {
        return @"error";
    }

    [returnString appendString:@"/"];
    
    firstLetter = [altString substringToIndex:1];
    otherString = [altString substringFromIndex:1];
    
    if ([firstLetter isEqualToString:@"F"]) {
        [returnString appendFormat:@"FL%@",otherString];

    } else if ([firstLetter isEqualToString:@"S"]) {
        [returnString appendFormat:@"%@0m",otherString];

    } else if ([firstLetter isEqualToString:@"A"]) {
        [returnString appendFormat:@"%@00feet",otherString];
    
    } else if ([firstLetter isEqualToString:@"M"]) {
        [returnString appendFormat:@"%@0m",otherString];
        
    } else if ([firstLetter isEqualToString:@"V"] && [otherString isEqualToString:@"FR"]) {
        [returnString appendString:@"VFR"];
        
    } else {
        return @"error";
    }
    
    return returnString;
}


+(BOOL)isDigit:(NSString *)text
{
    NSCharacterSet *digitCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    
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


-(NSArray *)displayArrayOfATCRoute:(NSString *)string {
    NSMutableArray *returnArray = [NSMutableArray new];
    
    
    
    
    return returnArray;
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
