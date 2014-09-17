//
//  database.m
//  HME
//
//  Created by 夏 伟 on 13-12-25.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "database.h"
#import <sqlite3.h>

@implementation database

+(BOOL)insert:(NSString *)sqlstring
{
    BOOL b = 0;
    
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    char* errorMsg;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    if(sqlite3_exec(database, [sqlstring UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK){//备注2
        //插入数据失败，关闭数据库
        sqlite3_close(database);
        //        NSAssert1(0, @"插入数据失败：%@", errorMsg);
        NSLog(@"插入数据失败：%s",errorMsg);
        sqlite3_free(errorMsg);
    }
    else
    {
        b = 1;
    }
    //关闭数据库
    sqlite3_close(database);
    
    return b;
}

+(BOOL)delete:(NSString *)sqlstring
{
    bool b = 0;
    
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    char* errorMsg;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    if(sqlite3_exec(database, [sqlstring UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK){//备注2
        //插入数据失败，关闭数据库
        sqlite3_close(database);
        //        NSAssert1(0, @"插入数据失败：%@", errorMsg);
        NSLog(@"删除数据失败：%s",errorMsg);
        sqlite3_free(errorMsg);
    }
    else
    {
        b = 1;
    }
    //关闭数据库
    sqlite3_close(database);
    
    return b;
}

+(BOOL)update:(NSString *)sqlstring
{
    bool b = 0;
    
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    char* errorMsg;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    if(sqlite3_exec(database, [sqlstring UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK){//备注2
        //插入数据失败，关闭数据库
        sqlite3_close(database);
        //        NSAssert1(0, @"插入数据失败：%@", errorMsg);
        NSLog(@"更新数据失败：%s",errorMsg);
        sqlite3_free(errorMsg);
    }
    else
    {
        b = 1;
    }
    //关闭数据库
    sqlite3_close(database);
    
    return b;
}

/**
 通过用户名查找用户信息.
 @param username 用户名
 */
+(NSDictionary *)selectUserByName:(NSString *)username
{
    NSDictionary *returndata;
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
//    CREATE TABLE IF NOT EXISTS USER(USERID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, BIRTHDAY TIMESTAMP, AGE INTEGER, GENDER INTEGER, PROFESSION INTEGER, HEIGHT INTEGER, WEIGHT FLOAT, STEPLENGTH INTEGER, PASSWORD TEXT, LENGTHUNIT INTEGER, WEIGHTUNIT INTEGER)
    NSString *sqlQuery = [[NSString alloc]initWithFormat:@"SELECT USERID,USERNAME,PASSWORD, WEIGHT,BIRTHDAY,GENDER,HEIGHT,PROFESSION, STEPLENGTH, LENGTHUNIT, WEIGHTUNIT FROM USER WHERE USERNAME = '%@' ORDER BY USERID ASC",username];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int userid = sqlite3_column_double(statement, 0);
            char *username = (char *)sqlite3_column_text(statement,1);
            char *password = (char *)sqlite3_column_text(statement,2);
            double weight = sqlite3_column_double(statement, 3);
            char *brithday = (char *)sqlite3_column_text(statement,4);
            int gender = sqlite3_column_double(statement, 5);
            int height = sqlite3_column_double(statement, 6);
            int profession = sqlite3_column_double(statement, 7);
            int steplength = sqlite3_column_double(statement, 8);
            int lengthunit = sqlite3_column_double(statement, 9);
            int weightunit = sqlite3_column_double(statement, 10);
            
            NSString *weightstr = [[NSString alloc]initWithFormat:@"%.1f",weight];
            
            returndata =[[NSDictionary alloc] initWithObjectsAndKeys:
                         [[NSString alloc] initWithFormat:@"%d", userid],
                         @"Userid",
                         [[NSString alloc] initWithFormat:@"%s", username],
                         @"UserName",
                         [[NSString alloc] initWithFormat:@"%s", password],
                         @"PassWord",
                         weightstr,
                         @"Weight",
                         [[NSString alloc] initWithFormat:@"%s", brithday],
                         @"Birthday",
                         [[NSString alloc] initWithFormat:@"%d", gender],
                         @"Gender",
                         [[NSString alloc] initWithFormat:@"%d", height],
                         @"Height",
                         [[NSString alloc] initWithFormat:@"%d", profession],
                         @"Profession",
                         [[NSString alloc] initWithFormat:@"%d", steplength],
                         @"StepLength",
                         [[NSString alloc] initWithFormat:@"%d", lengthunit],
                         @"LengthUnit",
                         [[NSString alloc] initWithFormat:@"%d", weightunit],
                         @"WeightUnit",
                         [[NSString alloc] initWithFormat:@"%d", weightunit],
                         @"TemperatureUnit",
                         nil];
        }
    }
    //关闭数据库
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
    return returndata;
}

/**
 通过用户名查找用户目标信息.
 @param username 用户名
 */
+(NSDictionary *)selectUserTarget:(NSString *)username
{
    NSDictionary *returndata;
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
    
    NSString *sqlQuery = [[NSString alloc]initWithFormat:@"SELECT USERID, USERNAME, STEPNUM, STEPNUMO2, KCAL, KCALO2, DISTANCE, DISTANCEO2, WEIGHT FROM TARGET WHERE USERNAME = '%@' ORDER BY USERID ASC",username];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int userid = sqlite3_column_double(statement, 0);
            char *username = (char *)sqlite3_column_text(statement,1);
            int stepnum = sqlite3_column_double(statement,2);
            int stepnumo2 = sqlite3_column_double(statement,3);
            double kcal = sqlite3_column_double(statement, 4);
            double kcalo2 = sqlite3_column_double(statement,5);
            double distance = sqlite3_column_double(statement, 6);
            double distanceo2 = sqlite3_column_double(statement, 7);
            double weight = sqlite3_column_double(statement, 8);
            
            NSString *weightstr = [[NSString alloc]initWithFormat:@"%.1f",weight];
            
            returndata =[[NSDictionary alloc] initWithObjectsAndKeys:
                         [[NSString alloc] initWithFormat:@"%d", userid],
                         @"Userid",
                         [[NSString alloc] initWithFormat:@"%s", username],
                         @"UserName",
                         [[NSString alloc] initWithFormat:@"%d", stepnum],
                         @"StepNum",
                         [[NSString alloc] initWithFormat:@"%d", stepnumo2],
                         @"StepNumo2",
                         [[NSString alloc] initWithFormat:@"%f", kcal],
                         @"Kcal",
                         [[NSString alloc] initWithFormat:@"%f", kcalo2],
                         @"Kcalo2",
                         [[NSString alloc] initWithFormat:@"%f", distance],
                         @"Distance",
                         [[NSString alloc] initWithFormat:@"%f", distanceo2],
                         @"Distanceo2",
                         weightstr,
                         @"Weight",
                         nil];
        }
    }
    //关闭数据库
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
    return returndata;
}

/**
 查询当前用户在一段时间内的体成分数据。
 @param username 用户名
 @param begintime 开始时间
 @param endtime   结束时间
 */
+(NSMutableArray *)getBodyFatDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    sqlite3 *database;
    NSString *filePath = [self dataFilePath];
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    NSMutableArray *bodyfatdataArray = [[NSMutableArray alloc] init];
    NSString *bodyfatsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM BODYFATDATA WHERE USERNAME = '%@' AND TESTTIME>='%@' AND TESTTIME<='%@' ORDER BY TESTTIME DESC",username,date1str,date2str];
    sqlite3_stmt * bodyfatstatement;
    
    if (sqlite3_prepare_v2(database, [bodyfatsqlQuery UTF8String], -1, &bodyfatstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(bodyfatstatement) == SQLITE_ROW) {
            double weight = sqlite3_column_double(bodyfatstatement, 7);
            double fat = sqlite3_column_double(bodyfatstatement, 8);
            int visceralfat = sqlite3_column_int(bodyfatstatement, 9);
            double water = sqlite3_column_double(bodyfatstatement, 10);
            double bone = sqlite3_column_double(bodyfatstatement, 11);
            double muscle = sqlite3_column_double(bodyfatstatement, 12);
            int bmr = sqlite3_column_int(bodyfatstatement, 13);
            double bmi = sqlite3_column_double(bodyfatstatement, 14);
            char *testtimechar = (char *)sqlite3_column_text(bodyfatstatement, 15);
            NSString *testtimestr = [[NSString  alloc]initWithFormat:@"%s",testtimechar];
            NSString *weightstr = [[NSString alloc]initWithFormat:@"%.1f",weight];
            NSString *fatstr = [[NSString alloc]initWithFormat:@"%.1f",fat];
            NSString *visceralfatstr = [[NSString alloc]initWithFormat:@"%d",visceralfat];
            NSString *waterstr = [[NSString alloc]initWithFormat:@"%.1f",water];
            NSString *bonestr = [[NSString alloc]initWithFormat:@"%.1f",bone];
            NSString *musclestr = [[NSString alloc]initWithFormat:@"%.1f",muscle];
            NSString *kcalstr = [[NSString alloc]initWithFormat:@"%d",bmr];
            NSString *bmistr = [[NSString alloc]initWithFormat:@"%.1f",bmi];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     [[NSString alloc] initWithFormat:@"%@", testtimestr],
                                     @"TestTime",
                                     weightstr,
                                     @"Weight",
                                     fatstr,
                                     @"Fat",
                                     musclestr,
                                     @"Muscle",
                                     waterstr,
                                     @"Water",
                                     bonestr,
                                     @"Bone",
                                     visceralfatstr,
                                     @"VisceralFat",
                                     kcalstr,
                                     @"BMR",
                                     bmistr,
                                     @"BMI",
                                     nil];
            
            
            [bodyfatdataArray addObject:dataRow1];
            
        }
    }
    
    sqlite3_finalize(bodyfatstatement);
    sqlite3_close(database);
    return bodyfatdataArray;
}

/**
 查询当前用户在一段时间内的体重数据。
 @param username 用户名
 @param begintime 开始时间
 @param endtime   结束时间
 */
+(NSMutableArray *)getWeightDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSMutableArray *weightdataArray = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    NSString *weightsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM WEIGHTDATA WHERE USERNAME = '%@' AND TESTTIME>='%@' AND TESTTIME<='%@' ORDER BY TESTTIME DESC",username,date1str,date2str];
    //sqlQuery = @"SELECT * FROM WEIGHTDATA WHERE USERID = 1";
    sqlite3_stmt * weightstatement;
    
    if (sqlite3_prepare_v2(database, [weightsqlQuery UTF8String], -1, &weightstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(weightstatement) == SQLITE_ROW) {
            double weight = sqlite3_column_double(weightstatement, 3);
            char *testtimechar = (char *)sqlite3_column_text(weightstatement, 4);
            NSString *testtimestr = [[NSString  alloc]initWithFormat:@"%s",testtimechar];
            NSString *weightstr = [[NSString alloc]initWithFormat:@"%.1f",weight];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     [[NSString alloc] initWithFormat:@"%@", testtimestr],
                                     @"TestTime",
                                     weightstr,
                                     @"Weight",
                                     nil];
            [weightdataArray addObject:dataRow1];
        }
    }
    sqlite3_finalize(weightstatement);
    sqlite3_close(database);
    return weightdataArray;
}


/**
 查询当前用户在一段时间内的血压数据。
 @param username 用户名
 @param begintime 开始时间
 @param endtime   结束时间
 */
+(NSMutableArray *)getBloodPressDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSMutableArray *bpdataArray = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    NSString *bpsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM BLOODPRESSDATA WHERE USERNAME = '%@' AND TESTTIME>='%@' AND TESTTIME<='%@' ORDER BY TESTTIME DESC", username, date1str, date2str];
    //sqlQuery = @"SELECT * FROM WEIGHTDATA WHERE USERID = 1";
    sqlite3_stmt * bpstatement;
    
    if (sqlite3_prepare_v2(database, [bpsqlQuery UTF8String], -1, &bpstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(bpstatement) == SQLITE_ROW) {
            double sys = sqlite3_column_double(bpstatement, 3);
            double dia = sqlite3_column_double(bpstatement, 4);
            double pulse = sqlite3_column_double(bpstatement, 5);
            char *testtimechar = (char *)sqlite3_column_text(bpstatement, 6);
            NSString *testtimestr = [[NSString  alloc]initWithFormat:@"%s",testtimechar];
            NSString *sysstr = [[NSString alloc]initWithFormat:@"%.1f",sys];
            NSString *diastr = [[NSString alloc]initWithFormat:@"%.1f",dia];
            NSString *pulsestr = [[NSString alloc]initWithFormat:@"%.1f",pulse];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     [[NSString alloc] initWithFormat:@"%@", testtimestr],
                                     @"TestTime",
                                     sysstr,
                                     @"SYS",
                                     diastr,
                                     @"DIA",
                                     pulsestr,
                                     @"Pulse",
                                     nil];
            [bpdataArray addObject:dataRow1];
        }
    }
    sqlite3_finalize(bpstatement);
    sqlite3_close(database);
    return bpdataArray;
}

/**
 查询当前用户在一段时间内的血糖数据。
 @param username 用户名
 @param begintime 开始时间
 @param endtime   结束时间
 */
+(NSMutableArray *)getGlucoseDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSMutableArray *bpdataArray = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    NSString *bpsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM GLUCOSEDATA WHERE USERNAME = '%@' AND TESTTIME>='%@' AND TESTTIME<='%@' ORDER BY TESTTIME DESC", username, date1str, date2str];
    //sqlQuery = @"SELECT * FROM WEIGHTDATA WHERE USERID = 1";
    sqlite3_stmt * bpstatement;
    
    if (sqlite3_prepare_v2(database, [bpsqlQuery UTF8String], -1, &bpstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(bpstatement) == SQLITE_ROW) {
            double glucose = sqlite3_column_double(bpstatement, 3);
            char *testtimechar = (char *)sqlite3_column_text(bpstatement, 4);
            NSString *testtimestr = [[NSString  alloc]initWithFormat:@"%s",testtimechar];
            NSString *glucosestr = [[NSString alloc]initWithFormat:@"%.1f",glucose];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     [[NSString alloc] initWithFormat:@"%@", testtimestr],
                                     @"TestTime",
                                     glucosestr,
                                     @"Glucose",
                                     nil];
            [bpdataArray addObject:dataRow1];
        }
    }
    sqlite3_finalize(bpstatement);
    sqlite3_close(database);
    return bpdataArray;
}


/**
 查询当前用户在一段时间内的体温数据。
 @param username 用户名
 @param begintime 开始时间
 @param endtime   结束时间
 */
+(NSMutableArray *)getTemperatureDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSMutableArray *tempdataArray = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    NSString *bpsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM TEMPERATUREDATA WHERE USERNAME = '%@' AND TESTTIME>='%@' AND TESTTIME<='%@' ORDER BY TESTTIME DESC", username, date1str, date2str];
    //sqlQuery = @"SELECT * FROM WEIGHTDATA WHERE USERID = 1";
    sqlite3_stmt * bpstatement;
    
    if (sqlite3_prepare_v2(database, [bpsqlQuery UTF8String], -1, &bpstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(bpstatement) == SQLITE_ROW) {
            double temperature = sqlite3_column_double(bpstatement, 3);
            char *testtimechar = (char *)sqlite3_column_text(bpstatement, 4);
            NSString *testtimestr = [[NSString  alloc]initWithFormat:@"%s",testtimechar];
            NSString *temperaturestr = [[NSString alloc]initWithFormat:@"%.1f",temperature];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     [[NSString alloc] initWithFormat:@"%@", testtimestr],
                                     @"TestTime",
                                     temperaturestr,
                                     @"Temperature",
                                     nil];
            [tempdataArray addObject:dataRow1];
        }
    }
    sqlite3_finalize(bpstatement);
    sqlite3_close(database);
    return tempdataArray;
}


/**
 查询当前用户在一段时间内的计步数据。
 @param username 用户名
 @param begintime 开始时间
 @param endtime   结束时间
 */
+(NSMutableArray *)getPedometerDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSMutableArray *bpdataArray = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    NSString *bpsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM PEDOMETERDATA WHERE USERNAME = '%@' AND TESTTIME>='%@' AND TESTTIME<='%@' ORDER BY TESTTIME DESC", username, date1str, date2str];
    //sqlQuery = @"SELECT * FROM WEIGHTDATA WHERE USERID = 1";
    sqlite3_stmt * bpstatement;
    
    if (sqlite3_prepare_v2(database, [bpsqlQuery UTF8String], -1, &bpstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(bpstatement) == SQLITE_ROW) {
            char *sporttimechar = (char *)sqlite3_column_text(bpstatement, 3);
            int step = sqlite3_column_int(bpstatement, 4);
            double distance = sqlite3_column_double(bpstatement, 5);
            double kcal = sqlite3_column_double(bpstatement, 6);
            int stepo2 = sqlite3_column_int(bpstatement, 7);
            double distanceo2 = sqlite3_column_double(bpstatement, 8);
            double kcalo2 = sqlite3_column_double(bpstatement, 9);
            char *testtimechar = (char *)sqlite3_column_text(bpstatement, 10);
            
            NSString *sporttimestr = [[NSString  alloc]initWithFormat:@"%s",sporttimechar];
            NSString *stepstr = [[NSString  alloc]initWithFormat:@"%d",step];
            NSString *distancestr = [[NSString  alloc]initWithFormat:@"%f",distance];
            NSString *kcalstr = [[NSString  alloc]initWithFormat:@"%f",kcal];
            NSString *stepo2str = [[NSString  alloc]initWithFormat:@"%d",stepo2];
            NSString *distanceo2str = [[NSString  alloc]initWithFormat:@"%f",distanceo2];
            NSString *kcalo2str = [[NSString  alloc]initWithFormat:@"%f",kcalo2];
            NSString *testtimestr = [[NSString  alloc]initWithFormat:@"%s",testtimechar];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     testtimestr,
                                     @"TestTime",
                                     stepstr,
                                     @"Step",
                                     distancestr,
                                     @"Distance",
                                     kcalstr,
                                     @"Kcal",
                                     stepo2str,
                                     @"Stepo2",
                                     distanceo2str,
                                     @"Distanceo2",
                                     kcalo2str,
                                     @"Kcalo2",
                                     sporttimestr,
                                     @"SportTime",
                                     nil];
            [bpdataArray addObject:dataRow1];
        }
    }
    sqlite3_finalize(bpstatement);
    sqlite3_close(database);
    return bpdataArray;
}

/**
 查询当前用户在一段时间内的睡眠数据。
 @param username 用户名
 @param begintime 开始时间
 @param endtime   结束时间
 */
+(NSMutableArray *)getSleepDataByUserName:(NSString *)username begintime:(NSDate *)date1 endtime:(NSDate *)date2
{
    NSMutableArray *bpdataArray = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *date1str = [formatter stringFromDate:date1];
    NSString *date2str = [formatter stringFromDate:date2];
    
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    
    NSString *bpsqlQuery = [[NSString alloc]initWithFormat:@"SELECT * FROM SLEEPDATA WHERE USERNAME = '%@' AND BEGINTIME>='%@' AND BEGINTIME<='%@' ORDER BY BEGINTIME DESC", username, date1str, date2str];
    //sqlQuery = @"SELECT * FROM WEIGHTDATA WHERE USERID = 1";
    sqlite3_stmt * bpstatement;
    
    if (sqlite3_prepare_v2(database, [bpsqlQuery UTF8String], -1, &bpstatement, nil) == SQLITE_OK) {
        while (sqlite3_step(bpstatement) == SQLITE_ROW) {
            char *begintimechar = (char *)sqlite3_column_text(bpstatement, 3);
            char *endtimechar = (char *)sqlite3_column_text(bpstatement, 4);
            char *sleepdata = (char *)sqlite3_column_text(bpstatement, 5);
            
            NSString *begintimestr = [[NSString  alloc]initWithFormat:@"%s",begintimechar];
            NSString *endtimestr = [[NSString  alloc]initWithFormat:@"%s",endtimechar];
            NSString *sleepdatastr = [[NSString  alloc]initWithFormat:@"%s",sleepdata];
            
            NSDictionary *dataRow1 =[[NSDictionary alloc] initWithObjectsAndKeys:
                                     begintimestr,
                                     @"BeginTime",
                                     endtimestr,
                                     @"EndTime",
                                     sleepdatastr,
                                     @"SleepData",
                                     nil];
            
            [bpdataArray addObject:dataRow1];
        }
    }
    sqlite3_finalize(bpstatement);
    sqlite3_close(database);
    return bpdataArray;
}

/**
 通过用户名查找用户电话提醒设置信息.
 @param username 用户名
 */
+(NSDictionary *)selectUserCallRemind:(NSString *)username
{
    NSDictionary *returndata;
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
    
    NSString *sqlQuery = [[NSString alloc]initWithFormat:@"SELECT USERID, USERNAME, ISREMIND FROM CALLREMIND WHERE USERNAME = '%@' ORDER BY USERID ASC",username];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int userid = sqlite3_column_double(statement, 0);
            char *username = (char *)sqlite3_column_text(statement,1);
            char *isremind = (char *)sqlite3_column_text(statement,2);
            
            
            returndata =[[NSDictionary alloc] initWithObjectsAndKeys:
                         [[NSString alloc] initWithFormat:@"%d", userid],
                         @"Userid",
                         [[NSString alloc] initWithFormat:@"%s", username],
                         @"UserName",
                         [[NSString alloc] initWithFormat:@"%s", isremind],
                         @"IsRemind",
                         nil];
        }
    }
    //关闭数据库
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
    return returndata;
}

/**
 通过用户名查找用户运动提醒设置信息.
 @param username 用户名
 */
+(NSDictionary *)selectUserSportRemind:(NSString *)username
{
    NSDictionary *returndata;
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
    
    NSString *sqlQuery = [[NSString alloc]initWithFormat:@"SELECT USERID, USERNAME, ISREMIND, REMINDINTERVAL, BEGINTIME, ENDTIME FROM SPORTREMIND WHERE USERNAME = '%@' ORDER BY USERID ASC",username];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int userid = sqlite3_column_double(statement, 0);
            char *username = (char *)sqlite3_column_text(statement,1);
            char *isremind = (char *)sqlite3_column_text(statement,2);
            int remindinterval = sqlite3_column_double(statement, 3);
            int begintime = sqlite3_column_double(statement, 4);
            int endtime = sqlite3_column_double(statement, 5);
            
            
            returndata =[[NSDictionary alloc] initWithObjectsAndKeys:
                         [[NSString alloc] initWithFormat:@"%d", userid],
                         @"Userid",
                         [[NSString alloc] initWithFormat:@"%s", username],
                         @"UserName",
                         [[NSString alloc] initWithFormat:@"%s", isremind],
                         @"IsRemind",
                         [[NSString alloc] initWithFormat:@"%d", remindinterval],
                         @"RemindInterval",
                         [[NSString alloc] initWithFormat:@"%d", begintime],
                         @"BeginTime",
                         [[NSString alloc] initWithFormat:@"%d", endtime],
                         @"EndTime",
                         nil];
        }
    }
    //关闭数据库
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
    return returndata;
}


/**
 通过用户名查找用户闹铃提醒设置信息.
 @param username 用户名
 @param alarmcode 闹铃编号
 */
+(NSDictionary *)selectUserAlarmRemind:(NSString *)username alarmcode:(NSString *)code
{
    NSDictionary *returndata;
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
    
    NSString *sqlQuery = [[NSString alloc]initWithFormat:@"SELECT USERID, USERNAME, ISREMIND, REMINDRULE, REMINDTIME FROM ALARMREMIND WHERE USERNAME = '%@' AND ALARMCODE = '%@' ORDER BY USERID ASC",username,code];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int userid = sqlite3_column_double(statement, 0);
            char *username = (char *)sqlite3_column_text(statement,1);
            char *isremind = (char *)sqlite3_column_text(statement,2);
            int remindrule = sqlite3_column_double(statement, 3);
            int remindtime = sqlite3_column_double(statement, 4);
            
            
            returndata =[[NSDictionary alloc] initWithObjectsAndKeys:
                         [[NSString alloc] initWithFormat:@"%d", userid],
                         @"Userid",
                         [[NSString alloc] initWithFormat:@"%s", username],
                         @"UserName",
                         [[NSString alloc] initWithFormat:@"%s", isremind],
                         @"IsRemind",
                         [[NSString alloc] initWithFormat:@"%d", remindrule],
                         @"RemindRule",
                         [[NSString alloc] initWithFormat:@"%d", remindtime],
                         @"RemindTime",
                         nil];
        }
    }
    //关闭数据库
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
    return returndata;
}

/**
 查找最近登录的用户名密码及是否记录等信息.
 */
+(NSMutableArray *)selectUserRecent
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
    NSString *sqlQuery = [[NSString alloc]initWithFormat:@"SELECT USERID, USERNAME, PASSWORD, LOGINTIME, ISREMENBER FROM USERPASSWORD ORDER BY LOGINTIME DESC"];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int userid = sqlite3_column_double(statement, 0);
            char *username = (char *)sqlite3_column_text(statement,1);
            char *password = (char *)sqlite3_column_text(statement,2);
            char *logintime = (char *)sqlite3_column_text(statement,3);
            char *isremenber = (char *)sqlite3_column_text(statement,4);
            
            
            NSDictionary *returndata = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        [[NSString alloc] initWithFormat:@"%d", userid],
                                        @"Userid",
                                        [[NSString alloc] initWithFormat:@"%s", username],
                                        @"UserName",
                                        [[NSString alloc] initWithFormat:@"%s", password],
                                        @"PassWord",
                                        [[NSString alloc] initWithFormat:@"%s", logintime],
                                        @"LoginTime",
                                        [[NSString alloc] initWithFormat:@"%s", isremenber],
                                        @"IsRemenber",
                                        nil];
            
            [array addObject:returndata];
        }
    }
    //关闭数据库
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    return array;
}

/**
 查找最近登录的用户名密码及是否记录等信息.
 */
+(NSMutableArray *)selectUserRecent:(NSString *)username
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    //获取数据库路径
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
    NSString *sqlQuery = [[NSString alloc]initWithFormat:@"SELECT USERID, USERNAME, PASSWORD, LOGINTIME, ISREMENBER FROM USERPASSWORD WHERE USERNAME = %@ ORDER BY LOGINTIME DESC",username];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int userid = sqlite3_column_double(statement, 0);
            char *username = (char *)sqlite3_column_text(statement,1);
            char *password = (char *)sqlite3_column_text(statement,2);
            char *logintime = (char *)sqlite3_column_text(statement,3);
            char *isremenber = (char *)sqlite3_column_text(statement,4);
            
            
            NSDictionary *returndata = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        [[NSString alloc] initWithFormat:@"%d", userid],
                                        @"Userid",
                                        [[NSString alloc] initWithFormat:@"%s", username],
                                        @"UserName",
                                        [[NSString alloc] initWithFormat:@"%s", password],
                                        @"PassWord",
                                        [[NSString alloc] initWithFormat:@"%s", logintime],
                                        @"logintime",
                                        [[NSString alloc] initWithFormat:@"%s", isremenber],
                                        @"IsRemenber",
                                        nil];
            
            [array addObject:returndata];
        }
    }
    //关闭数据库
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
    return array;
}


+(BOOL)createtabel:(NSString *)sqlstring
{
    BOOL b = 0;
    
    //确定是否有数据文件及相应表，若无则创建
    NSString *filePath = [self dataFilePath];
    
    NSLog(@"filePath=%@",filePath);
    
    sqlite3 *database;
    if (sqlite3_open([filePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开失败");
    }
    char* errorMsg;
    
    if(sqlite3_exec(database, [sqlstring UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK){//备注2
        //创建表失败，关闭数据库
        sqlite3_close(database);
        NSAssert1(0, @"创建表失败：%s", errorMsg);
        sqlite3_free(errorMsg);
    }
    else
    {
        b =1;
    }
    
    sqlite3_close(database);
    
    return b;
}

+(BOOL)initDataBase
{
    BOOL b = 0;
    
    //创建脂肪秤数据表 数据id，用户id，用户名，年龄，性别，运动等级，身高(cm)，体重(kg)，脂肪率(%)，内脏脂肪等级，水分率(%)，骨量(%)，肌肉量(%)，BMR(基础代谢)，BMI，测试时间，版本号，是否发送
    NSString *sqlCreateFatTable = @"CREATE TABLE IF NOT EXISTS BODYFATDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, AGE INTEGER, GENDER INTEGER, PEOFESSION INTEGER, HEIGHT INTEGER, WEIGHT FLOAT, BODYFAT FLOAT, VISCERALFAT INTEGER, WATER FLOAT, BONE FLOAT, MUSCLE FLOAT, BMR INTEGER, BMI FLOAT, TESTTIME TIMESTAMP, VERSION FLOAT,ISSEND TEXT)";
    
    //创建健康秤数据表 数据id，用户id，用户名，体重，测量时间，是否上传
    NSString *sqlCreateWeightTable = @"CREATE TABLE IF NOT EXISTS WEIGHTDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, WEIGHT FLOAT, TESTTIME TIMESTAMP, ISSEND TEXT)";
    
    //创建用户表 用户id，用户名，生日，性别(0男,1女)，运动级别(1白领，2普通，3运动员),身高（cm），体重(kg)，步幅(cm)，密码，用户展示数据长度单位(0:公制cm 1:美制inch)，用户展示数据重量单位(0:公制kg 1:美制lb)，用户展示数据温度单位(0:公制℃ 1:美制℉)
    NSString *sqlCreateUserTable = @"CREATE TABLE IF NOT EXISTS USER(USERID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, BIRTHDAY TIMESTAMP, AGE INTEGER, GENDER INTEGER, PROFESSION INTEGER, HEIGHT INTEGER, WEIGHT FLOAT, STEPLENGTH INTEGER, PASSWORD TEXT, LENGTHUNIT INTEGER, WEIGHTUNIT INTEGER, TEMPERATUREUNIT INTEGER)";
    
    //创建血压计数据表 数据id，用户id，用户名，体重，测量时间，是否上传
    NSString *sqlCreateBloodPressTable = @"CREATE TABLE IF NOT EXISTS BLOODPRESSDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, SYS FLOAT, DIA FLOAT, PULSE FLOAT, TESTTIME TIMESTAMP, ISSEND TEXT)";
    
    //创建血糖仪数据表 数据id，用户id，用户名，血糖，测量时间，是否上传
    NSString *sqlCreateGlucoseTable = @"CREATE TABLE IF NOT EXISTS GLUCOSEDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, GLUCOSE FLOAT, TESTTIME TIMESTAMP, ISSEND TEXT)";
    
    //创建计步数据表 数据id，用户id，用户名，运动时间(sec)，总步数，总距离(km)，总卡路里(kcal)，有氧步数，有氧距离，有氧卡路里，测量时间，是否上传
    NSString *sqlCreatePedometerTable = @"CREATE TABLE IF NOT EXISTS PEDOMETERDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, SPORTTIME INTEGER, STEPNUM INTEGER, DISTANCE FLOAT, KCAL FLOAT, STEPNUMO2 INTEGER, DISTANCEO2 FLOAT, KCALO2 FLOAT, TESTTIME TIMESTAMP, ISSEND TEXT)";
    
    //创建睡眠数据表 数据id，用户id，用户名，睡眠开始时间，睡眠结束时间，睡眠数据(min)，是否上传
    NSString *sqlCreateSleepTable = @"CREATE TABLE IF NOT EXISTS SLEEPDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, BEGINTIME TIMESTAMP, ENDTIME TIMESTAMP, SLEEPDATA TEXT, ISSEND TEXT)";
    
    
    //创建健康目标数据表 数据id，用户id，用户名，总步数，有氧步数，总卡路里（kcal），有氧卡路里，总路程（km），有氧路程，体重，运动时间（min），是否上传
    NSString *sqlCreateTargetTable = @"CREATE TABLE IF NOT EXISTS TARGET(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT,STEPNUM INTEGER, STEPNUMO2 INTEGER, KCAL FLOAT, KCALO2 FLOAT, DISTANCE FLOAT, DISTANCEO2 FLOAT, WEIGHT FLOAT,SPORTTIME INTEGER, ISSEND TEXT)";
    
    //创建 设置来电提醒表 数据id，用户id，用户名，是否提醒(Y,N)，是否上传
    NSString *sqlCreateCallRemindTable = @"CREATE TABLE IF NOT EXISTS CALLREMIND(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, ISREMIND TEXT, ISSEND TEXT)";
    
    //创建 设置运动提醒表 数据id，用户id，用户名，是否提醒(Y,N)，提醒间隔（min），开始时间(min)，结束时间(min)，是否上传
    NSString *sqlCreateSportRemindTable = @"CREATE TABLE IF NOT EXISTS SPORTREMIND(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, ISREMIND TEXT, REMINDINTERVAL INTEGER, BEGINTIME INTEGER, ENDTIME INTEGER, ISSEND TEXT)";
    
    //创建 设置闹铃提醒表 数据id，用户id，用户名，闹铃编号，是否提醒(Y,N)，提醒规则（一字节 bit7：每天 bit6-0：分别是周日到周六），提醒时间（min），是否上传
    NSString *sqlCreateAlarmRemindTable = @"CREATE TABLE IF NOT EXISTS ALARMREMIND(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, ALARMCODE TEXT, ISREMIND TEXT, REMINDRULE INTEGER, REMINDTIME INTEGER, ISSEND TEXT)";
    //创建 记住用户密码表 数据id，用户id，用户名，密码，是否记住，最后登录时间
    NSString *sqlCreateUserPasswordTable = @"CREATE TABLE IF NOT EXISTS USERPASSWORD(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, PASSWORD TEXT, ISREMENBER TEXT, LOGINTIME TIMESTAMP)";
    
    //创建 温度数据表 数据id(自增长),用户id(int)，用户名(text)，温度(float)，测量时间(TIMESTAMP)，设备id(text)，设备类型(text)，是否上传
    NSString *sqlCreateTemperatureTable = @"CREATE TABLE IF NOT EXISTS TEMPERATUREDATA(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT, TEMPERATURE FLOAT, TESTTIME TIMESTAMP, DEVICEID TEXT, DEVICETYPE TEXT, ISSEND TEXT)";
    
    //用户信息表新增一列 TEMPERATUREUNIT
    NSString *addColumnToUserTable = @"ALTER TABLE USER ADD COLUMN TEMPERATUREUNIT INT DEFAULT(0)";
    
    b = [self createtabel:sqlCreateFatTable];
    b = [self createtabel:sqlCreateWeightTable];
    b = [self createtabel:sqlCreateUserTable];
    b = [self createtabel:sqlCreateBloodPressTable];
    b = [self createtabel:sqlCreateGlucoseTable];
    b = [self createtabel:sqlCreatePedometerTable];
    b = [self createtabel:sqlCreateSleepTable];
    b = [self createtabel:sqlCreateTargetTable];
    b = [self createtabel:sqlCreateCallRemindTable];
    b = [self createtabel:sqlCreateSportRemindTable];
    b = [self createtabel:sqlCreateAlarmRemindTable];
    b = [self createtabel:sqlCreateUserPasswordTable];
    b = [self createtabel:sqlCreateTemperatureTable];
    b = [self insert:addColumnToUserTable];
    
    return b;
}


+(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kSqliteFileName];
}



@end