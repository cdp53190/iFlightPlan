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
    NSString *section,*stage;
    NSMutableDictionary *dataDic;
    NSMutableString *bufferString;
    int tempNo;
    NSMutableArray *planArray;
    NSMutableDictionary *planDic;
    
}

-(instancetype)init {
    if (self = [super init]) {
        
        dataDic = [NSMutableDictionary new];
        section = @"";
        stage = @"";
        bufferString = [NSMutableString new];
        tempNo = 0;
        planDic = [NSMutableDictionary new];
        planArray = [NSMutableArray new];
        
    }
    return self;
}

-(NSArray *)test {
    
    // PDFファイルのパスを取得
    NSString*   path;
    path = [[NSBundle mainBundle] pathForResource:@"292650" ofType:@"pdf"];
    
    // PDFドキュメントを作成
    CGPDFDocumentRef    document;
    document = CGPDFDocumentCreateWithURL((CFURLRef)[NSURL fileURLWithPath:path]);
    
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
//    NSLog(@"%@",dataDic);

    return planArray;

}

- (void)operatorTextScanned:(CGPDFScannerRef)scanner
{
    // PDFオブジェクトの取得
    CGPDFObjectRef  object;
    CGPDFScannerPopObject(scanner, &object);
    
    // テキストの抽出
    NSString*   string;
    string = [self stringInPDFObject:object];
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
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
    } else if ([string isEqualToString:@"TTLRSV"]) {
        section = @"Fuel&WT";
        stage = @"TTL RSV";
    } else if ([string isEqualToString:@"T/OALTN"]) {
        section = @"ALTN";
        stage = @"ALTN APO4";
    } else if ([string isEqualToString:@"FUELCOR/"]){
        section = @"Remarks";
        stage = @"Fuel Correction Factor";
    } else if ([string isEqualToString:@"ITEMSCONFIRMEDBEFORESIGN,"]){
        section = @"Signature";
        stage = @"Dispatcher";
    } else if ([string hasPrefix:@"(FPL-"]) {
        section = @"ATC PLAN";
        stage = @"ATC Flight Number";
    } else if ([string isEqualToString:@"ALTERNATE"]) {
        section = @"RALT";
        stage = @"RALT";
    } else if ([string isEqualToString:@"W/T"]) {
        if (![section isEqualToString:@"ALTN-NAVLOG"]) {
            section = @"NAVLOG";
            stage = @"title";
        }
    } else if ([string isEqualToString:@"ALTN-1NAVLOG"]) {
        
        
        
        section = @"ALTN-NAVLOG";
        stage = @"title";
    } else if ([string isEqualToString:@"WINDS/TEMPERATURESALOFTFORECAST"]) {
        section = @"WindTemp";
    }
    
    
    if ([section isEqualToString:@"Summery"]) {
        
        if ([stage isEqualToString:@"LOG"]) {
            
            dataDic[stage] = [string substringFromIndex:3];
            
            stage = @"IssueTime";
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
            dataDic[stage] = [string substringFromIndex:string.length - 5];
            stage = @"ETOPS";
            return;
        }
        
        if ([stage isEqualToString:@"ETOPS"]) {
            if ([string isEqualToString:@"STD"]) {
                dataDic[stage] = @"NO";
            } else {
                dataDic[stage] = [string substringWithRange:NSMakeRange(13, string.length - 14)];
            }
            
            stage = @"Flight Number";
            return;
            
        }
        
        if ([stage isEqualToString:@"Flight Number"]) {
            if (string.length != 3) {
                dataDic[stage] = string;
                stage = @"Course";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Course"]) {
            
            if (tempNo == 2) {
                dataDic[stage] = [NSString stringWithFormat:@"%@ %@",bufferString,string];
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
            stage = @"Margin";
            return;
        }

        if ([stage isEqualToString:@"Margin"]) {
            dataDic[stage] = [string substringToIndex:2];
            stage = @"FMCCourse";
            return;
        }
        
        if ([stage isEqualToString:@"FMCCourse"]) {
            if (string.length != 1) {
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
            NSMutableString *tempString = [NSMutableString stringWithString:[string substringFromIndex:5]];
            [tempString insertString:@" " atIndex:tempString.length - 2];
            dataDic[stage] = tempString;
            stage = @"Policy SPD";
            return;
        }
        
        if ([stage isEqualToString:@"Policy SPD"]) {
            dataDic[stage] = [string substringToIndex:string.length - 4];
            stage = @"CIV";
            return;
        }
        
        if ([stage isEqualToString:@"CIV"]) {
            dataDic[stage] = string;
            stage = @"AOM SPD";
            return;
        }
        
        if ([stage isEqualToString:@"AOM SPD"]) {
            dataDic[stage] = string;
            stage = @"INT CRZ FL";
            return;
        }
        
        if ([stage isEqualToString:@"INT CRZ FL"]) {
            if (![string isEqualToString:@"INTCRZFL"]) {
                dataDic[stage] = string;
                stage = @"TTL RSV";
                section = @"Fuel";
            }
            return;
        }
        

        
        
    } else if ([section isEqualToString:@"Fuel&WT"]) {
        
        
        if ([stage isEqualToString:@"TTL RSV"]) {
            if (string.length == 5) {
                dataDic[stage] = string;
                stage = @"MIN RSV";
            }
            return;
        }
        
        if ([stage isEqualToString:@"MIN RSV"]) {
            if (string.length == 5) {
                dataDic[stage] = string;
                stage = @"STR LIMIT";
            }
            return;
        }
        
        if ([stage isEqualToString:@"STR LIMIT"]) {
            if (string.length == 5) {
                dataDic[stage] = string;
                stage = @"PLN ZFWT";
            }
            return;
        }
        
        if ([stage isEqualToString:@"PLN ZFWT"]) {
            if (string.length == 5) {
                dataDic[stage] = string;
                stage = @"TIME To DEST";
            }
            return;
        }
        
        if ([stage isEqualToString:@"TIME To DEST"]) {
            if (string.length == 4) {
                dataDic[stage] = string;
                stage = @"Fuel To DEST";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Fuel To DEST"]) {
            dataDic[stage] = string;
            stage = @"T/O LIMIT";
            return;
        }

        if ([stage isEqualToString:@"T/O LIMIT"]) {
            if (string.length == 5) {
                dataDic[stage] = string;
                stage = @"PLN TOWT";
            }
            return;
        }

        if ([stage isEqualToString:@"PLN TOWT"]) {
            if (string.length == 5) {
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
            if (string.length == 4) {
                dataDic[stage] = string;
                stage = @"Fuel To ALTN";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Fuel To ALTN"]) {
            dataDic[stage] = string;
            stage = @"MAX LDGWT";
            return;
        }

        if ([stage isEqualToString:@"MAX LDGWT"]) {
            if (string.length == 5) {
                dataDic[stage] = string;
                stage = @"PLN LDGWT";
            }
            return;
        }
        
        if ([stage isEqualToString:@"PLN LDGWT"]) {
            if (string.length == 5) {
                dataDic[stage] = string;
                stage = @"TIME Of Contingency";
            }
            return;
        }
        
        if ([stage isEqualToString:@"TIME Of Contingency"]) {
            if (![string isEqualToString:@"CONT"]) {
                dataDic[stage] = string;
                stage = @"Fuel Of Contingency";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Fuel Of Contingency"]) {
            dataDic[stage] = string;
            stage = @"Burn Off";
            return;
        }

        if ([stage isEqualToString:@"Burn Off"]) {
            if (string.length == 5) {
                //dataDic[stage] = string;//Fuel To DESTと同じなので省略
                stage = @"AVG TAS";
            }
            return;
        }

        if ([stage isEqualToString:@"AVG TAS"]) {
            if (string.length == 3) {
                dataDic[stage] = string;
                stage = @"TIME Of Hold";
            }
            return;
        }
        
        if ([stage isEqualToString:@"TIME Of Hold"]) {
            if (![string isEqualToString:@"HOLD"]) {
                dataDic[stage] = string;
                stage = @"Fuel Of Hold";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Fuel Of Hold"]) {
            dataDic[stage] = string;
            stage = @"L/D LIMIT";
            return;
        }

        if ([stage isEqualToString:@"L/D LIMIT"]) {
            if (string.length == 5) {
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
            if (string.length == 4) {
                dataDic[stage] = string;
                stage = @"Fuel Of EXTRA/S";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Fuel Of EXTRA/S"]) {
            dataDic[stage] = string;
            stage = @"MAX ZFWT";
            return;
        }
        
        if ([stage isEqualToString:@"MAX ZFWT"]) {
            if (string.length == 5) {
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
            if (string.length == 4) {
                dataDic[stage] = string;
                stage = @"Fuel Of EXTRA";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Fuel Of EXTRA"]) {
            dataDic[stage] = string;
            stage = @"T/O Fuel";
            return;
        }

        if ([stage isEqualToString:@"T/O Fuel"]) {
            if (string.length == 5) {
                //dataDic[stage] = string;//のちに出てくるFuel Of T/Oと同じなので省略
                stage = @"GRND DIST";
            }
            return;
        }

        if ([stage isEqualToString:@"GRND DIST"]) {
            if (![string isEqualToString:@"GRDDIST"]) {
                dataDic[stage] = string;
                stage = @"TIME Of EXTRA/E";
            }
            return;
        }
        
        if ([stage isEqualToString:@"TIME Of EXTRA/E"]) {
            if (string.length == 4) {
                dataDic[stage] = string;
                stage = @"Fuel Of EXTRA/E";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Fuel Of EXTRA/E"]) {
            dataDic[stage] = string;
            stage = @"Z/F LIMIT";
            return;
        }

        if ([stage isEqualToString:@"Z/F LIMIT"]) {
            if (string.length == 5) {
                dataDic[stage] = string;
                stage = @"AIR DIST";
            }
            return;
        }

        if ([stage isEqualToString:@"AIR DIST"]) {
            if (![string isEqualToString:@"AIRDIST"]) {
                dataDic[stage] = string;
                stage = @"Unusable Fuel";
            }
            return;
        }

        if ([stage isEqualToString:@"Unusable Fuel"]) {
            if (string.length == 5) {
                dataDic[stage] = string;
                stage = @"TIME Of T/O";
            }
            return;
        }

        if ([stage isEqualToString:@"TIME Of T/O"]) {
            if (string.length == 4) {
                dataDic[stage] = string;
                stage = @"Fuel Of T/O";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Fuel Of T/O"]) {
            dataDic[stage] = string;
            stage = @"TIME Of TAXIOUT";
            return;
        }

        if ([stage isEqualToString:@"TIME Of TAXIOUT"]) {
            if (string.length == 4) {
                dataDic[stage] = string;
                stage = @"Fuel Of TAXIOUT";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Fuel Of TAXIOUT"]) {
            dataDic[stage] = string;
            stage = @"Fuel Of RAMP";
            return;
        }

        if ([stage isEqualToString:@"Fuel Of RAMP"]) {
            if (string.length == 5) {
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
            if (string.length == 4) {
                dataDic[stage] = string;
                stage = @"T/O RWY";
            }
            return;
        }

        if ([stage isEqualToString:@"T/O RWY"]) {
            if (![string isEqualToString:@"T/ORWY:"]) {
                dataDic[stage] = string;
                stage = @"L/D RWY";
            }
            return;
        }

        if ([stage isEqualToString:@"L/D RWY"]) {
            if (![string isEqualToString:@"L/DRWY:"]) {
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
            if (string.length == 4) {
                dataDic[stage] = string;
                stage = @"Fuel To 2nd ALTN";
            }
            return;
        }
        
        if ([stage isEqualToString:@"Fuel To 2nd ALTN"]) {
            dataDic[stage] = string;
            section = @"ALTN";
            stage = @"ALTN APO4";
            return;
        }

        
    } else if ([section isEqualToString:@"ALTN"]){
        
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
//いまここ
        
    } else if ([section isEqualToString:@"Remarks"]){
        
    } else if ([section isEqualToString:@"Signature"]){
        
    } else if ([section isEqualToString:@"ATC PLAN"]){
        
    } else if ([section isEqualToString:@"RALT"]){
        
    } else if ([section isEqualToString:@"NAVLOG"]){
        
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
        
        
    } else if ([section isEqualToString:@"ALTN-NAVLOG"]){
        
    } else if ([section isEqualToString:@"WindTemp"]){
        
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
    NSCharacterSet *digitCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    NSScanner *aScanner = [NSScanner localizedScannerWithString:text];
    [aScanner setCharactersToBeSkipped:nil];
    
    [aScanner scanCharactersFromSet:digitCharSet intoString:NULL];
    return [aScanner isAtEnd];
}

@end
