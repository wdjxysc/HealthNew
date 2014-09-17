//
//  Regex.h
//  HealthABC
//
//  Created by 夏 伟 on 13-12-14.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Regex : NSObject

+(BOOL) validateMobile:(NSString*) mobile;
+(BOOL) validateEmail:(NSString *) email;
+(BOOL)validatePositiveFloat:(NSString *)number;
+(BOOL)validatePositiveInteger:(NSString *)number;

@end
