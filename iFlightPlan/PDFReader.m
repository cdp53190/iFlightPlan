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
    NSMutableDictionary *dataDic;
    NSMutableString *bufferString;
    int tempNo;
    NSMutableArray *planArray;
    NSMutableDictionary *planDic;
    //bool spaceRemain;
    
}

-(instancetype)init {
    if (self = [super init]) {
        
        dataDic = [NSMutableDictionary new];
        section = @"";
        stage = @"";
        stage2 = @"";
        bufferString = [NSMutableString new];
        tempNo = 0;
        planDic = [NSMutableDictionary new];
        planArray = [NSMutableArray new];
    }
    return self;
}



-(void)testWithPathString:(NSString *)path {
    
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
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dataDic forKey:@"dataDic"];
    [userDefaults synchronize];

    //1分ごとのcourseArray作り
    NSArray *courseArray = [CourseCalc makeCourseArray];
    [userDefaults setObject:courseArray forKey:@"courseArray"];
    [userDefaults synchronize];

    //sunMoonPlanArray作り
    NSArray *sunMoonPlanArray = [SunMoon makeInitialSunMoonPlanArray];
    [userDefaults setObject:sunMoonPlanArray forKey:@"sunMoonPlanArray"];
    [userDefaults synchronize];
    
    //NSLog(@"%@",bufferString);
    
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
/*    if (spaceRemain == YES) {
        string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    } else {
        string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    }*/

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
    } else if ([string isEqualToString:@"ALTN-1 NAVLOG"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:planArray forKey:@"planArray"];
        [userDefaults synchronize];
        planArray = [NSMutableArray new];
        
        section = @"ALTN-NAVLOG";
        stage = @"title";
        tempNo = 0;
    } else if ([string isEqualToString:@"WINDS/TEMPERATURES ALOFT FORECAST"]) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:planArray forKey:@"divertPlanArray"];
        [userDefaults synchronize];
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
            dataDic[stage] = [string substringFromIndex:string.length - 3];
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
            dataDic[stage] = bufferString;
            bufferString = [NSMutableString new];
            stage = @"DATE";
        }
        return;
    }
    
    if ([stage isEqualToString:@"DATE"]) {
        if ([string hasPrefix:@"DATE(UTC)"]) {
            dataDic[stage] = [string substringFromIndex:string.length - 5];
            stage = @"ETOPS";
            return;
        } else {
            stage = @"ETOPS";
        }
    }
    
    if ([stage isEqualToString:@"ETOPS"]) {
        if ([string isEqualToString:@"STD"]) {
            dataDic[stage] = @"NO";
            stage = @"Flight Number";
        } else {
            dataDic[stage] = [string substringWithRange:NSMakeRange(16, string.length - 17)];
            stage = @"Flight Number";
            return;
        }

    }
    
    if ([stage isEqualToString:@"Flight Number"]) {
        if (![string isEqualToString:@"STD"] && ![string isEqualToString:@"STA"] && ![string isEqualToString:@"BLK"]) {
            dataDic[stage] = string;
            stage = @"Course";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Course"]) {
        
        if (tempNo == 2) {
            [bufferString appendString:@" "];
            [bufferString appendString:string];
            dataDic[stage] = bufferString;
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
        dataDic[@"Aircraft Number"] = string;
        stage = @"SELCAL";
        return;
    }
    
    if ([stage isEqualToString:@"SELCAL"]) {
        dataDic[stage] = [string substringFromIndex:1];
        stage = @"STD";
        return;
    }
    
    if ([stage isEqualToString:@"STD"]) {
        dataDic[stage] = [string substringToIndex:4];
        stage = @"STA";
        return;
    }
    
    if ([stage isEqualToString:@"STA"]) {
        dataDic[stage] = [string substringToIndex:4];
        stage = @"BLK";
        return;
    }
    
    if ([stage isEqualToString:@"BLK"]) {
        dataDic[stage] = [string substringToIndex:5];
        stage = @"Time Margin";
        [bufferString appendString:[string substringFromIndex:string.length - 1]];
        return;
    }
    
    if ([stage isEqualToString:@"Time Margin"]) {
        [bufferString appendString:string];
        dataDic[stage] = [bufferString copy];
        bufferString = [NSMutableString new];
        stage = @"FMCCourse";
        return;
    }
    
    if ([stage isEqualToString:@"FMCCourse"]) {
        if (string.length > 2) {
            dataDic[stage] = [string substringWithRange:NSMakeRange(1, string.length - 2)];
            stage = @"Aircraft Type";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Aircraft Type"]) {

        dataDic[stage] = string;
        stage = @"PIC";

        return;
    }
    
    if ([stage isEqualToString:@"PIC"]) {
        if ([string hasPrefix:@"CAPT."]) {
            dataDic[stage] = [string substringFromIndex:6];
            stage = @"Climb SPD";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Climb SPD"]) {
        dataDic[stage] = [string componentsSeparatedByString:@" "][0];
        stage = @"Cruise SPD";
        return;
    }
    
    if ([stage isEqualToString:@"Cruise SPD"]) {
        dataDic[stage] = string;
        stage = @"Descend SPD";
        return;
    }
    
    if ([stage isEqualToString:@"Descend SPD"]) {
        dataDic[stage] = string;
        stage = @"INT CRZ FL";
        return;
    }
    
    if ([stage isEqualToString:@"INT CRZ FL"]) {
        if (![string isEqualToString:@"INT CRZ FL"]) {
            dataDic[stage] = string;
            section = @"Fuel";
            stage = @"";
        }
        return;
    }

    
}

-(void)fuelAndWTWithString:(NSString *) string {
    
    if ([stage isEqualToString:@"TTL RSV"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"MIN RSV";
        }
        return;
    }
    
    if ([stage isEqualToString:@"MIN RSV"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"STR LIMIT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"STR LIMIT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"PLN ZFWT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"PLN ZFWT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"TIME To DEST";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME To DEST"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel To DEST";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel To DEST"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"T/O LIMIT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"T/O LIMIT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"PLN TOWT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"PLN TOWT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"ALTN APO3";
        }
        return;
    }
    
    if ([stage isEqualToString:@"ALTN APO3"]) {
        dataDic[stage] = [string substringToIndex:3];
        dataDic[@"WF To ALTN"] = [string substringFromIndex:4];
        stage = @"TIME To ALTN";
        return;
    }
    
    if ([stage isEqualToString:@"TIME To ALTN"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel To ALTN";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel To ALTN"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"MAX L/DWT";
        }

        return;
    }
    
    if ([stage isEqualToString:@"MAX L/DWT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"PLN L/DWT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"PLN L/DWT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"TIME Of Contingency";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of Contingency"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel Of Contingency";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of Contingency"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Burn Off";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Burn Off"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            //dataDic[stage] = string;//Fuel To DESTと同じなので省略
            stage = @"AVG TAS";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AVG TAS"]) {
        if (string.length == 3 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"TIME Of Hold";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of Hold"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel Of Hold";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of Hold"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"L/D LIMIT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"L/D LIMIT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"AVG WF";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AVG WF"]) {
        if (string.length == 4) {
            dataDic[stage] = string;
            stage = @"TIME Of EXTRA/S";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of EXTRA/S"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel Of EXTRA/S";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of EXTRA/S"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"MAX ZFWT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"MAX ZFWT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"AVG GS(kt)";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AVG GS(kt)"]) {
        if (string.length == 3) {
            dataDic[stage] = string;
            stage = @"AVG GS(MPH)";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AVG GS(MPH)"]) {
        if (string.length == 4) {
            dataDic[stage] = [string substringToIndex:3];
            stage = @"AVG GS(km/h)";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AVG GS(km/h)"]) {
        dataDic[stage] = string;
        stage = @"TIME Of EXTRA";
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of EXTRA"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel Of EXTRA";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of EXTRA"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
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
            dataDic[stage] = string;
            stage = @"TIME Of EXTRA/E";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of EXTRA/E"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel Of EXTRA/E";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of EXTRA/E"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Z/F LIMIT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Z/F LIMIT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"AIR DIST";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AIR DIST"]) {
        if (![string isEqualToString:@"AIR DIST"]) {
            dataDic[stage] = string;
            stage = @"Unusable Fuel";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Unusable Fuel"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"TIME Of T/O";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of T/O"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel Of T/O";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of T/O"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"TIME Of TAXIOUT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of TAXIOUT"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel Of TAXIOUT";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of TAXIOUT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel Of RAMP";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel Of RAMP"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"AGTW-PTOW";
        }
        return;
    }
    
    if ([stage isEqualToString:@"AGTW-PTOW"]) {
        if (![string isEqualToString:@"AGTW-PTOW"]) {
            dataDic[stage] = string;
            stage = @"TIME Of TAXIIN";
        }
        return;
    }
    
    if ([stage isEqualToString:@"TIME Of TAXIIN"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"T/O RWY";
        }
        return;
    }
    
    if ([stage isEqualToString:@"T/O RWY"]) {
        if (![string isEqualToString:@"T/O RWY:"]) {
            dataDic[stage] = string;
            stage = @"L/D RWY";
        }
        return;
    }
    
    if ([stage isEqualToString:@"L/D RWY"]) {
        if (![string isEqualToString:@"L/D RWY:"]) {
            dataDic[stage] = string;
            stage = @"2nd ALTN APO3";
        }
        return;
    }
    
    if ([stage isEqualToString:@"2nd ALTN APO3"]) {
        dataDic[stage] = [string substringToIndex:3];
        dataDic[@"WF To 2nd ALTN"] = [string substringFromIndex:4];
        stage = @"TIME To 2nd ALTN";
        return;
    }
    
    if ([stage isEqualToString:@"TIME To 2nd ALTN"]) {
        if (string.length == 4 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            stage = @"Fuel To 2nd ALTN";
        }
        return;
    }
    
    if ([stage isEqualToString:@"Fuel To 2nd ALTN"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            dataDic[stage] = string;
            section = @"ALTN";
            stage = @"";
        }
        return;
    }

    
}

-(void)ALTNWithString:(NSString *)string {
    
    if ([stage isEqualToString:@"ALTN APO4"]) {
        if (string.length == 4) {
            dataDic[stage] = string;
            stage = @"FL To ALTN";
        }
        return;
    }
    
    if ([stage isEqualToString:@"FL To ALTN"]) {
        if (![string isEqualToString:@"FL/"]) {
            dataDic[stage] = string;
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
        
        if ([string hasSuffix:dataDic[@"ALTN APO4"]]) {
            
            [bufferString appendString:string];
            dataDic[stage] = bufferString;
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
            dataDic[stage] = [bufferString copy];
            bufferString = [NSMutableString new];
            
            tempNo = 0;
            stage = @"MAX T/O WT condition";
        }
        return;
    }
    
    if ([stage isEqualToString:@"MAX T/O WT condition"]) {
        if ([string hasPrefix:@"T/O"]) {
            
            dataDic[stage] = [string substringFromIndex:4];
            stage = @"MAX L/D WT condition";
        }
        return;
    }
    
    if ([stage isEqualToString:@"MAX L/D WT condition"]) {
        if ([string hasPrefix:@"L/D"]) {
            
            dataDic[stage] = [string substringFromIndex:4];
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
        
        if ([string isEqualToString:@"ITEMS CONFIRMED BEFORE SIGN,"] || [string hasPrefix:dataDic[@"Flight Number"]]) {
            dataDic[stage] = [bufferString copy];
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
        if ([string isEqualToString:@"MENTAL AND PHSICAL COND"]) {
            tempNo = 1;
            return;
        }
        
        if (tempNo != 1) {
            return;
        }
        
        dataDic[stage] = string;

        tempNo = 0;
        stage = @"Dispatch Date";
        
        return;
    }
    
    if ([stage isEqualToString:@"Dispatch Date"]) {

        dataDic[stage] = string;
        stage = @"Dispatch Time";

        return;
    }
    
    if ([stage isEqualToString:@"Dispatch Time"]) {
       
        dataDic[stage] = string;
        section = @"ATC PLAN";
        stage = @"";

        return;
    }

    
}

-(void)atcPlanWithString:(NSString *)string {
    
    if ([stage isEqualToString:@"ATC Flight Number"]) {
        if (string.length != 0) {
            
            NSArray *strArray = [string componentsSeparatedByString:@"-"];
            
            dataDic[stage] = strArray[1];
            dataDic[@"ATC Flight rules"] = [strArray[2] substringToIndex:1];
            dataDic[@"ATC Type of flight"] = [strArray[2] substringFromIndex:1];
            
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
                            dataDic[stage2] = @"1";
                        } else {
                            dataDic[stage2] = bufferString;
                        }
                        
                        bufferString = [NSMutableString stringWithString:letter];
                        stage2 = @"ATC Type of aircraft";
                        
                    }
                } else if ([stage2 isEqualToString:@"ATC Type of aircraft"]) {
                    
                    if ([letter isEqualToString:@"/"]) {
                        dataDic[stage2] = bufferString;
                        bufferString = [NSMutableString new];
                        stage2 = @"ATC Wake turbulence category";
                    } else {
                        [bufferString appendString:letter];
                    }
                    
                } else if ([stage2 isEqualToString:@"ATC Wake turbulence category"]) {
                    
                    dataDic[stage2] = letter;
                    
                }
                
            }
            
            NSArray *equipArray = [strArray[2] componentsSeparatedByString:@"/"];
            
            dataDic[@"ATC COMNAV equipment"] = equipArray[0];
            dataDic[@"ATC Surveillance equipment"] = equipArray[1];
            
            stage = @"Departure";
            stage2 = @"";
            
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Departure"]) {
        if (string.length != 0) {
            
            dataDic[@"ATC Departure APO4"] = [string substringWithRange:NSMakeRange(1, 4)];
            dataDic[@"ATC Departure Time"] = [string substringFromIndex:5];
            
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
                dataDic[stage] = [bufferString substringToIndex:bufferString.length - 1];
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
        
        dataDic[@"ATC Arrival APO4"] = [string substringWithRange:NSMakeRange(1, 4)];
        dataDic[@"ATC Arrival Time"] = [string substringWithRange:NSMakeRange(5, 4)];
        
        if (string.length == 14) {
            dataDic[@"ATC ALTN APO4"] = [string substringWithRange:NSMakeRange(10, 4)];
            dataDic[@"ATC 2nd ALTN APO4"] = @"";
        } else if (string.length == 19) {
            dataDic[@"ATC ALTN APO4"] = [string substringWithRange:NSMakeRange(10, 4)];
            dataDic[@"ATC 2nd ALTN APO4"] = [string substringWithRange:NSMakeRange(15, 4)];
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
                
                dataDic[stage] = [bufferString substringToIndex:bufferString.length - 1];
                bufferString = [NSMutableString new];
                
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
                    dataDic[stage2] = [str substringFromIndex:3];
                    stage2 = @"ATC POB";
                }
                
                continue;
            }
            
            if ([stage2 isEqualToString:@"ATC POB"]) {
                
                
                if ([str hasPrefix:@"P/"]) {
                    dataDic[stage2] = [str substringFromIndex:2];
                    stage2 = @"ATC Emergency Radio";
                    continue;
                } else {
                    dataDic[stage2] = @"";
                    stage2 = @"ATC Emergency Radio";
                }
                
            }
            
            if ([stage2 isEqualToString:@"ATC Emergency Radio"]) {
                
                
                if ([str hasPrefix:@"R/"]) {
                    dataDic[stage2] = [str substringFromIndex:2];
                    stage2 = @"ATC Survival Equipment";
                    continue;
                } else {
                    dataDic[stage2] = @"";
                    stage2 = @"ATC Survival Equipment";
                }
                
            }
            
            if ([stage2 isEqualToString:@"ATC Survival Equipment"]) {
                
                
                if ([str hasPrefix:@"S/"]) {
                    dataDic[stage2] = [str substringFromIndex:2];
                    stage2 = @"ATC Jackets";
                    continue;
                } else {
                    dataDic[stage2] = @"";
                    stage2 = @"ATC Jackets";
                }
                
            }
            
            
            if ([stage2 isEqualToString:@"ATC Jackets"]) {
                
                
                if ([str hasPrefix:@"J/"]) {
                    dataDic[stage2] = [str substringFromIndex:2];
                    stage2 = @"ATC Number Of Dinghies";
                    continue;
                } else {
                    dataDic[stage2] = @"";
                    stage2 = @"ATC Number Of Dinghies";
                }
                
            }
            
            if ([stage2 isEqualToString:@"ATC Number Of Dinghies"]) {
                
                if ([str hasPrefix:@"D/"]) {
                    dataDic[stage2] = [str substringFromIndex:2];
                    stage2 = @"ATC Dinghies Capacity";
                    continue;
                } else {
                    dataDic[stage2] = @"";
                    dataDic[@"ATC Dinghies Capacity"] = @"";
                    dataDic[@"ATC Dinghies Cover"] = @"";
                    dataDic[@"ATC Dinghies Color"] = @"";
                    stage2 = @"ATC Aircraft Color & Markings";
                }
                
                
            }
            
            if ([stage2 isEqualToString:@"ATC Dinghies Capacity"]) {
                
                dataDic[stage2] = str;
                stage2 = @"ATC Dinghies Cover";
                continue;
            }
            
            if ([stage2 isEqualToString:@"ATC Dinghies Cover"]) {
                
                
                if ([str isEqualToString:@"C"]) {
                    dataDic[stage2] = str;
                    stage2 = @"ATC Dinghies Color";
                    continue;
                } else {
                    dataDic[stage2] = @"";
                    stage2 = @"ATC Dinghies Color";
                }
                
            }
            
            if ([stage2 isEqualToString:@"ATC Dinghies Color"]) {
                
                dataDic[stage2] = str;
                
                stage2 = @"ATC Aircraft Color & Markings";
                continue;
            }
            
            if ([stage2 isEqualToString:@"ATC Aircraft Color & Markings"]) {
                
                if (bufferString.length == 0 && [str hasPrefix:@"A/"]) {
                    [bufferString appendString:[str substringFromIndex:2]];
                    [bufferString appendString:@" "];
                    continue;
                } else if ([str hasPrefix:@"N/"]){
                    
                    dataDic[stage2] = [bufferString substringToIndex:bufferString.length - 1];
                    bufferString = [NSMutableString new];
                    
                    stage2 = @"ATC Remarks";
                    
                } else if ([str hasPrefix:@"C/"]){
                    
                    dataDic[stage2] = [bufferString substringToIndex:bufferString.length - 1];
                    bufferString = [NSMutableString new];
                    
                    dataDic[@"ATC Remarks"] = @"";
                    
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
                    
                    dataDic[stage2] = [bufferString substringToIndex:bufferString.length - 1];
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
                        dataDic[stage2] = [str substringWithRange:NSMakeRange(2, string.length - 3)];
                    } else {
                        [bufferString appendString:[str substringFromIndex:2]];
                        [bufferString appendString:@" "];
                    }
                    continue;
                } else if ([str hasSuffix:@")"]){
                    
                    [bufferString appendString:[str substringToIndex:str.length - 1]];
                    dataDic[stage2] = [bufferString copy];
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
            tempNo++;
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
            stage = @"RALT APO3";
            
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"RALT APO3"]) {
        
        if (string.length == 3) {
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
            stage = @"Earliest Time Of RALT";
            
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Earliest Time Of RALT"]) {
        
        if (string.length == 5) {
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
            stage = @"Latest Time Of RALT";
            
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Latest Time Of RALT"]) {
        
        if (string.length == 5) {
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
            stage = @"Apply Time Circle";
            
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Apply Time Circle"]) {
        
        if ([string hasSuffix:@"("]) {
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = [string substringToIndex:string.length - 1];
            stage = @"Actural Time Circle";

        } else {
        
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
            stage = @"RALT APO4";
            
        }

        return;
    }
    
    if ([stage isEqualToString:@"Actural Time Circle"]) {
        
        if (string.length == 2 || string.length == 3) {
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
        }

        stage = @"RALT APO4";
        
        return;
    }

    
    
}

-(void)ETPWithString:(NSString *)string{
    
    if ([stage isEqualToString:@"start"]) {
        if (string.length == 3 && ![string isEqualToString:@"ETP"] && ![string isEqualToString:@"ETO"]) {
            tempNo++;
            [bufferString appendString:string];
            [bufferString appendString:@"/"];
            stage = @"ETP APO3s";
            
        }
        
        return;
        
    }
    
    if ([stage isEqualToString:@"ETP APO3s"]) {
        if (string.length == 3) {
            [bufferString appendString:string];
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = [bufferString copy];
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
                dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = [bufferString copy];
                bufferString = [NSMutableString new];
                stage = @"ETP";
            }
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"ETP"]) {
        dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
        
        stage = @"Fuel At ETP";
        return;
    }
    
    if ([stage isEqualToString:@"Fuel At ETP"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
            
            stage = @"ETO At ETP";
        }

        return;
    }
    
    if ([stage isEqualToString:@"ETO At ETP"]) {
        if (string.length == 5) {
            
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
            
            stage = @"Time From ETP To RALT";
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Time From ETP To RALT"]) {
        if (string.length == 5) {
            
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
            
            stage = @"Fuel To RALT";
        }
        
        return;
    }

    if ([stage isEqualToString:@"Fuel To RALT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
            
            stage = @"Divert Calc Condition";
            dataDic[[NSString stringWithFormat:@"%@(Icing)-%d",stage,tempNo]] = @"NO";
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"Divert Calc Condition"]) {
        if (string.length == 1) {
            
            if ([string isEqualToString:@"X"]) {
                dataDic[[NSString stringWithFormat:@"%@(Icing)-%d",stage,tempNo]] = @"YES";
            } else {
                dataDic[[NSString stringWithFormat:@"%@(Engine)-%d",stage,tempNo]] = string;
                
                stage = @"Fuel Remain At RALT";
            }
        }
        
        return;
    }

    if ([stage isEqualToString:@"Fuel Remain At RALT"]) {
        if (string.length == 5 && [PDFReader isDigit:string]) {
            
            dataDic[[NSString stringWithFormat:@"%@-%d",stage,tempNo]] = string;
            
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
                
                [planDic setObject:@"" forKey:@"Ewindtemp"];
                [planDic setObject:@"" forKey:@"Awindtemp"];
                [planDic setObject:@"" forKey:@"PFL"];
                [planDic setObject:@"" forKey:@"AFL"];
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
        planDic[@"Ewindtemp"] = bufferString;
        bufferString = [NSMutableString new];
        planDic[@"Awindtemp"] = @"";
        stage = @"FL";
        return;
    }
    
    if ([stage isEqualToString:@"FL"]) {
        planDic[@"PFL"] = string;
        planDic[@"AFL"] = @"";
        stage = @"TC";
        return;
    }
    
    if ([stage isEqualToString:@"TC"]) {
        planDic[stage] = string;
        stage = @"MC";
        return;
    }
    
    if ([stage isEqualToString:@"MC"]) {
        planDic[stage] = string;
        stage = @"waypoint";
        return;
    }
    
    if ([stage isEqualToString:@"waypoint"]) {
        if([bufferString isEqualToString:@""]) {
            [bufferString appendString:string];
            
        }else if ([PDFReader isLongitude:string] && [PDFReader isLatitude:bufferString]){
            [bufferString appendString:@"||"];
            [bufferString appendString:string];
            planDic[stage] = bufferString;
            bufferString = [NSMutableString new];
            stage = @"AWY";
        }else if ([string isEqualToString:@"WPT"] && [bufferString isEqualToString:@"FIR"]) {
            
            planDic[stage] = @"FIR||WPT";
            bufferString = [NSMutableString new];
            stage = @"AWY";
            
        }else {
            planDic[stage] = bufferString;
            bufferString = [NSMutableString new];
            planDic[@"AWY"] = string;
            stage = @"FIR";
        }
        
        return;
    }
    
    if ([stage isEqualToString:@"AWY"]) {
        planDic[stage] = string;
        stage = @"FIR";
        return;
    }
    
    if ([stage isEqualToString:@"FIR"]) {
        if ([PDFReader isLatitude:string]) {
            planDic[stage] = @"";
            planDic[@"lat"] = string;
            stage = @"lon";
        } else {
            planDic[stage] = string;
            stage = @"lat";
        }
        return;
    }
    
    if ([stage isEqualToString:@"lat"]) {
        planDic[stage] = string;
        stage = @"lon";
        return;
    }
    
    if ([stage isEqualToString:@"lon"]) {
        planDic[stage] = string;
        stage = @"DST";
        return;
    }
    
    if ([stage isEqualToString:@"DST"]) {
        planDic[stage] = string;
        stage = @"ZTM";
        return;
    }
    
    if ([stage isEqualToString:@"ZTM"]) {
        planDic[stage] = string;
        planDic[@"ETO"] = @"";
        planDic[@"ATO"] = @"";
        stage = @"CTM";
        return;
    }
    
    if ([stage isEqualToString:@"CTM"]) {
        planDic[stage] = string;
        stage = @"Efuel";
        return;
    }
    
    if ([stage isEqualToString:@"Efuel"]) {
        planDic[stage] = string;
        planDic[@"Afuel"] = @"";
        
        [planArray addObject:planDic];
        
        planDic = [NSMutableDictionary new];
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
