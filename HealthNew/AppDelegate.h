//
//  AppDelegate.h
//  HealthNew
//
//  Created by 夏 伟 on 14-9-1.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "FoodSearchViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) FoodSearchViewController *foodSearchViewController;

@end
