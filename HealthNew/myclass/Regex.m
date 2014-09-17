//
//  Regex.m
//  HealthABC
//
//  Created by 夏 伟 on 13-12-14.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "Regex.h"

@implementation Regex


/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) validateMobile:(NSString*) mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

/*邮箱验证*/
+(BOOL) validateEmail:(NSString *) email {
    NSString *emailRegex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$
/*正浮点数验证*/
+(BOOL)validatePositiveFloat:(NSString *)number
{
    NSString *numberRegex = @"^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    NSLog(@"phoneTest is %@",numberTest);
    return [numberTest evaluateWithObject:number];
}

//^[1-9]\d*$
/*正整数验证*/
+(BOOL)validatePositiveInteger:(NSString *)number
{
    NSString *numberRegex = @"^[1-9]\\d*$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    NSLog(@"phoneTest is %@",numberTest);
    return [numberTest evaluateWithObject:number];
}

@end
