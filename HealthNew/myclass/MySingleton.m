//
//  MySingleton.m
//  QRBodyfat
//
//  Created by 夏 伟 on 13-5-21.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "MySingleton.h"

@implementation MySingleton
@synthesize loginName;
@synthesize passWord;
@synthesize authKey;
@synthesize nowuserid;
@synthesize nowuserinfo;
@synthesize serverDomain;
@synthesize isLogined;

+(MySingleton *)sharedSingleton
{
    static MySingleton *sharedSingleton = nil;
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[MySingleton alloc] init];
        
        return sharedSingleton;
    }
}

@end
