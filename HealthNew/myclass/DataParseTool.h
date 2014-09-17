//
//  DataParseTool.h
//  BTLE
//
//  Created by 夏 伟 on 14-1-13.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataParseTool : NSObject

+(NSMutableArray *)sleepStrToArray:(NSString *)sleepdataStr;
+(NSString *)sleepArrayToStr:(NSMutableArray *)sleepdataArray;

@end
