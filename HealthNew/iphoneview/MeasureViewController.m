//
//  MeasureViewController.m
//  HealthNew
//
//  Created by wang on 14-9-15.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "MeasureViewController.h"
#import "WeightFatViewController.h"
#import "BloodPressViewController.h"
#import "TemperatureViewController.h"
#import "NutritionViewController.h"

@interface MeasureViewController ()
@property (weak, nonatomic) IBOutlet UIButton *weightfatBtn;
@property (weak, nonatomic) IBOutlet UIButton *bloodpressBtn;
@property (weak, nonatomic) IBOutlet UIButton *temperatureBtn;
@property (weak, nonatomic) IBOutlet UIButton *nutritionBtn;

@end

@implementation MeasureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        [self.navigationController.navigationItem setTitle:NSLocalizedString(@"MEASURE", nil)];
//        self.navigationItem.title = NSLocalizedString(@"MEASURE", nil);
//        self.navigationItem.title = @"asdfafsdafsa";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMyView
{
    [_weightfatBtn addTarget:self action:@selector(weightfatBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_bloodpressBtn addTarget:self action:@selector(bloodpressBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_temperatureBtn addTarget:self action:@selector(temperatureBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_nutritionBtn addTarget:self action:@selector(nutritionBtnPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)weightfatBtnPressed
{
    WeightFatViewController *weightfatViewController = [[WeightFatViewController alloc]initWithNibName:@"WeightFatViewController" bundle:nil];
    [self.navigationController pushViewController:weightfatViewController animated:YES];
}

-(void)bloodpressBtnPressed
{
    BloodPressViewController *bloodPressViewController = [[BloodPressViewController alloc]initWithNibName:@"BloodPressViewController" bundle:nil];
    [self.navigationController pushViewController:bloodPressViewController animated:YES];
}

-(void)temperatureBtnPressed
{
    TemperatureViewController *temperatureViewController = [[TemperatureViewController alloc]initWithNibName:@"TemperatureViewController" bundle:nil];
    [self.navigationController pushViewController:temperatureViewController animated:YES];
}

-(void)nutritionBtnPressed
{
    NutritionViewController *nutritionViewController = [[NutritionViewController alloc]initWithNibName:@"NutritionViewController" bundle:nil];
    [self.navigationController pushViewController:nutritionViewController animated:YES];
}
@end
