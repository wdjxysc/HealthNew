//
//  MySingleton.h
//  QRBodyfat
//
//  Created by 夏 伟 on 13-5-21.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySingleton : NSObject
{
    NSString *loginName;
    NSString *passWord;
    NSString *authKey;
    int nowuserid;
    NSMutableDictionary *nowuserinfo;
    NSString *serverDomain;
    BOOL isLogined;
}
+(MySingleton *)sharedSingleton;
@property(nonatomic,retain)NSString *loginName;
@property(nonatomic,retain)NSString *passWord;
@property(nonatomic,retain)NSString *authKey;
@property(nonatomic)int nowuserid;
@property(nonatomic,retain)NSMutableDictionary *nowuserinfo;
@property(nonatomic,retain)NSString *serverDomain;
@property BOOL isLogined;
@end
