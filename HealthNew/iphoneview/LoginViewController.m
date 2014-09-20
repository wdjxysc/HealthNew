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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.enterBtn
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.scrollView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:10.0
                                   constant:100.0]];
}

-(UITabBarController *)setTabBarController
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    _homeNavViewController = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    
    MeasureViewController *measureViewController = [[MeasureViewController alloc] initWithNibName:@"MeasureViewController" bundle:nil];
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1];
    shadow.shadowOffset = CGSizeMake(0, 0);
    _measureNavViewController = [[UINavigationController alloc] initWithRootViewController:measureViewController];
    [measureViewController.navigationItem setTitle:NSLocalizedString(@"MEASURE", nil)];
    _measureNavViewController.navigationBar.tintColor = [UIColor purpleColor];
    [_measureNavViewController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [_measureNavViewController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor blackColor],
                                                                     NSForegroundColorAttributeName,
                                                                     shadow,
                                                                     NSShadowAttributeName,
                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0],
                                                                     NSFontAttributeName,nil]];
    HistoryViewController *historyViewController = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    _historyNavViewController = [[UINavigationController alloc] initWithRootViewController:historyViewController];
    [_historyNavViewController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [historyViewController.navigationItem setTitle:NSLocalizedString(@"HISTORY", nil)];
    [_historyNavViewController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor blackColor],
                                                                     NSForegroundColorAttributeName,
                                                                     shadow,
                                                                     NSShadowAttributeName,
                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0],
                                                                     NSFontAttributeName,nil]];
    ChartViewController *chartViewController = [[ChartViewController alloc] initWithNibName:@"ChartViewController" bundle:nil];
    _chartNavViewController = [[UINavigationController alloc] initWithRootViewController:chartViewController];
    [_chartNavViewController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [chartViewController.navigationItem setTitle:NSLocalizedString(@"CHART", nil)];
    [_chartNavViewController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor blackColor],
                                                                     NSForegroundColorAttributeName,
                                                                     shadow,
                                                                     NSShadowAttributeName,
                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0],
                                                                     NSFontAttributeName,nil]];
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    _settingsNavViewController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    [_settingsNavViewController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [settingsViewController.navigationItem setTitle:NSLocalizedString(@"SETTINGS", nil)];
    [_settingsNavViewController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor blackColor],
                                                                     NSForegroundColorAttributeName,
                                                                     shadow,
                                                                     NSShadowAttributeName,
                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0],
                                                                     NSFontAttributeName,nil]];
    
    tabBarController.viewControllers = [[NSArray alloc]initWithObjects:_homeNavViewController,_measureNavViewController,_historyNavViewController,_chartNavViewController,_settingsNavViewController, nil];
    [_homeNavViewController.tabBarItem setTitle:NSLocalizedString(@"HOME", nil)];
    [_measureNavViewController.tabBarItem setTitle:NSLocalizedString(@"MEASURE", nil)];
    [_historyNavViewController.tabBarItem setTitle:NSLocalizedString(@"HISTORY", nil)];
    [_chartNavViewController.tabBarItem setTitle:NSLocalizedString(@"CHART", nil)];
    [_settingsNavViewController.tabBarItem setTitle:NSLocalizedString(@"SETTINGS", nil)];
    [tabBarController setSelectedIndex:1];//选中测量界面
    tabBarController.delegate = self;
    
    return tabBarController;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(viewController == _homeNavViewController)
    {
        [tabBarController dismissViewControllerAnimated:NO completion:nil];
    }
}

@end
