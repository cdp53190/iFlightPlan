//
//  PDFReader.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/09/21.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "PDFReader.h"


void operator_Text(
                   CGPDFScannerRef scanner,
                   void* info);
void operator_Font(
                   CGPDFScannerRef scanner,
                   void* info);

void operator_Text(
                   CGPDFScannerRef scanner,
                   void* info)
{
    [(__bridge PDFReader*)info operatorTextScanned:scanner];
}

void operator_Font(
                   CGPDFScannerRef scanner,
                   void* info)
{
    [(__bridge PDFReader*)info operatorFontScanned:scanner];
}

unichar unicharWithGlyph(
                         CGGlyph glyph)
{
    int i;
    
    // グリフからUnicodeへのマップの作成
    static CGGlyph  _glyphs[65535];
    static BOOL     _initialized = NO;
    if (!_initialized) {
        // Unicodeテーブルの初期化
        UniChar unichars[65535];
        for (i = 0; i < 65535; i++) {
            unichars[i] = i;
        }
        
        // CTFontの作成
        CTFontRef   ctFont;
        ctFont = CTFontCreateWithName((CFStringRef)@"TimesNewRomanPSMT", 10.0f, NULL);
        
        // Unicodeからグリフの取得
        CTFontGetGlyphsForCharacters(ctFont, unichars, _glyphs, 65535);
        
        // 初期化済みフラグの設定
        _initialized = YES;
    }
    
    // マップの検索
    for (i = 0; i < 65535; i++) {
        // 指定されたグリフが見つかった場合、そのインデクッスがunicodeとなっている
        if (_glyphs[i] == glyph) {
            return i;
        }
    }
    
    return 0;
}


@implementation PDFReader

{
    NSMutableString*        _text;
    CGPDFContentStreamRef   _stream;
    NSString*               _encoding;
    int                     _index;
    NSString *section,*stage,*stage2;
    
    NSMutableString *bufferString;
    int tempNo;
    
    SaveDataPackage *dataPackage;
    NSMutableArray<NAVLOGLegComponents *> *planArray;
    NAVLOGLegComponents *legComps;
    BOOL altnNavlogExist;
    
    NSMutableArray<RALTData *> *RALTArray;
    NSMutableArray<ETPDivertData *> *ETPDivertArray;
    
    RALTData *raltData;
    ETPDivertData *etpDivertData;
    
}

-(instancetype)init {
    if (self = [super init]) {
        
        section = @"";
        stage = @"";
        stage2 = @"";
        bufferString = [NSMutableString new];
        tempNo = 0;
        legComps = [[NAVLOGLegComponents alloc] init];
        planArray = [NSMutableArray new];
        altnNavlogExist = false;
        dataPackage = [[SaveDataPackage alloc] init];
        RALTArray = [NSMutableArray new];
        ETPDivertArray = [NSMutableArray new];
        
        raltData = [[RALTData alloc] init];
        etpDivertData = [[ETPDivertData alloc] init];
        
    }
    return self;
}



-(void)readPDFWithPathString:(NSString *)path {
    
    //既存プランのセーブ
    
    
    if ([SaveDataPackage presentData] != nil) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSNumber *planNumber = [ud objectForKey:@"planNumber"];
        [SaveDataPackage savePresentPlanWithPlanNumber:planNumber.integerValue];
    }

    
    // PDFドキュメントを作成
    CGPDFDocumentRef    document;
    NSURL *pathURL;
    if ([path hasPrefix:@"file://"]) {
        pathURL = [NSURL URLWithString:path];
    } else {
        pathURL = [NSURL fileURLWithPath:path];
    }
    
    document = CGPDFDocumentCreateWithURL((CFURLRef)pathURL);
    
    // PDFオペレータテーブルを作成
    CGPDFOperatorTableRef   table;
    table = CGPDFOperatorTableCreate();
    CGPDFOperatorTableSetCallback(table, "TJ", operator_Text);
    CGPDFOperatorTableSetCallback(table, "Tj", operator_Text);
    CGPDFOperatorTableSetCallback(table, "Tf", operator_Font);
    
    int pageNum = (int)CGPDFDocumentGetNumberOfPages(document);
    
    _index = 1;
    
    while(_index <= pageNum) {
        // PDFページを取得
        CGPDFPageRef    page;
        page = CGPDFDocumentGetPage(document, _index);
        
        // PDFコンテントストリームを取得
        _stream = CGPDFContentStreamCreateWithPage(page);
        
        // PDFスキャナを作成
        CGPDFScannerRef scanner;
        scanner = CGPDFScannerCreate(_stream, table, (__bridge void * _Nullable)(self));
        
        // スキャンを開始
        _text = [NSMutableString string];
        CGPDFScannerScan(scanner);
        
        // オブジェクトの解放
        CGPDFScannerRelease(scanner), scanner = NULL;
        
        _index++;
    }

    // オブジェクトの解放
    CGPDFDocumentRelease(document), document = NULL;
    CGPDFOperatorTableRelease(table), table = NULL;
    CGPDFContentStreamRelease(_stream), _stream = NULL;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if (dataPackage.planArray.count == 0 ||
        [dataPackage.weightData.takeoff isEqualToString:@""] ||
        [dataPackage.fuelTimeData.ramp.fuel isEqualToString:@""] ||
        [dataPackage.otherData.flightNumber isEqualToString:@""]) {
        
        [ud setObject:@true forKey:@"loadPlanFail"];
        [ud synchronize];

        NSNotification *n = [NSNotification notificationWithName:@"planReload" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:n];
        
        return;
        
    }
    
    
    //1分ごとのcourseArray作り
    dataPackage.courseArray = [CourseCalc makeCourseArrayWithPlanArray:dataPackage.planArray];
    
    //sunMoonPlanArray作り
    NSMutableString *timeString = [dataPackage.otherData.issueTime mutableCopy];//00:25 04SEP17
    
    [timeString insertString:@"20" atIndex:11];
    [timeString deleteCharactersInRange:NSMakeRange(2, 1)];//HHmm ddMMMyyyy(0025 04SEP2017)
    
    NSString *STDString = dataPackage.otherData.STD;//0940
    
    NSTimeInterval timeInterval = 0.0;
    if ([STDString intValue] < [[timeString substringToIndex:4] intValue]) {
        timeInterval = 60.0 * 60.0 * 24.0;
    }
    
    [timeString replaceCharactersInRange:NSMakeRange(0, 4) withString:STDString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setDateFormat:@"HHmm ddMMMyyyy"];
    
    NSDate *issueTimeDate = [formatter dateFromString:timeString];
    
    NSDate *takeOffDate =  [NSDate dateWithTimeInterval:timeInterval + 60.0 * 20.0 sinceDate:issueTimeDate];//STD+20分=T/O

    
    
    dataPackage.sunMoonTakeoffDate = [TakeoffTimeData dataOfdate:takeOffDate];
    dataPackage.sunMoonPlanArray = [SunMoon makeInitialSunMoonPlanArrayWithCourseArray:dataPackage.courseArray
                                                                           takeoffDate:takeOffDate];
    dataPackage.moonPhase = [SunMoon moonPhaseWithDate:takeOffDate];
    
    //oldPlanに追加
    [SaveDataPackage saveNewPlanWithDataPackage:dataPackage];
    
    //planNumber保存
    [ud setObject:@0 forKey:@"planNumber"];
    
    [ud setObject:@false forKey:@"loadPlanFail"];

    [ud synchronize];
    
    NSNotification *n = [NSNotification notificationWithName:@"planReload" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
    

}

- (void)operatorTextScanned:(CGPDFScannerRef)scanner
{
    // PDFオブジェクトの取得
    CGPDFObjectRef  object;
    CGPDFScannerPopObject(scanner, &object);
    
    // テキストの抽出
    NSString*   string;
    string = [self stringInPDFObject:object];
    
    
    //全データ取得テスト用
//    [bufferString appendString:string];
//    [bufferString appendString:@"\n"];
    
    
    
    
    string = [string stringByReplacingOccurrencesOfString:@"Ä" withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];

    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // データ化
    if (string && ![string isEqualToString:@""]) {
        [self makeDataWithString:string];
    }
    

    
    
}

- (void)operatorFontScanned:(CGPDFScannerRef)scanner
{
    bool    result;
    
    // フォントサイズの取得
    CGPDFReal size;
    result = CGPDFScannerPopNumber(scanner, &size);
    if (!result) {
        return;
    }
    
    // フォント名の取得
    const char* name;
    result = CGPDFScannerPopName(scanner, &name);
    if (!result) {
        return;
    }
    
    // フォントの取得
    CGPDFObjectRef  object;
    object = CGPDFContentStreamGetResource(_stream, "Font", name);
    if (!object) {
        return;
    }
    
    // PDF辞書の取得
    CGPDFDictionaryRef  dict;
    result = CGPDFObjectGetValue(object, kCGPDFObjectTypeDictionary, &dict);
    if (!result) {
        return;
    }
    
    // エンコーディングの取得
    const char* encoding;
    result = CGPDFDictionaryGetName(dict, "Encoding", &encoding);
    if (!result) {
        return;
    }
    
    // エンコーディングの設定
    _encoding = [NSString stringWithCString:encoding encoding:NSASCIIStringEncoding];
}

- (NSString*)stringInPDFObject:(CGPDFObjectRef)object
{
    bool    result;
    
    // PDFオブジェクトタイプの取得
    CGPDFObjectType type;
    type = CGPDFObjectGetType(object);
    
    // タイプ別による処理
    switch (type) {
            // PDF文字列の場合
        case kCGPDFObjectTypeString: {
            // PDF文字列の取得
            CGPDFStringRef  string;
            result = CGPDFObjectGetValue(object, type, &string);
            if (!result) {
                return nil;
            }
/*
            // MacRomanEcodingの場合
            if ([_encoding isEqualToString:@"MacRomanEncoding"]) {
                // CGPDFStringからNSStringへの変換
                NSString*   nsstring;
                nsstring = (NSString*)CFBridgingRelease(CGPDFStringCopyTextString(string));
                return nsstring;
            }
*/            
            // Identity-Hの場合
            if ([_encoding isEqualToString:@"Identity-H"]) {
                // バッファの作成
                NSMutableString*    buffer;
                buffer = [NSMutableString string];
                
                // バイトのポインタを取得
                const unsigned char*    tmp;
                tmp = CGPDFStringGetBytePtr(string);
                
                // NSStringへの変換
                int i;
                for (i = 0; i < CGPDFStringGetLength(string) / 2; i++) {
                    // CIDを取得
                    uint16_t    cid;
                    cid = *tmp++ << 8;
                    cid |= *tmp++;
                    
                    // CIDをunicharへ変換
                    unichar c;
                    c = unicharWithGlyph(cid);
                    if (c == 0) {
                        break;
                    }
                    
                    // NSStringへ変換して追加
                    NSString*   nsstring;
                    nsstring = [NSString stringWithCharacters:&c length:1];
                    if (nsstring) {
                        [buffer appendString:nsstring];
                    }
                }
                
                return buffer;
            }
            return nil;
        }
            
            // PDF配列の場合
        case kCGPDFObjectTypeArray: {
            // PDF配列の取得
            CGPDFArrayRef   array;
            result = CGPDFObjectGetValue(object, type, &array);
            if (!result) {
                return nil;
            }
            
            // バッファの作成
            NSMutableString*    buffer;
            buffer = [NSMutableString string];
            
            size_t  count;
            count = CGPDFArrayGetCount(array);
            
            // PDF配列の中身の取得
            int i;
            for (i = 0; i < count; i++) {
                // PDF配列からオブジェクトを取得
                CGPDFObjectRef  child;
                CGPDFArrayGetObject(array, i, &child);
                
                // テキストの抽出
                NSString*   nsstring;
                nsstring = [self stringInPDFObject:child];
                if (nsstring) {
                    [buffer appendString:nsstring];
                }
            }
            
            return buffer;
        }
            
        default: {
            return nil;
        }
    }
    
    return nil;
}

-(void)makeDataWithString:(NSString *)string {
    
    if ([section isEqualToString:@""]) {
        section = @"Summery";
        stage = @"LOG";
        tempNo = 0;
    } else if ([string isEqualToString:@"TTL RSV"]) {
        section = @"Fuel&WT";
        stage = @"TTL RSV";
        tempNo = 0;
    } else if ([string isEqualToString:@"T/O ALTN"]) {
        section = @"ALTN";
        stage = @"ALTN APO4";
        tempNo = 0;
    } else if ([string isEqualToString:@"SCENARIO"]) {
        section = @"SCENARIO";
        stage = @"";
        tempNo = 0;
    } else if ([string isEqualToString:@"FUEL COR/"]){
        section = @"Remarks";
        stage = @"Fuel Correction Factor";
        tempNo = 0;
    } else if ([string isEqualToString:@"LICENSE"]){
        section = @"Signature";
        stage = @"Dispatcher";
        tempNo = 0;
    } else if ([string hasPrefix:@"(FPL-"]) {
        section = @"ATC PLAN";
        stage = @"ATC Flight Number";
        tempNo = 0;
    } else if ([string isEqualToString:@"ALTERNATE"]) {
        section = @"RALT";
        stage = @"RALT APO4";
        tempNo = 0;
    } else if ([string isEqualToString:@"ETP APT"]) {
        section = @"ETP";
        stage = @"start";
        tempNo = 0;
    } else if ([string isEqualToString:@"W/T"]) {
        if (![section isEqualToString:@"ALTN-NAVLOG"]) {
            section = @"NAVLOG";
            stage = @"title";
            tempNo = 0;
        }
    } else if ([string isEqualToString:@"ALTN-1 NAVLOG"] && !altnNavlogExist) {
        
        dataPackage.planArray = planArray;
        
        planArray = [NSMutableArray new];
        
        section = @"ALTN-NAVLOG";
        stage = @"title";
        tempNo = 0;
        altnNavlogExist = true;//ALTN NAVLOGが２ページ以上になった場合、毎ページ先頭にALTN-1 NAVLOGが表示される
    } else if ([string isEqualToString:@"WINDS/TEMPERATURES ALOFT FORECAST"]) {
        
        dataPackage.divertPlanArray = planArray;
        planArray = [NSMutableArray new];
        
        section = @"WindTemp";
        stage = @"";
        tempNo = 0;
    }
    
    
    if ([section isEqualToString:@"Summery"]) {
        
        [self summeryWithString:string];
        
    } else if ([section isEqualToString:@"Fuel&WT"]) {
        
        [self fuelAndWTWithString:string];
        
    } else if ([section isEqualToString:@"ALTN"]){
        
        [self ALTNWithString:string];
        
    } else if ([section isEqualToString:@"SCENARIO"]){
        
        [self scenarioWithString:string];
        
    } else if ([section isEqualToString:@"Remarks"]){
        
        [self remarksWithString:string];
    
    } else if ([section isEqualToString:@"Signature"]){
        
        [self signatureWithString:(NSString *)string];
        
    } else if ([section isEqualToString:@"ATC PLAN"]){
        
        [self atcPlanWithString:(NSString *)string];
        
    } else if ([section isEqualToString:@"RALT"]){
        
        [self RALTWithString:(NSString *)string];
        
    } else if ([section isEqualToString:@"ETP"]) {
        
        [self ETPWithString:(NSString *)string];
        
    } else if ([section isEqualToString:@"NAVLOG"]){
        
        [self NAVLOGWithString:string];
        
    } else if ([section isEqualToString:@"ALTN-NAVLOG"]){
        
        [self divertNAVLOGWithString:string];
        
    } else if ([section isEqualToString:@"WindTemp"]){
        
        [self windTempWithString:(NSString *)string];
        
    }
    
    
}


-(void)summeryWithString:(NSString *)string {
    
    
    if ([stage isEqualToString:@"LOG"]) {
        if ([string hasPrefix:@"LOG"]) {
            dataPackage.otherData.logNumber = [string substringFromIndex:string.length - 3];
            stage = @"IssueTime";
            
        }
        return;
    }
    
    if ([stage isEqualToString:@"IssueTime"]) {
        if (string.length == 6) {
            [bufferString appendString:[string substringWithRange:NSMakeRange(2, 2)]];
            [bufferString appendString:@":"];
            [bufferString appendString:[string substringFromIndex:4]];
            [bufferString appendString:@" "];
            [bufferString appendString:[string substringToIndex:2]];
        } else if (string.length == 5) {
            [bufferString appendString:string];
            dataPackage.otherData.issueTime = bufferString;
            bufferString = [NSMutableString new];
            stage = @"DATE";
        }
        return;
    }
    
    
    if ([stage isEqualToString:@"DATE"]) {
        if ([string hasPrefix:@"DATE(UTC)"]) {
            //[string substringFromIndex:string.length - 5];
            //初期はこのデータがあったがなくなったのでコメントアウト
            stage = @"ETOPS";
            return;
        } else {
            stage = @"ETOPS";
        }
    }
    
    if ([stage isEqualToString:@"ETOPS"]) {
        if ([string isEqualToString:@"STD"]) {
            dataPackage.etopsData.ETOPS = @"NO";
            stage = @"Flight Number";
        } else {
            dataPackage.etopsData.ETOPS = [string substringWithRange:NSMakeRange(16, string.length - 17)];
            stage = @"Flight Number";
            return;
        }

    }
    
    if ([stage isEqualToString:@"Flight Number"]) {
        if (![string isEqualToString:@"STD"] && ![string isEqualToString:@"STA"] && ![string isEqualToString:@"BLK"]) {
            dataPackage.otherData.flightNumber = string;
            stage = @"Course";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Course"]) {
        
        if (tempNo == 2) {
            [bufferString appendString:@" "];
            [bufferString appendString:string];
            dataPackage.otherData.courseName = bufferString;
            bufferString = [NSMutableString new];
            tempNo = 0;
            stage = @"Aircraft Number";
            
        } else {
            [bufferString appendString:string];
            tempNo++;
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Aircraft Number"]) {
        dataPackage.otherData.aircraftNumber = string;
        stage = @"SELCAL";
        return;
    }
    
    if ([stage isEqualToString:@"SELCAL"]) {
        dataPackage.otherData.SELCAL = [string substringFromIndex:1];
        stage = @"STD";
        return;
    }
    
    if ([stage isEqualToString:@"STD"]) {
        dataPackage.otherData.STD = [string substringToIndex:4];
        stage = @"STA";
        return;
    }
    
    if ([stage isEqualToString:@"STA"]) {
        dataPackage.otherData.STA = [string substringToIndex:4];
        stage = @"BLK";
        return;
    }
    
    if ([stage isEqualToString:@"BLK"]) {
        dataPackage.otherData.blockTime = [string substringToIndex:5];
        stage = @"Time Margin";
        if ([[string substringFromIndex:string.length - 1] isEqualToString:@"+"]) {
            [bufferString appendString:@"+"];
        }
        return;
    }
    
    if ([stage isEqualToString:@"Time Margin"]) {
        [bufferString appendString:string];
        dataPackage.otherData.timeMargin = [bufferString copy];
        bufferString = [NSMutableString new];
        stage = @"FMCCourse";
        return;
    }
    
    if ([stage isEqualToString:@"FMCCourse"]) {
        if (string.length > 2) {
            dataPackage.otherData.FMCCourse = [string substringWithRange:NSMakeRange(1, string.length - 2)];
            stage = @"Aircraft Type";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Aircraft Type"]) {

        dataPackage.otherData.aircraftType = string;
        stage = @"PIC";

        return;
    }
    
    if ([stage isEqualToString:@"PIC"]) {
        if ([string hasPrefix:@"CAPT."]) {
            dataPackage.otherData.PIC = [string substringFromIndex:6];
            stage = @"Climb SPD";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Climb SPD"]) {
        dataPackage.otherData.climbSpeed = [string componentsSeparatedByString:@" "][0];
        stage = @"Cruise SPD";
        return;
    }
    
    if ([stage isEqualToString:@"Cruise SPD"]) {
        dataPackage.otherData.cruiseSpeed = string;
        stage = @"Descend SPD";
        return;
    }
    
    if ([stage isEqualToString:@"Descend SPD"]) {
        dataPackage.otherData.descendSpeed = string;
        stage = @"INT CRZ FL";
        return;
    }
    
    if ([stage isEqualToString:@"INT CRZ FL"]) {
        if (![string isEqualToString:@"INT CRZ FL"]) {
            dataPackage.otherData.initialFL = string;
            section = @"Fuel";
            stage = @"";
        }
        return;
    }

    
}

-(void)fuelAndWTWithString:(NSString *) string {
    
    if ([stage isEqualToString:@"TTL RSV"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.totalReserve = string;
            stage = @"MIN RSV";
        }
        return;
    }
    
    if ([stage isEqualToString:@"MIN RSV"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.minReserve = string;
            stage = @"STR LIMIT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"STR LIMIT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.weightData.structureLimit = string;
            stage = @"PLN ZFWT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"PLN ZFWT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.weightData.zeroFuel = string;
            stage = @"TIME To DEST";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME To DEST"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.dest.time = string;
            stage = @"Fuel To DEST";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel To DEST"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.dest.fuel = string;
            stage = @"T/O LIMIT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"T/O LIMIT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.weightData.takeoffLimit = string;
            stage = @"PLN TOWT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"PLN TOWT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.weightData.takeoff = string;
            stage = @"ALTN APO3";
        }
        return;
    }
    
    if ([stage isEqualToString:@"ALTN APO3"]) {
        dataPackage.alternateData.firstAPO3 = [string substringToIndex:3];
        dataPackage.alternateData.windFactorToFirstALTN = [string substringFromIndex:4];
        stage = @"TIME To ALTN";
        return;
    }
    
    if ([stage isEqualToString:@"TIME To ALTN"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.firstAlternate.time = string;
            stage = @"Fuel To ALTN";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel To ALTN"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.firstAlternate.fuel = string;
            stage = @"MAX L/DWT";
        }

        return;
    }
    
    if ([stage isEqualToString:@"MAX L/DWT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.weightData.maxLanding = string;
            stage = @"PLN L/DWT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"PLN L/DWT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.weightData.landing = string;
            stage = @"TIME Of Contingency";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of Contingency"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.contingency.time = string;
            stage = @"Fuel Of Contingency";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of Contingency"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.contingency.fuel = string;
            stage = @"Burn Off";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Burn Off"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            //string;//Fuel To DESTと同じなので省略
            stage = @"AVG TAS";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AVG TAS"]) {
        if (string.length == 3 && [PDFReader isDigit:string]) {
            dataPackage.otherData.averageTAS = string;
            stage = @"TIME Of Hold";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of Hold"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.hold.time = string;
            stage = @"Fuel Of Hold";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of Hold"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.hold.fuel = string;
            stage = @"L/D LIMIT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"L/D LIMIT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.weightData.landingLimit = string;
            stage = @"AVG WF";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AVG WF"]) {
        if (string.length == 4) {
            dataPackage.otherData.windFactor = string;
            stage = @"TIME Of EXTRA/S";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of EXTRA/S"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.extra_s.time = string;
            stage = @"Fuel Of EXTRA/S";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of EXTRA/S"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.extra_s.fuel = string;
            stage = @"MAX ZFWT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"MAX ZFWT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.weightData.maxZeroFuel = string;
            stage = @"AVG GS(kt)";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AVG GS(kt)"]) {
        if (string.length == 3) {
            dataPackage.otherData.GS_Kt = string;
            stage = @"AVG GS(MPH)";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AVG GS(MPH)"]) {
        if (string.length == 4) {
            dataPackage.otherData.GS_MPH = [string substringToIndex:3];
            stage = @"AVG GS(km/h)";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AVG GS(km/h)"]) {
        dataPackage.otherData.GS_KMH = string;
        stage = @"TIME Of EXTRA";
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of EXTRA"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.extra.time = string;
            stage = @"Fuel Of EXTRA";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of EXTRA"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.extra.fuel = string;
            stage = @"T/O Fuel";
        }
        return;
    }
    
    if ([stage isEqualToString:@"T/O Fuel"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            //dataDic[stage] = string;//のちに出てくるFuel Of T/Oと同じなので省略
            stage = @"GRND DIST";
        }
        return;
    }
    
    if ([stage isEqualToString:@"GRND DIST"]) {
        if (![string isEqualToString:@"GRD DIST"]) {
            dataPackage.otherData.groundDistance = string;
            stage = @"TIME Of EXTRA/E";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of EXTRA/E"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.extra_e.time = string;
            stage = @"Fuel Of EXTRA/E";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of EXTRA/E"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.extra_e.fuel = string;
            stage = @"Z/F LIMIT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Z/F LIMIT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.weightData.zeroFuelLimit = string;
            stage = @"AIR DIST";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AIR DIST"]) {
        if (![string isEqualToString:@"AIR DIST"]) {
            dataPackage.otherData.airDistance = string;
            stage = @"Unusable Fuel";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Unusable Fuel"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.unusable.fuel = string;
            stage = @"TIME Of T/O";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of T/O"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.takeoff.time = string;
            stage = @"Fuel Of T/O";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of T/O"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.takeoff.fuel = string;
            stage = @"TIME Of TAXIOUT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of TAXIOUT"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.taxiout.time = string;
            stage = @"Fuel Of TAXIOUT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of TAXIOUT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.taxiout.fuel = string;
            stage = @"MTXW-TAXI";
        }
        return;
    }
    
    if ([stage isEqualToString:@"MTXW-TAXI"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.weightData.MTXW_TAXI = string;
            stage = @"Fuel Of RAMP";
        } else if ([string isEqualToString:@"RAMP"]) {
            dataPackage.weightData.MTXW_TAXI = @"N/A";
            stage = @"Fuel Of RAMP";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of RAMP"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.ramp.fuel = string;
            stage = @"AGTW-PTOW";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AGTW-PTOW"]) {
        if (![string isEqualToString:@"AGTW-PTOW"]) {
            dataPackage.weightData.AGTOW_PTOW = string;
            stage = @"TIME Of TAXIIN";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of TAXIIN"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.taxiin.time = string;
            stage = @"T/O RWY";
        }
        return;
    }
    
    if ([stage isEqualToString:@"T/O RWY"]) {
        if (![string isEqualToString:@"T/O RWY:"]) {
            dataPackage.otherData.takeoffRunway = string;
            stage = @"L/D RWY";
        }
        return;
    }
    
    if ([stage isEqualToString:@"L/D RWY"]) {
        if (![string isEqualToString:@"L/D RWY:"]) {
            dataPackage.otherData.landingRunway = string;
            stage = @"2nd ALTN APO3";
        }
        return;
    }
    
    if ([stage isEqualToString:@"2nd ALTN APO3"]) {
        dataPackage.alternateData.secondAPO3 = [string substringToIndex:3];
        dataPackage.alternateData.windFactorToSecondALTN = [string substringFromIndex:4];
        stage = @"TIME To 2nd ALTN";
        return;
    }
    
    if ([stage isEqualToString:@"TIME To 2nd ALTN"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.secondAlternate.time = string;
            stage = @"Fuel To 2nd ALTN";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel To 2nd ALTN"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataPackage.fuelTimeData.secondAlternate.fuel = string;
            section = @"ALTN";
            stage = @"";
        }
        return;
    }

    
}

-(void)ALTNWithString:(NSString *)string {
    
    if ([stage isEqualToString:@"ALTN APO4"]) {
        if (string.length == 4) {
            dataPackage.alternateData.firstAPO4 = string;
            stage = @"FL To ALTN";
        }
        return;
    }
    
    if ([stage isEqualToString:@"FL To ALTN"]) {
        if (![string isEqualToString:@"FL/"]) {
            dataPackage.alternateData.FL = string;
            stage = @"Route To ALTN";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Route To ALTN"]) {
        
        if ([string isEqualToString:@"/"]){
            tempNo = 1;
            return;
        }
        
        if (tempNo != 1) {
            return;
        }
        
        if ([string hasSuffix:dataPackage.alternateData.firstAPO4]) {
            
            [bufferString appendString:string];
            dataPackage.alternateData.route = bufferString;
            bufferString = [NSMutableString new];
            
            tempNo = 0;
            section = @"Remarks";
            stage = @"";
            
        } else {
            [bufferString appendString:string];
            [bufferString appendString:@" "];
        }

        
        return;
    }

    
}

-(void)scenarioWithString:(NSString *)string {
    
    //未実装
    
    
}

-(void)remarksWithString:(NSString *)string {
    
    if ([stage isEqualToString:@"Fuel Correction Factor"]) {
        if (string.length == 1) {
            bufferString = [NSMutableString stringWithString:string];
            tempNo = 1;
        } else if (tempNo == 1){
            [bufferString appendString:string];
            dataPackage.otherData.fuelCorrectionFactor = [bufferString copy];
            bufferString = [NSMutableString new];
            
            tempNo = 0;
            stage = @"MAX T/O WT condition";
        }
        return;
    }
    
    if ([stage isEqualToString:@"MAX T/O WT condition"]) {
        
        if ([string hasPrefix:@"L/D"]) {
            
            dataPackage.weightData.maxLandingCondition = [string substringFromIndex:4];
            tempNo = 1;
            
        }
        
        if ([string hasPrefix:@"T/O"]) {
            
            dataPackage.weightData.maxTakeoffCondition = [string substringFromIndex:4];
            if (tempNo == 1) {
                tempNo = 0;
                stage = @"MEL";
            } else {
                stage = @"MAX L/D WT condition";
            }
        }
        return;
    }
    
    if ([stage isEqualToString:@"MAX L/D WT condition"]) {
        if ([string hasPrefix:@"L/D"]) {
            
            dataPackage.weightData.maxLandingCondition = [string substringFromIndex:4];
            tempNo = 0;
            stage = @"MEL";
        }
        return;
    }
    
    if ([stage isEqualToString:@"MEL"]) {
        
        if ([string isEqualToString:@"MEL"]) {
            tempNo = 1;
            return;
        }
        
        if (tempNo != 1) {
            return;
        }
        
        if ([string isEqualToString:@"ITEMS CONFIRMED BEFORE SIGN,"] || [string hasPrefix:dataPackage.otherData.flightNumber]) {
            dataPackage.otherData.MEL = [bufferString copy];
            bufferString = [NSMutableString new];

            tempNo = 0;
            section = @"Signature";
            stage = @"";
        } else {
            [bufferString appendString:string];
            [bufferString appendString:@"//"];
        }
        return;
    }

    
}


-(void)signatureWithString:(NSString *)string {
    
    if ([stage isEqualToString:@"Dispatcher"]) {
        if ([string isEqualToString:@"MENTAL AND PHYSICAL COND"]) {
            tempNo = 1;
            return;
        }
        
        if (tempNo != 1) {
            return;
        }
        
        dataPackage.otherData.dispatcher = string;

        tempNo = 0;
        stage = @"Dispatch Date";
        
        return;
    }
    
    if ([stage isEqualToString:@"Dispatch Date"]) {

        dataPackage.otherData.dispatchDate = string;
        stage = @"Dispatch Time";

        return;
    }
    
    if ([stage isEqualToString:@"Dispatch Time"]) {
       
        dataPackage.otherData.dispatchTime = string;
        section = @"ATC PLAN";
        stage = @"";

        return;
    }

    
}

-(void)atcPlanWithString:(NSString *)string {
    
    if ([stage isEqualToString:@"ATC Flight Number"]) {
        if (string.length != 0) {
            
            NSArray *strArray = [string componentsSeparatedByString:@"-"];
            
            dataPackage.atcData.aircraftID = strArray[1];
            dataPackage.atcData.flightRules = [strArray[2] substringToIndex:1];
            dataPackage.atcData.typeOfFlight = [strArray[2] substringFromIndex:1];
            
            stage = @"Aircraft & Equipment";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Aircraft & Equipment"]) {
        if (string.length != 0) {
            
            NSArray *strArray = [string componentsSeparatedByString:@"-"];
            
            NSString *firstStr = strArray[1];
            
            stage2 = @"ATC Number of aircraft";
            
            for (int i = 0; i < firstStr.length; i++) {
                NSString *letter = [firstStr substringWithRange:NSMakeRange(i, 1)];
                
                if ([stage2 isEqualToString:@"ATC Number of aircraft"]) {
                    if ([PDFReader isDigit:letter]) {
                        
                        [bufferString appendString:letter];
                        
                    } else {
                        
                        
                        if (bufferString.length == 0) {
                            dataPackage.atcData.numberOfAircraft = @"1";
                        } else {
                            dataPackage.atcData.numberOfAircraft = bufferString;
                        }
                        
                        bufferString = [NSMutableString stringWithString:letter];
                        stage2 = @"ATC Type of aircraft";
                        
                    }
                } else if ([stage2 isEqualToString:@"ATC Type of aircraft"]) {
                    
                    if ([letter isEqualToString:@"/"]) {
                        dataPackage.atcData.typeOfAircraft = bufferString;
                        bufferString = [NSMutableString new];
                        stage2 = @"ATC Wake turbulence category";
                    } else {
                        [bufferString appendString:letter];
                    }
                    
                } else if ([stage2 isEqualToString:@"ATC Wake turbulence category"]) {
                    
                    dataPackage.atcData.wakeCategory = letter;
                    
                }
                
            }
            
            NSArray *equipArray = [strArray[2] componentsSeparatedByString:@"/"];
            
            dataPackage.atcData.COMNAVEquip = equipArray[0];
            dataPackage.atcData.surveillanceEquip = equipArray[1];
            
            stage = @"Departure";
            stage2 = @"";
            
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Departure"]) {
        if (string.length != 0) {
            
            dataPackage.atcData.depAPO4 = [string substringWithRange:NSMakeRange(1, 4)];
            dataPackage.atcData.depTime = [string substringFromIndex:5];
            
            stage = @"ATC Route";
        }
        return;
    }
    
    if ([stage isEqualToString:@"ATC Route"]) {
        
        if ([string hasPrefix:@"-"]) {
            if (bufferString.length == 0) {
                [bufferString appendString:[string substringFromIndex:1]];
                [bufferString appendString:@" "];
                return;
            } else {
                dataPackage.atcData.speedLevelRoute = [bufferString substringToIndex:bufferString.length - 1];
                bufferString = [NSMutableString new];
                
                stage = @"Arrival";
            }
        } else {
            [bufferString appendString:string];
            [bufferString appendString:@" "];
            return;
        }

    }
    
    if ([stage isEqualToString:@"Arrival"]) {
        
        dataPackage.atcData.arrAPO4 = [string substringWithRange:NSMakeRange(1, 4)];
        dataPackage.atcData.elapsedTime = [string substringWithRange:NSMakeRange(5, 4)];
        
        if (string.length == 9) {
            dataPackage.atcData.firstAlternateAPO4 = @"";
            dataPackage.atcData.secondAlternateAPO4 = @"";
        } else if (string.length == 14) {
            dataPackage.atcData.firstAlternateAPO4 = [string substringWithRange:NSMakeRange(10, 4)];
            dataPackage.atcData.secondAlternateAPO4 = @"";
        } else if (string.length == 19) {
            dataPackage.atcData.firstAlternateAPO4 = [string substringWithRange:NSMakeRange(10, 4)];
            dataPackage.atcData.secondAlternateAPO4 = [string substringWithRange:NSMakeRange(15, 4)];
        }

        stage  = @"ATC Other Information";
        
        return;
    }
    
    if ([stage isEqualToString:@"ATC Other Information"]) {
        
        if ([string hasPrefix:@"-"]) {
            if (bufferString.length == 0) {
                [bufferString appendString:[string substringFromIndex:1]];
                [bufferString appendString:@" "];
                return;
            } else {
                
                NSString *ATCOtherInfo = [bufferString substringToIndex:bufferString.length - 1];
//                dataDic[stage] = [bufferString substringToIndex:bufferString.length - 1];
                bufferString = [NSMutableString new];
                
                if ([ATCOtherInfo isEqualToString:@"0"]) {
                    
                    dataPackage.atcData.otherInfoExist = NO;
                    
                } else {
                    
                    dataPackage.atcData.otherInfoExist = YES;
                
                    NSArray *otherInfoArray = [ATCOtherInfo componentsSeparatedByString:@" "];
                    
                    NSString *titleString = @"";
                    NSMutableString *mutableString = [NSMutableString new];
                    
                    
                    
                    for (NSString *string in otherInfoArray) {
                        
                        NSArray *slashedArray = [string componentsSeparatedByString:@"/"];
                        
                        
                        if (slashedArray.count == 1) {
                            
                            [mutableString appendString:@" "];
                            [mutableString appendString:slashedArray[0]];
                            
                        } else {
                            
                            if (![mutableString isEqualToString:@""]) {
                                
                                [dataPackage.atcData setValue:[mutableString copy] forKey:titleString];
                                
                            }
                            
                            titleString = slashedArray[0];
                            mutableString = [NSMutableString stringWithString:slashedArray[1]];
                            
                        }
                        
                    }
                    
                    if (![mutableString isEqualToString:@""]) {
                        
                        [dataPackage.atcData setValue:[mutableString copy] forKey:titleString];
                        
                    }
                    
                }

                
                
                stage = @"Supplementary Info";
                stage2 = @"ATC Endurance";
                
            }
        } else {
            [bufferString appendString:string];
            [bufferString appendString:@" "];
            return;
        }

    }
    
    if ([stage isEqualToString:@"Supplementary Info"]) {
        
        NSArray *strArray = [string componentsSeparatedByString:@" "];
        
        for (NSString *str in strArray) {
            if ([stage2 isEqualToString:@"ATC Endurance"]) {
                if ([str hasPrefix:@"-E/"]) {
                    dataPackage.atcData.endurance = [str substringFromIndex:3];
                    stage2 = @"ATC POB";
                }
                
                continue;
            }
            
            if ([stage2 isEqualToString:@"ATC POB"]) {
                
                
                if ([str hasPrefix:@"P/"]) {
                    dataPackage.atcData.POB = [str substringFromIndex:2];
                    stage2 = @"ATC Emergency Radio";
                    continue;
                } else {
                    dataPackage.atcData.POB = @"";
                    stage2 = @"ATC Emergency Radio";
                }
                
            }
            
            if ([stage2 isEqualToString:@"ATC Emergency Radio"]) {
                
                
                if ([str hasPrefix:@"R/"]) {
                    dataPackage.atcData.emergencyRadio = [str substringFromIndex:2];
                    stage2 = @"ATC Survival Equipment";
                    continue;
                } else {
                    dataPackage.atcData.emergencyRadio = @"";
                    stage2 = @"ATC Survival Equipment";
                }
                
            }
            
            if ([stage2 isEqualToString:@"ATC Survival Equipment"]) {
                
                
                if ([str hasPrefix:@"S/"]) {
                    dataPackage.atcData.survivalEquip = [str substringFromIndex:2];
                    stage2 = @"ATC Jackets";
                    continue;
                } else {
                    dataPackage.atcData.survivalEquip = @"";
                    stage2 = @"ATC Jackets";
                }
                
            }
            
            
            if ([stage2 isEqualToString:@"ATC Jackets"]) {
                
                
                if ([str hasPrefix:@"J/"]) {
                    dataPackage.atcData.jackets = [str substringFromIndex:2];
                    stage2 = @"ATC Number Of Dinghies";
                    continue;
                } else {
                    dataPackage.atcData.jackets = @"";
                    stage2 = @"ATC Number Of Dinghies";
                }
                
            }
            
            if ([stage2 isEqualToString:@"ATC Number Of Dinghies"]) {
                
                if ([str hasPrefix:@"D/"]) {
                    dataPackage.atcData.dinghiesNumber = [str substringFromIndex:2];
                    stage2 = @"ATC Dinghies Capacity";
                    continue;
                } else {
                    dataPackage.atcData.dinghiesNumber = @"";
                    dataPackage.atcData.dinghiesCapacity = @"";
                    dataPackage.atcData.dinghiesCover = @"";
                    dataPackage.atcData.dinghiesColor = @"";
                    stage2 = @"ATC Aircraft Color & Markings";
                }
                
                
            }
            
            if ([stage2 isEqualToString:@"ATC Dinghies Capacity"]) {
                
                dataPackage.atcData.dinghiesCapacity = str;
                stage2 = @"ATC Dinghies Cover";
                continue;
            }
            
            if ([stage2 isEqualToString:@"ATC Dinghies Cover"]) {
                
                
                if ([str isEqualToString:@"C"]) {
                    dataPackage.atcData.dinghiesCover = str;
                    stage2 = @"ATC Dinghies Color";
                    continue;
                } else {
                    dataPackage.atcData.dinghiesCover = @"";
                    stage2 = @"ATC Dinghies Color";
                }
                
            }
            
            if ([stage2 isEqualToString:@"ATC Dinghies Color"]) {
                
                dataPackage.atcData.dinghiesColor = str;
                
                stage2 = @"ATC Aircraft Color & Markings";
                continue;
            }
            
            if ([stage2 isEqualToString:@"ATC Aircraft Color & Markings"]) {
                
                if (bufferString.length == 0 && [str hasPrefix:@"A/"]) {
                    [bufferString appendString:[str substringFromIndex:2]];
                    [bufferString appendString:@" "];
                    continue;
                } else if ([str hasPrefix:@"N/"]){
                    if ([bufferString isEqualToString:@""]) {
                        dataPackage.atcData.aircraftColorMarking = @"";
                    } else {
                        dataPackage.atcData.aircraftColorMarking = [bufferString substringToIndex:bufferString.length - 1];
                    }
                    bufferString = [NSMutableString new];
                    
                    stage2 = @"ATC Remarks";
                    
                } else if ([str hasPrefix:@"C/"]){
                    if ([bufferString isEqualToString:@""]) {
                        dataPackage.atcData.aircraftColorMarking = @"";
                    } else {
                        dataPackage.atcData.aircraftColorMarking = [bufferString substringToIndex:bufferString.length - 1];
                    }
                    
                    bufferString = [NSMutableString new];
                    
                    dataPackage.atcData.remarks = @"";
                    
                    stage2 = @"ATC Captain";
                    
                } else {
                    
                    [bufferString appendString:str];
                    [bufferString appendString:@" "];
                    continue;
                }
                
            }
            
            if ([stage2 isEqualToString:@"ATC Remarks"]) {
                
                if (bufferString.length == 0 && [str hasPrefix:@"N/"]) {
                    [bufferString appendString:[str substringFromIndex:2]];
                    [bufferString appendString:@" "];
                    continue;
                } else if ([str hasPrefix:@"C/"]){
                    
                    if (![bufferString isEqualToString:@""]) {
                        dataPackage.atcData.remarks = [bufferString substringToIndex:bufferString.length - 1];
                    }
                    
                    bufferString = [NSMutableString new];
                    
                    stage2 = @"ATC Captain";
                    
                } else {
                    
                    [bufferString appendString:str];
                    [bufferString appendString:@" "];
                    continue;
                }
                
            }

            if ([stage2 isEqualToString:@"ATC Captain"]) {
                
                if (bufferString.length == 0 && [str hasPrefix:@"C/"]) {
                    
                    if ([str hasSuffix:@")"]) {
                        dataPackage.atcData.captain = [str substringWithRange:NSMakeRange(2, string.length - 3)];
                    } else {
                        [bufferString appendString:[str substringFromIndex:2]];
                        [bufferString appendString:@" "];
                    }
                    continue;
                } else if ([str hasSuffix:@")"]){
                    
                    [bufferString appendString:[str substringToIndex:str.length - 1]];
                    dataPackage.atcData.captain = [bufferString copy];
                    bufferString = [NSMutableString new];
                    
                    section = @"RALT";
                    stage = @"";
                    stage2 = @"";
                    return;
                    
                } else {
                    
                    [bufferString appendString:str];
                    [bufferString appendString:@" "];
                    continue;
                }
                
            }
            
        }

        
        return;
    }

    
}

-(void)RALTWithString:(NSString *)string{
    
    if ([stage isEqualToString:@"RALT APO4"]) {
        
        if (string.length == 4 && ![string isEqualToString:@"FROM"]) {
            raltData.APO4 = string;
            stage = @"RALT APO3";
            
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"RALT APO3"]) {
        
        if (string.length == 3) {
            raltData.APO3 = string;
            stage = @"Earliest Time Of RALT";
            
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Earliest Time Of RALT"]) {
        
        if (string.length == 5) {
            raltData.earliestTime = string;
            stage = @"Latest Time Of RALT";
            
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Latest Time Of RALT"]) {
        
        if (string.length == 5) {
            raltData.latestTime = string;
            stage = @"Apply Time Circle";
            
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Apply Time Circle"]) {
        
        if ([string hasSuffix:@"("]) {
            raltData.applyTimeCircle = [string substringToIndex:string.length - 1];
            stage = @"Actural Time Circle";

        } else {
        
            raltData.applyTimeCircle = string;
            raltData.actualTimeCircle = string;
            
            [RALTArray addObject:[raltData copy]];
            raltData = [[RALTData alloc] init];
            stage = @"RALT APO4";
            
        }

        return;
    }
    
    if ([stage isEqualToString:@"Actural Time Circle"]) {
        
        if (string.length == 2 || string.length == 3) {
            raltData.actualTimeCircle = string;
        }

        [RALTArray addObject:[raltData copy]];
        raltData = [[RALTData alloc] init];
        stage = @"RALT APO4";
        
        return;
    }

    
    
}

-(void)ETPWithString:(NSString *)string{
    
    if ([stage isEqualToString:@"start"]) {
        if (string.length == 3 && ![string isEqualToString:@"ETP"] && ![string isEqualToString:@"ETO"]) {
            [bufferString appendString:string];
            [bufferString appendString:@"/"];
            stage = @"ETP APO3s";
            
        }
        
        return;
        
    }
    
    if ([stage isEqualToString:@"ETP APO3s"]) {
        if (string.length == 3) {
            [bufferString appendString:string];
            etpDivertData.ETP_APO3s = [bufferString copy];
            bufferString = [NSMutableString new];
            stage = @"WF To ETP APOs";

        }
        
        return;
    }
    
    if ([stage isEqualToString:@"WF To ETP APOs"]) {
        if (string.length == 4) {
            
            if (bufferString.length == 0) {
                [bufferString appendString:string];
                [bufferString appendString:@"/"];
            } else {
                [bufferString appendString:string];
                etpDivertData.windFactor = [bufferString copy];
                bufferString = [NSMutableString new];
                stage = @"ETP";
            }
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"ETP"]) {
        etpDivertData.point = string;
        
        stage = @"Fuel At ETP";
        return;
    }
    
    if ([stage isEqualToString:@"Fuel At ETP"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            
            etpDivertData.ETPfuel = string;
            
            stage = @"ETO At ETP";
        }

        return;
    }
    
    if ([stage isEqualToString:@"ETO At ETP"]) {
        if (string.length == 5) {
            
            etpDivertData.ETPtime = string;
            
            stage = @"Time From ETP To RALT";
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Time From ETP To RALT"]) {
        if (string.length == 5) {
            
            etpDivertData.divertTime = string;
            
            stage = @"Fuel To RALT";
        }
        
        return;
    }

    if ([stage isEqualToString:@"Fuel To RALT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            
            etpDivertData.divertFuel = string;
            
            stage = @"Divert Calc Condition";
            
            etpDivertData.icingCondition = @"NO";
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Divert Calc Condition"]) {
        if (string.length == 1) {
            
            if ([string isEqualToString:@"X"]) {
                etpDivertData.icingCondition = @"YES";
            } else {
                etpDivertData.engineNumber = string;
                
                stage = @"Fuel Remain At RALT";
            }
        }
        
        return;
    }

    if ([stage isEqualToString:@"Fuel Remain At RALT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            
            etpDivertData.fuelRemain = string;

            [ETPDivertArray addObject:[etpDivertData copy]];
            etpDivertData = [[ETPDivertData alloc] init];
            
            stage = @"start";
        }
        
        return;
    }

}

-(void)NAVLOGWithString:(NSString *)string{
    
    [self makePlanArrayWithString:string];
    
    
    
}

-(void)divertNAVLOGWithString:(NSString *)string {
    
    [self makePlanArrayWithString:string];
    
}

-(void)windTempWithString:(NSString *)string {
    
    //未実装
    
}

-(void)makePlanArrayWithString:(NSString *)string {
    
    if ([stage isEqualToString:@"title"]) {
        if ([string isEqualToString:@"FRMNG"]) {
            if (planArray.count == 0) {
                
                legComps.Ewindtemp = @"";
                legComps.Awindtemp = @"";
                legComps.Awindtemp = @"";
                legComps.PFL = @"";
                legComps.AFL = @"";
                stage = @"TC";
            } else {
                stage = @"WindDir";
            }
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"WindDir"]) {
        if (![PDFReader isDigit:string]) {
            stage = @"title";
            return;
        }
        [bufferString appendString:string];
        [bufferString appendString:@"/"];
        stage = @"WindVel";
        return;
    }
    
    if ([stage isEqualToString:@"WindVel"]) {
        [bufferString appendString:string];
        [bufferString appendString:@" "];
        stage = @"Temp";
        return;
    }
    
    if ([stage isEqualToString:@"Temp"]) {
        [bufferString appendString:string];
        legComps.Ewindtemp = bufferString;
        bufferString = [NSMutableString new];
        legComps.Awindtemp = @"";
        stage = @"FL";
        return;
    }
    
    if ([stage isEqualToString:@"FL"]) {
        legComps.PFL = string;
        legComps.AFL = @"";
        stage = @"TC";
        return;
    }
    
    if ([stage isEqualToString:@"TC"]) {
        legComps.TC = string;
        stage = @"MC";
        return;
    }
    
    if ([stage isEqualToString:@"MC"]) {
        legComps.MC = string;
        stage = @"waypoint";
        return;
    }
    
    if ([stage isEqualToString:@"waypoint"]) {
        if([bufferString isEqualToString:@""]) {
            [bufferString appendString:string];
            
        }else if ([PDFReader isLatitude:bufferString]){
            [bufferString appendString:@"||"];
            [bufferString appendString:string];
            if ([PDFReader isLongitude:string]) {
                legComps.waypoint = bufferString;
                bufferString = [NSMutableString new];
                stage = @"AWY";
            } else {
                stage = @"waypoint3";
            }
        }else if ([string isEqualToString:@"WPT"] && [bufferString isEqualToString:@"FIR"]) {
            
            legComps.waypoint = @"FIR||WPT";
            bufferString = [NSMutableString new];
            stage = @"AWY";
            
        }else {
            legComps.waypoint = bufferString;
            bufferString = [NSMutableString new];
            legComps.AWY = string;
            stage = @"FIR";
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"waypoint3"]) {
        
        [bufferString appendString:string];
        legComps.waypoint = bufferString;
        bufferString = [NSMutableString new];
        stage = @"AWY";
        return;
    }
    
    if ([stage isEqualToString:@"AWY"]) {
        legComps.AWY = string;
        stage = @"FIR";
        return;
    }
    
    if ([stage isEqualToString:@"FIR"]) {
        if ([PDFReader isLatitude:string]) {
            legComps.FIR = @"";
            legComps.latString = string;
            stage = @"lon";
        } else {
            legComps.FIR = string;
            stage = @"lat";
        }
        return;
    }
    
    if ([stage isEqualToString:@"lat"]) {
        legComps.latString = string;
        stage = @"lon";
        return;
    }
    
    if ([stage isEqualToString:@"lon"]) {
        legComps.lonString = string;
        stage = @"DST";
        return;
    }
    
    if ([stage isEqualToString:@"DST"]) {
        legComps.DST = string;
        stage = @"ZTM";
        return;
    }
    
    if ([stage isEqualToString:@"ZTM"]) {
        legComps.ZTM = string;
        legComps.ETO = @"";
        legComps.ETO2 = @"";
        legComps.ATO = @"";
        stage = @"CTM";
        return;
    }
    
    if ([stage isEqualToString:@"CTM"]) {
        legComps.CTM = string;
        stage = @"Efuel";
        return;
    }
    
    if ([stage isEqualToString:@"Efuel"]) {
        legComps.Efuel = string;
        legComps.Afuel = @"";
        
        [planArray addObject:[legComps copy]];

        stage = @"WindDir";
        return;
    }
    
}

+(BOOL)isLatitude:(NSString *)string
{
    if (string.length != 6) {
        return false;
    }
    
    if (![string hasPrefix:@"N"] && ![string hasPrefix:@"S"]) {
        return false;
    }
    
    if (![PDFReader isDigit:[string substringFromIndex:1]]) {
        return false;
    }
    return true;
}

+(BOOL)isLongitude:(NSString *)string
{
    if (string.length != 7) {
        return false;
    }
    
    if (![string hasPrefix:@"E"] && ![string hasPrefix:@"W"]) {
        return false;
    }
    
    if (![PDFReader isDigit:[string substringFromIndex:1]]) {
        return false;
    }

    return true;
}

+(BOOL)isDigit:(NSString *)text
{
    NSCharacterSet *digitCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    
    NSScanner *aScanner = [NSScanner localizedScannerWithString:text];
    [aScanner setCharactersToBeSkipped:nil];
    
    [aScanner scanCharactersFromSet:digitCharSet intoString:NULL];
    return [aScanner isAtEnd];
}

@end
