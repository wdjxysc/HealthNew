//
//  UIViewPassValueDelegate.h
//  Market
//
//  Created by 夏 伟 on 14-6-17.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIViewPassValueDelegate <NSObject>
- (void)passValue:(NSDictionary *)value;
@end
