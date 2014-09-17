//
//  database.h
//  HME
//
//  Created by 夏 伟 on 13-12-25.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define kSqliteFileName                     @"data.db3"
@interface database : NSObject

+(BOOL)insert:(NSString *)sqlstring;
+(BOOL)delete:(NSString *)sqlstring;
+(NSDictionary *)selectUserByName:(NSString *)username;
+(NSDictionary *)selectUserTarget:(NSString *)username;
+(NSDictionary *)selectUserCallRemind:(NSString *)username;
+(NSDictionary *)selectUserSportRemind:(NSString *)username;
+(NSDictionary *)selectUserAlarmRemind:(NSString *)username alarmcode:(NSString *)code;

+(BOOL)update:(NSString *)sqlstring;
+(BOOL)createtabel:(NSString *)sqlstring;
+(BOOL)initDataBase;
+(NSMutableArray *)selectUserRecent;
+(NSMutableArray *)selectUserRecent:(NSString *)username;
+(NSMutableArray *)getBodyFatDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
+(NSMutableArray *)getWeightDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
+(NSMutableArray *)getBloodPressDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
+(NSMutableArray *)getGlucoseDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
+(NSMutableArray *)getTemperatureDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
+(NSMutableArray *)getPedometerDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
+(NSMutableArray *)getSleepDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2;
@end
