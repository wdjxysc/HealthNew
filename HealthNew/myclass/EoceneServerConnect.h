//
//  EoceneServerConnect.h
//  HME
//
//  Created by 夏 伟 on 13-12-31.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

#define REG_URL             @"https://ws.eocenesystems.com/cnsappreg.cfc"
#define UPLOAD_URL          @"https://ws.eocenesystems.com/eoceneupload.cfc"
#define REG_DEVICE_URL      @"asdfasf"

@interface EoceneServerConnect : NSObject

@property(nonatomic,retain)NSArray *oxygenDataArray;
@property(nonatomic,retain)NSArray *glucoseDataArray;
@property(nonatomic,retain)NSArray *weightDataArray;
@property(nonatomic,retain)NSArray *bloodpressDataArray;

+(NSMutableString *)callXMLWebService:(NSString *)data urlString:(NSString *)urlString;
+(void)callXMLWebServiceGood:(NSString *)xmlstr urlString:(NSString *)urlString;
+(void) postxml:(NSString *)xmlstr urlString:(NSString *)urlString;
+(NSString *)getRegXml :(NSString *)username password:(NSString *)password;
+(BOOL)uploadGlucoseData :(int)glucose testtime:(NSDate *)testtime;
+(BOOL)uploadBloodPressData :(int)sys dia:(int)dia pulse:(int)pulse testtime:(NSDate *)testtime;
+(BOOL)uploadOxygenData :(int)oxygen pulse:(int)pulse testtime:(NSDate *)testtime;
@end