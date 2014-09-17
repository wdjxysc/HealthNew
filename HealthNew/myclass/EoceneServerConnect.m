//  EoceneServerConnect.m
//  HME
//
//  Created by 夏 伟 on 13-12-31.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "EoceneServerConnect.h"
#import "XmlTool.h"
#import "MySingleton.h"

@implementation EoceneServerConnect : NSObject


//同步请求
+(NSData *)doSyncRequest:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//转化为正确格式的url
    NSLog(@"%@",urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20.0];
    
    NSHTTPURLResponse *response;
    NSError *error;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(error != nil)
    {
        NSLog(@"Error on load = %@", [error localizedDescription]);
        return nil;
    }
    
    if([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if(httpResponse.statusCode != 200)//200服务器返回网页成功
        {
            return nil;
        }
        
        NSLog(@"Headers: %@", [httpResponse allHeaderFields]);
    }
    
    return data;
}

//检查网络是否连接
+ (BOOL) isConnectionAvailable
{
    SCNetworkReachabilityFlags flags;
    BOOL receivedFlags;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [@"www.ebelter.com" UTF8String]);
    receivedFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    
    if (!receivedFlags || (flags == 0) )
    {
        return FALSE;
    } else {
        return TRUE;
    }
}

+(NSMutableString *)callXMLWebService:(NSString *)xmlstr urlString:(NSString *)urlString
{
    NSMutableString *s = [[NSMutableString alloc]init];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//转化为正确格式的url

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET1.png
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"" forHTTPHeaderField:@"SOAPAction"];
    NSData *data = [xmlstr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];

    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    [s appendString:str1];
    
    return s;
    
    
}

+(void)callXMLWebServiceGood:(NSString *)xmlstr urlString:(NSString *)urlString
{
    //初始化http请求,并自动内存释放
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSData *data = [xmlstr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    //同步返回请求，并获得返回数据
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //请求返回状态，如有中文无法发送请求，并且stausCode 值为 0
    NSLog(@"response code:%ld",(long)(int)[urlResponse statusCode]);
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        NSLog(@"response:%@",result);
    }
}

+(void) postxml:(NSString *)xmlstr urlString:(NSString *)urlString
{
    //prepar request
//    NSString *urlString = [NSString stringWithFormat:@"path"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<Request  Action=\"Login\">"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<Body>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<Username>wangjun</Username>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<Password>password</Password>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<PlatformID>2</PlatformID>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<PlatformVersion>3.1.3</PlatformVersion>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<TaskViewerName>IP 1.3</TaskViewerName>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<TaskViewerVersion>3</TaskViewerVersion>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"</Body>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"</Request>"] dataUsingEncoding:NSUTF8StringEncoding]];
    //<soapenv:Header/><soapenv:Body><ws:RegisterAccount soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><RegType>2</RegType><MeterSerial/><Username>cebupatient1</Username><Password>password</Password><Firstname/><Lastname/><DOB/><BPSerial/></ws:RegisterAccount></soapenv:Body></soapenv:Envelope>
    postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"https://ws.eocenesystems.com/\"><soapenv:Header/><soapenv:Body><ws:RegisterAccount soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><RegType>2</RegType><MeterSerial/><Username>cebupatient1</Username><Password>password</Password><Firstname/><Lastname/><DOB/><BPSerial/></ws:RegisterAccount></soapenv:Body></soapenv:Envelope>"] dataUsingEncoding:NSUTF8StringEncoding]];
    //post
    [request setHTTPBody:postBody];
    //get response
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response Code: %d", (int)[urlResponse statusCode]);
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        NSLog(@"Response: %@", result);
    }
}


+(NSString *)getRegXml :(NSString *)username password:(NSString *)password
{
    NSMutableString *str = [[NSMutableString alloc]init];
    //@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"https://ws.eocenesystems.com/\"><soapenv:Header/><soapenv:Body><ws:RegisterAccount soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><RegType>2</RegType><MeterSerial/><Username>cebupatient1</Username><Password>password</Password><Firstname/><Lastname/><DOB/><BPSerial/></ws:RegisterAccount></soapenv:Body></soapenv:Envelope>"
    
    [str appendFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"https://ws.eocenesystems.com/\"><soapenv:Header/><soapenv:Body><ws:RegisterAccount soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><RegType>2</RegType><MeterSerial/><Username>%@</Username><Password>%@</Password><Firstname/><Lastname/><DOB/><BPSerial/></ws:RegisterAccount></soapenv:Body></soapenv:Envelope>",username,password];
    
    return str;
}

+(NSString *)getRegDeviceXml :(NSString *)accountId	 deviceType:(NSString *)deviceType serialNo:(NSString *)serialNo
{
    NSMutableString *str = [[NSMutableString alloc]init];
    
    
    return str;
}

+(NSString *)getUploadBloodPressDataXml :(int)sys dia:(int)dia pulse:(int)pulse testtime:(NSDate *)testtime
{
    NSMutableString *str = [[NSMutableString alloc]init];
    
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *datestr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:testtime]];
    [dateFormatter setDateFormat:@"HHmmss"];
    NSString *timestr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:testtime]];
    //<?xml version="1.0" encoding="UTF-8" standalone="no"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><ns1:UploadData xmlns:ns1="http://ws.eocenesystems.com" soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><DeviceType xsi:type="xsd:biginteger">2</DeviceType><ReadingType xsi:type="xsd:biginteger">2</ReadingType><DeviceID xsi:type="xsd:string">0</DeviceID><UserID xsi:type="xsd:string">121</UserID><ReadingCount xsi:type="xsd:biginteger">2</ReadingCount><Readings xsi:type="xsd:string">R|20131222|103700|128|78|68|0|0|0|0|E,R|20131222|101800|118|76|72|0|0|0|0|E</Readings><PatientID>7410</PatientID></ns1:UploadData></soapenv:Body></soapenv:Envelope>
    [str appendFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><soapenv:Body><ns1:UploadData xmlns:ns1=\"http://ws.eocenesystems.com\" soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><DeviceType xsi:type=\"xsd:biginteger\">2</DeviceType><ReadingType xsi:type=\"xsd:biginteger\">2</ReadingType><DeviceID xsi:type=\"xsd:string\">0</DeviceID><UserID xsi:type=\"xsd:string\">121</UserID><ReadingCount xsi:type=\"xsd:biginteger\">1</ReadingCount><Readings xsi:type=\"xsd:string\">R|%@|%@|%d|%d|%d|0|0|0|0|E</Readings><PatientID>%@</PatientID></ns1:UploadData></soapenv:Body></soapenv:Envelope>",datestr,timestr,sys,dia,pulse,[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AccountID"]];
    
    return str;
}

+(NSString *)getUploadGlucoseDataXml :(int)glucose testtime:(NSDate *)testtime
{
    NSMutableString *str = [[NSMutableString alloc]init];
    
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *datestr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:testtime]];
    [dateFormatter setDateFormat:@"HHmmss"];
    NSString *timestr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:testtime]];
    //@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"><soapenv:Body><ns1:UploadData xmlns:ns1=\"http://ws.eocenesystems.com\" soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><DeviceType xsi:type=\"xsd:biginteger\">1</DeviceType><ReadingType xsi:type=\"xsd:biginteger\">1</ReadingType><DeviceID xsi:type=\"xsd:string\">0</DeviceID><UserID xsi:type=\"xsd:string\">121</UserID><ReadingCount xsi:type=\"xsd:biginteger\">1</ReadingCount><Readings xsi:type=\"xsd:string\">R|20131230|144010|115|000|000|0|0|0|0|E</Readings><PatientID>7410</PatientID></ns1:UploadData></soapenv:Body></soapenv:Envelope>"
    [str appendFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"><soapenv:Body><ns1:UploadData xmlns:ns1=\"http://ws.eocenesystems.com\" soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><DeviceType xsi:type=\"xsd:biginteger\">1</DeviceType><ReadingType xsi:type=\"xsd:biginteger\">1</ReadingType><DeviceID xsi:type=\"xsd:string\">0</DeviceID><UserID xsi:type=\"xsd:string\">121</UserID><ReadingCount xsi:type=\"xsd:biginteger\">1</ReadingCount><Readings xsi:type=\"xsd:string\">R|%@|%@|%d|000|000|0|0|0|0|E</Readings><PatientID>%@</PatientID></ns1:UploadData></soapenv:Body></soapenv:Envelope>",datestr,timestr,glucose,[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AccountID"]];
    
    return str;
}

+(NSString *)getUploadOxygenDataXml :(int)oxygen pulse:(int)pulse testtime:(NSDate *)testtime
{
    NSMutableString *str = [[NSMutableString alloc]init];
    
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *datestr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:testtime]];
    [dateFormatter setDateFormat:@"HHmmss"];
    NSString *timestr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:testtime]];
    //<?xml version="1.0" encoding="UTF-8" standalone="no"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><ns1:UploadData xmlns:ns1="http://ws.eocenesystems.com" soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><DeviceType xsi:type="xsd:biginteger">4</DeviceType><ReadingType xsi:type="xsd:biginteger">4</ReadingType><DeviceID xsi:type="xsd:string">0</DeviceID><UserID xsi:type="xsd:string">121</UserID><ReadingCount xsi:type="xsd:biginteger">2</ReadingCount><Readings xsi:type="xsd:string">R|20131222|104400|138|43|000|0|0|0|0|E,R|20131222|105300|158|32|000|0|0|0|0|E</Readings><PatientID>7410</PatientID></ns1:UploadData></soapenv:Body></soapenv:Envelope>
    [str appendFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><soapenv:Body><ns1:UploadData xmlns:ns1=\"http://ws.eocenesystems.com\" soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><DeviceType xsi:type=\"xsd:biginteger\">4</DeviceType><ReadingType xsi:type=\"xsd:biginteger\">4</ReadingType><DeviceID xsi:type=\"xsd:string\">0</DeviceID><UserID xsi:type=\"xsd:string\">121</UserID><ReadingCount xsi:type=\"xsd:biginteger\">1</ReadingCount><Readings xsi:type=\"xsd:string\">R|%@|%@|%d|%d|000|0|0|0|0|E</Readings><PatientID>%@</PatientID></ns1:UploadData></soapenv:Body></soapenv:Envelope>",datestr,timestr,oxygen,pulse,[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AccountID"]];
    
    return str;
}

+(BOOL)uploadWeightData :(double)weight testtime :(NSDate *)testtime
{
    bool b = false;
    
    
    
    return b;
}

+(BOOL)uploadGlucoseData :(int)glucose testtime:(NSDate *)testtime
{
    bool b = false;
    
    NSString *xml = [self getUploadGlucoseDataXml:glucose testtime:testtime];
    NSString *revstr = [self callXMLWebService:xml urlString:UPLOAD_URL];
    XmlTool *myxmltool = [[XmlTool alloc]init];
    [myxmltool testXMLParse:revstr];
    NSDictionary *dic = myxmltool.myDataMutableDictionary;
    if([[dic valueForKey:@"Success"] isEqualToString:@"true"])
    {
        b=true;
    }
    return b;
}

+(BOOL)uploadBloodPressData :(int)sys dia:(int)dia pulse:(int)pulse testtime:(NSDate *)testtime
{
    bool b = false;
    
    NSString *xml = [self getUploadBloodPressDataXml:sys dia:dia pulse:pulse testtime:testtime];
    NSString *revstr = [self callXMLWebService:xml urlString:UPLOAD_URL];
    XmlTool *myxmltool = [[XmlTool alloc]init];
    [myxmltool testXMLParse:revstr];
    NSDictionary *dic = myxmltool.myDataMutableDictionary;
    if([[dic valueForKey:@"Success"] isEqualToString:@"true"])
    {
        b=true;
    }
    return b;
}

+(BOOL)uploadOxygenData :(int)oxygen pulse:(int)pulse testtime:(NSDate *)testtime
{
    bool b = false;
    
    NSString *xml = [self getUploadOxygenDataXml:oxygen pulse:pulse testtime:testtime];
    NSString *revstr = [self callXMLWebService:xml urlString:UPLOAD_URL];
    XmlTool *myxmltool = [[XmlTool alloc]init];
    [myxmltool testXMLParse:revstr];
    NSDictionary *dic = myxmltool.myDataMutableDictionary;
    if([[dic valueForKey:@"Success"] isEqualToString:@"true"])
    {
        b=true;
    }
    
    return b;
}

@end