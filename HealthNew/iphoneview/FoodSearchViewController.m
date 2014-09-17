//
//  FoodSearchViewController.m
//  HealthNew
//
//  Created by wang on 14-9-15.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "FoodSearchViewController.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

@interface FoodSearchViewController ()
@property(retain,nonatomic)UISearchBar *searchBar;
@property(retain,nonatomic)UITableView *tabelView;
@property(retain,nonatomic)NSMutableArray *foodDisplayArray;

@end

@implementation FoodSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //添加单击手势，隐藏软键盘
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(View_TouchDown:)];
        tapGr.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tapGr];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initMyView];
    _foodDisplayArray = [[NSMutableArray alloc]initWithObjects:@"牛奶",@"牛肉",@"牛鞭",@"牛鼻子", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)View_TouchDown:(id)sender
{
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(void)initMyView
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 42)];
    _searchBar.placeholder = @"Please enter food name";
    [self.view addSubview:_searchBar];
    _searchBar.delegate = self;
    
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 62, 320, Screen_height-62)];
    [self.view addSubview:_tabelView];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self View_TouchDown:searchBar];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    UITableViewCell *returncell = [[UITableViewCell alloc]init];
    
    returncell.textLabel.text = _foodDisplayArray[indexPath.row];
    returncell.textLabel.textColor = [UIColor purpleColor];
    returncell.selectionStyle = UITableViewCellSelectionStyleNone;
    return returncell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_foodDisplayArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _searchBar.text = _foodDisplayArray[indexPath.row];
    
    //搜索食物
    //.......
}

@end
