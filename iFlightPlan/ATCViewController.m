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
    NSArray *itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    itemArray = @[@{@"title":@"Aircraft ID",@"detail":@[@{@"title":@"",@"detail":@""}]},
                  
                  @{@"title":@"Flight Rules",@"detail":@[@{@"title":@"I",@"detail":@"IFR"},
                                                         @{@"title":@"V",@"detail":@"VFR"},
                                                         @{@"title":@"Y",@"detail":@"initially IFR then change the flight rule"},
                                                         @{@"title":@"Z",@"detail":@"initially VFR then change the flight rule"}]},
                  
                  @{@"title":@"Type of Flight",@"detail":@[@{@"title":@"S",@"detail":@"scheduled air service"},
                                                           @{@"title":@"N",@"detail":@"non-scheduled air trasport operation"},
                                                           @{@"title":@"G",@"detail":@"general aviation"},
                                                           @{@"title":@"M",@"detail":@"military"},
                                                           @{@"title":@"X",@"detail":@"other then above"}]},
                  
                  @{@"title":@"Number of Aircraft",@"detail":@[@{@"title":@"",@"detail":@""}]},
                  @{@"title":@"Type of Aircraft",@"detail":@[@{@"title":@"",@"detail":@""}]},
                  
                  @{@"title":@"Wake Turbulence Category",@"detail":@[@{@"title":@"J",@"detail":@"Super Heavy(A380[Max take-off Weight = 560000kg])"},
                                                                     @{@"title":@"H",@"detail":@"Heavy([Max take-off Weight] >= 136000kg)"},
                                                                     @{@"title":@"M",@"detail":@"Medium(7000kg < [Max take-off Weight] < 136000kg)"},
                                                                     @{@"title":@"L",@"detail":@"Light([Max take-off Weight] <= 7000kg)"}]},
                  
                  @{@"title":@"Radio & Navigation Aids",@"detail":@[@{@"title":@"N",@"detail":@"no COM/NAV/Approach aid equipment"},
                                                                    @{@"title":@"S",@"detail":@"standard COM/NAV/Approach aid([VHF RTF]/VOR/ILS)"},
                                                                    @{@"title":@"A",@"detail":@"GBAS landing system"},
                                                                    @{@"title":@"B",@"detail":@"LPV(APV with SBAS)"},
                                                                    @{@"title":@"C",@"detail":@"LORAN C"},
                                                                    @{@"title":@"D",@"detail":@"DME"},
                                                                    @{@"title":@"E1",@"detail":@"FMC WPR(Waypoint Position Reporting) ACARS"},
                                                                    @{@"title":@"E2",@"detail":@"D-FIS ACARS"},
                                                                    @{@"title":@"E3",@"detail":@"PDC ACARS"},
                                                                    @{@"title":@"F",@"detail":@"ADF"},
                                                                    @{@"title":@"G",@"detail":@"GNSS"},
                                                                    @{@"title":@"H",@"detail":@"HF RTF(Radio Telephony)"},
                                                                    @{@"title":@"I",@"detail":@"Inertial Navigation"},
                                                                    @{@"title":@"J1",@"detail":@"CPDLC ATN VDL Mode 2"},
                                                                    @{@"title":@"J2",@"detail":@"CPDLC FANS 1/A HFDL(HF DataLink)"},
                                                                    @{@"title":@"J3",@"detail":@"CPDLC FANS 1/A VDL(VHF DataLink) Mode A"},
                                                                    @{@"title":@"J4",@"detail":@"CPDLC FANS 1/A VDL(VHF DataLink) Mode 2"},
                                                                    @{@"title":@"J5",@"detail":@"CPDLC FANS 1/A SATCOM(INMARSAT)"},
                                                                    @{@"title":@"J6",@"detail":@"CPDLC FANS 1/A SATCOM(MTSAT)"},
                                                                    @{@"title":@"J7",@"detail":@"CPDLC FANS 1/A SATCOM(Iridium)"},
                                                                    @{@"title":@"K",@"detail":@"MLS"},
                                                                    @{@"title":@"L",@"detail":@"ILS"},
                                                                    @{@"title":@"M1",@"detail":@"ATC RTF(Radio Telephony) SATCOM(INMARSAT)"},
                                                                    @{@"title":@"M2",@"detail":@"ATC RTF(Radio Telephony) SATCOM(MTSAT)"},
                                                                    @{@"title":@"M3",@"detail":@"ATC RTF(Radio Telephony) SATCOM(Iridium)"},
                                                                    @{@"title":@"O",@"detail":@"VOR"},
                                                                    @{@"title":@"R",@"detail":@"PBN approved"},
                                                                    @{@"title":@"T",@"detail":@"TACAN"},
                                                                    @{@"title":@"U",@"detail":@"UHF RTF(Radio Telephony)"},
                                                                    @{@"title":@"V",@"detail":@"VHF RTF(Radio Telephony)"},
                                                                    @{@"title":@"W",@"detail":@"RVSM approved"},
                                                                    @{@"title":@"X",@"detail":@"MNPS approved"},
                                                                    @{@"title":@"Y",@"detail":@"VHF with 8.33kHz channel spacing"},
                                                                    @{@"title":@"Z",@"detail":@"Other equipment carried or capabilities"}]},
                  
                  @{@"title":@"Surveillance equipment",@"detail":@[@{@"title":@"N",@"detail":@"no surveillance equipment"},
                                                                   @{@"title":@"A",@"detail":@"Transponder Mode A"},
                                                                   @{@"title":@"C",@"detail":@"Transponder Mode A and Mode C"},
                                                                   @{@"title":@"E",@"detail":@"Transponder Mode S(Aircraft ID/ALT/ADS-B)"},
                                                                   @{@"title":@"H",@"detail":@"Transponder Mode S(Aircraft ID/ALT/enhanced capability)"},
                                                                   @{@"title":@"L",@"detail":@"Transponder Mode S(Aircraft ID/ALT/ADS-B/enhanced capability)"},
                                                                   @{@"title":@"S",@"detail":@"Transponder Mode S(Aircraft ID/ALT)"},
                                                                   @{@"title":@"I",@"detail":@"Transponder Mode S(Aircraft ID/NO ALT)"},
                                                                   @{@"title":@"P",@"detail":@"Transponder Mode S(NO Aircraft ID/ALT)"},
                                                                   @{@"title":@"X",@"detail":@"Transponder Mode S(NO Aircraft ID/NO ALT)"},
                                                                   @{@"title":@"B1",@"detail":@"ADS-B out using 1090MHz"},
                                                                   @{@"title":@"B2",@"detail":@"ADS-B out/in using 1090MHz"},
                                                                   @{@"title":@"U1",@"detail":@"ADS-B out using UAT(Universal Access Transceiver)"},
                                                                   @{@"title":@"U2",@"detail":@"ADS-B out/in using UAT(Universal Access Transceiver)"},
                                                                   @{@"title":@"V1",@"detail":@"ADS-B out using VDL(VHF DataLink) Mode4"},
                                                                   @{@"title":@"V2",@"detail":@"ADS-B out/in using VDL(VHF DataLink) Mode4"},
                                                                   @{@"title":@"D1",@"detail":@"ADS-C with FANS 1/A"},
                                                                   @{@"title":@"G1",@"detail":@"ADS-C with ATN"}]},
                  
                  @{@"title":@"Departure",@"detail":@[@{@"title":@"Aerodrome",@"detail":@""},
                                                      @{@"title":@"Time",@"detail":@""}]},

                  @{@"title":@"Speed/Level/Route",@"detail":@[@{@"title":@"",@"detail":@""}]},

                  @{@"title":@"Destination",@"detail":@[@{@"title":@"Aerodrome",@"detail":@""}]},
                  
                  @{@"title":@"Elapsed time",@"detail":@[@{@"title":@"",@"detail":@""}]},
                  
                  @{@"title":@"Alternate",@"detail":@[@{@"title":@"Aerodrome",@"detail":@""}]},
                  
                  @{@"title":@"Special handling(STS/)",@"detail":@[@{@"title":@"ALTRV",@"detail":@"with altitude reservation"},
                                                                   @{@"title":@"ATFMX",@"detail":@"exemption from ATFM measures"},
                                                                   @{@"title":@"FFR",@"detail":@"fire-fighting"},
                                                                   @{@"title":@"FLTCK",@"detail":@"flight check of navaids"},
                                                                   @{@"title":@"HAZMAT",@"detail":@"carrying hazardous material"},
                                                                   @{@"title":@"HEAD",@"detail":@"with Head of State status"},
                                                                   @{@"title":@"HOSP",@"detail":@"medical flight declared by medical authorities"},
                                                                   @{@"title":@"HUM",@"detail":@"humanitarian mission"},
                                                                   @{@"title":@"MARSA",@"detail":@"military assumes responsibility for separation of military aircraft"},
                                                                   @{@"title":@"MEDEVAC",@"detail":@"life critical medical emergency evacuation"},
                                                                   @{@"title":@"NONRVSM",@"detail":@"non-RVSM capable flight intending to operate in RVSM airspace"},
                                                                   @{@"title":@"SAR",@"detail":@"search and rescue mission"},
                                                                   @{@"title":@"STATE",@"detail":@"military, customs or police services"}]},
                  
                  @{@"title":@"RNAV/RNP capabilities",@"detail":@[@{@"title":@"A1",@"detail":@"RNAV10(RNP10)"},
                                                                  @{@"title":@"B1",@"detail":@"RNAV5 all permitted sensors"},
                                                                  @{@"title":@"B2",@"detail":@"RNAV5 GNSS"},
                                                                  @{@"title":@"B3",@"detail":@"RNAV5 DME/DME"},
                                                                  @{@"title":@"B4",@"detail":@"RNAV5 VOR/DME"},
                                                                  @{@"title":@"B5",@"detail":@"RNAV5 INS or IRS"},
                                                                  @{@"title":@"B6",@"detail":@"RNAV5 LORAN-C"},
                                                                  @{@"title":@"C1",@"detail":@"RNAV2 all permitted sensors"},
                                                                  @{@"title":@"C2",@"detail":@"RNAV2 GNSS"},
                                                                  @{@"title":@"C3",@"detail":@"RNAV2 DME/DME"},
                                                                  @{@"title":@"C4",@"detail":@"RNAV2 DME/DME/IRU"},
                                                                  @{@"title":@"D1",@"detail":@"RNAV1 all permitted sensors"},
                                                                  @{@"title":@"D2",@"detail":@"RNAV1 GNSS"},
                                                                  @{@"title":@"D3",@"detail":@"RNAV1 DME/DME"},
                                                                  @{@"title":@"D4",@"detail":@"RNAV1 DME/DME/IRU"},
                                                                  @{@"title":@"L1",@"detail":@"RNP4"},
                                                                  @{@"title":@"O1",@"detail":@"Basic RNP1 all permitted sensors"},
                                                                  @{@"title":@"O2",@"detail":@"Basic RNP1 GNSS"},
                                                                  @{@"title":@"O3",@"detail":@"Basic RNP1 DME/DME"},
                                                                  @{@"title":@"O4",@"detail":@"Basic RNP1 DME/DME/IRU"},
                                                                  @{@"title":@"S1",@"detail":@"RNP APCH"},
                                                                  @{@"title":@"S2",@"detail":@"RNP APCH with BARO-VNAV"},
                                                                  @{@"title":@"T1",@"detail":@"RNP AR APCH with RF(Radious to fix)"},
                                                                  @{@"title":@"T2",@"detail":@"RNP AR APCH without RF(Radious to fix)"}]}
                  
                  ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_titleTableView]) {
        return itemArray.count;
    } else if ([tableView isEqual:_detailTableView]) {
        
        return ((NSArray *)itemArray[_titleTableView.indexPathForSelectedRow.row][@"detail"]).count;
        
    }
    
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                    reuseIdentifier:@"cell"];
    }
    
    if ([tableView isEqual:_titleTableView]) {
        
        cell.textLabel.text = itemArray[indexPath.row][@"title"];
        
        
    } else if ([tableView isEqual:_detailTableView]) {
        
        NSDictionary *dic = ((NSArray *)itemArray[_titleTableView.indexPathForSelectedRow.row][@"detail"])[indexPath.row];
        
        cell.textLabel.text = dic[@"title"];
        cell.detailTextLabel.text = dic[@"detail"];
        
    }
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_detailTableView reloadData];
    
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
