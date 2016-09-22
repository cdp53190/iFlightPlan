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

void operator_Text(
                   CGPDFScannerRef scanner,
                   void* info)
{
    [(__bridge PDFReader*)info operatorTextScanned:scanner];
}



@implementation PDFReader

{
    NSMutableString *_text;
}
/*
-(void)test {
    
    
    
    
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // This should be our documents directory
    NSString *saveDirectory = [documentPath objectAtIndex:0];
    // Our PDF is named 'Example.pdf'
    NSString *saveFileName = @"ourPDF";
    // Create the full path using our saveDirectory and saveFileName
    NSString *finalPath = [saveDirectory stringByAppendingPathComponent:saveFileName];
    // Set the pdfUrl to our finalPath
    NSURL *pdfUrl = [NSURL fileURLWithPath:finalPath];
    
    
    CGPDFDocumentRef *document = CGPDFDocumentCreateWithURL(pdfUrl);
    
    CGPDFStringRef string;
    CGPDFDictionaryRef infoDict;
    
    infoDict = CGPDFDocumentGetInfo(document);
    if (CGPDFDictionaryGetString(infoDict, "Keywords", &string));
    CFStringRef s;
    
    s = CGPDFStringCopyTextString(string);
    if (s != NULL) {
        //need something in here in case it cant find anything
        NSLog(@"%@ testing it", s);}
              CFRelease(s);
    
    
}*/

-(void)test {
    
    // PDFファイルのパスを取得
    NSString*   path;
    path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"pdf"];
    
    // PDFドキュメントを作成
    CGPDFDocumentRef    document;
    document = CGPDFDocumentCreateWithURL((CFURLRef)[NSURL fileURLWithPath:path]);
    
    // PDFページを取得
    CGPDFPageRef    page;
    page = CGPDFDocumentGetPage(document, 1);
    
    // PDFコンテントストリームを取得
    CGPDFContentStreamRef _stream = CGPDFContentStreamCreateWithPage(page);
    
    // PDFオペレータテーブルを作成
    CGPDFOperatorTableRef   table;
    table = CGPDFOperatorTableCreate();
    CGPDFOperatorTableSetCallback(table, "TJ", operator_Text);
    CGPDFOperatorTableSetCallback(table, "Tj", operator_Text);
    
    // PDFスキャナを作成
    CGPDFScannerRef scanner;
    scanner = CGPDFScannerCreate(_stream, table, (__bridge void * _Nullable)(self));
    
    // スキャンを開始
    _text = [NSMutableString string];
    CGPDFScannerScan(scanner);
    
    // オブジェクトの解放
    CGPDFScannerRelease(scanner), scanner = NULL;
    CGPDFOperatorTableRelease(table), table = NULL;
    CGPDFContentStreamRelease(_stream), _stream = NULL;
    CGPDFDocumentRelease(document), document = NULL;

}

- (void)operatorTextScanned:(CGPDFScannerRef)scanner
{
    // PDFオブジェクトの取得
    CGPDFObjectRef  object;
    CGPDFScannerPopObject(scanner, &object);
    
    // テキストの抽出
    NSString*   string;
    string = [self stringInPDFObject:object];
    
    // テキストの追加
    if (string) {
        [_text appendString:string];
        [_text appendString:@"\n"];
    }
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
            
            // CGPDFStringからNSStringへの変換
            NSString*   nsstring;
            nsstring = (NSString*)CFBridgingRelease(CGPDFStringCopyTextString(string));
            
            return nsstring;
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
            
        default:{
            return nil;
        }
            
            
    }
    
    return nil;
}


@end
