//
//  LoginViewController.m
//  HealthNew
//
//  Created by 夏 伟 on 14-9-1.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "MeasureViewController.h"
#import "HistoryViewController.h"
#import "ChartViewController.h"
#import "SettingsViewController.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

@interface LoginViewController ()
@property(retain,nonatomic)UINavigationController *homeNavViewController;
@property(retain,nonatomic)UINavigationController *measureNavViewController;
@property(retain,nonatomic)UINavigationController *historyNavViewController;
@property(retain,nonatomic)UINavigationController *chartNavViewController;
@property(retain,nonatomic)UINavigationController *settingsNavViewController;


@property (weak, nonatomic) IBOutlet UIButton *enterBtn;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initMyView];
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)enterBtnPressed:(id)sender
{
    UITabBarController *tabBarController = (UITabBarController *)[self setTabBarController];
    [self presentViewController:tabBarController animated:NO completion:nil];
}

-(void)initMyView
{
    [_enterBtn addTarget:self action:@selector(enterBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(UITabBarController *)setTabBarController
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    _homeNavViewController = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    
    MeasureViewController *measureViewController = [[MeasureViewController alloc] initWithNibName:@"MeasureViewController" bundle:nil];
    _measureNavViewController = [[UINavigationController alloc] initWithRootViewController:measureViewController];
//    _measureNavViewController.navigationItem.title = NSLocalizedString(@"MEASURE", nil);
    [_measureNavViewController.navigationItem setTitle:NSLocalizedString(@"MEASURE", nil)];
    _measureNavViewController.navigationBar.tintColor = [UIColor purpleColor];
    [_measureNavViewController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [_measureNavViewController.navigationBar setBackgroundColor:[UIColor blueColor]];
    [_measureNavViewController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor greenColor],
                                                                     NSForegroundColorAttributeName,
                                                                     [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],
                                                                     NSShadowAttributeName,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                                     NSShadowAttributeName,
                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0],
                                                                     NSFontAttributeName,nil]];
    HistoryViewController *historyViewController = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    _historyNavViewController = [[UINavigationController alloc] initWithRootViewController:historyViewController];
    [_historyNavViewController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [_historyNavViewController.navigationBar
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor whiteColor],
                             NSForegroundColorAttributeName,
                             [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],
                             NSShadowAttributeName,
                             [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                             NSShadowAttributeName,
                             [UIFont fontWithName:@"Arial-Bold" size:0.0],
                             NSFontAttributeName,nil]];
    ChartViewController *chartViewController = [[ChartViewController alloc] initWithNibName:@"ChartViewController" bundle:nil];
    _chartNavViewController = [[UINavigationController alloc] initWithRootViewController:chartViewController];
    [_chartNavViewController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [_chartNavViewController.navigationBar
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor whiteColor],
                             NSForegroundColorAttributeName,
                             [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],
                             NSShadowAttributeName,
                             [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                             NSShadowAttributeName,
                             [UIFont fontWithName:@"Arial-Bold" size:0.0],
                             NSFontAttributeName,nil]];
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    _settingsNavViewController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    [_settingsNavViewController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [_settingsNavViewController.navigationBar
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                             [UIColor whiteColor],
                             NSForegroundColorAttributeName,
                             [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],
                             NSShadowAttributeName,
                             [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                             NSShadowAttributeName,
                             [UIFont fontWithName:@"Arial-Bold" size:0.0],
                             NSFontAttributeName,nil]];
    
    tabBarController.viewControllers = [[NSArray alloc]initWithObjects:_homeNavViewController,_measureNavViewController,_historyNavViewController,_chartNavViewController,_settingsNavViewController, nil];
//    [tabBarController. setTitle:@"dsa"];
    [_homeNavViewController.tabBarItem setTitle:NSLocalizedString(@"HOME", nil)];
    [_measureNavViewController.tabBarItem setTitle:NSLocalizedString(@"MEASURE", nil)];
    [_historyNavViewController.tabBarItem setTitle:NSLocalizedString(@"HISTORY", nil)];
    [_chartNavViewController.tabBarItem setTitle:NSLocalizedString(@"CHART", nil)];
    [_settingsNavViewController.tabBarItem setTitle:NSLocalizedString(@"SETTINGS", nil)];
    tabBarController.delegate = self;
    
    return tabBarController;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(viewController == _homeNavViewController)
    {
        [tabBarController dismissViewControllerAnimated:NO completion:nil];
    }
    else
    {
        
    }
        
}

@end
