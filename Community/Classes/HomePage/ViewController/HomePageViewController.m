//
//  HomePageViewController.m
//  Test
//
//  Created by Yue Zhang on 2020/3/23.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeHeaderTimeView.h"
#import "HomeSegmentScrollView.h"
#import "HomeTableView.h"
#import <Flutter/Flutter.h>

@interface HomePageViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) HomeHeaderTimeView * headerView;
@property (strong, nonatomic) UIView * secendView;
@property (strong, nonatomic) UIScrollView * backScrollView;

@property (strong, nonatomic) HomeSegmentScrollView * segmentScrollView;

@property (strong, nonatomic) HomeTableView * tabOne;
@property (strong, nonatomic) HomeTableView * tabTwo;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeStatus) name:@"shop_home_leaveTop" object:nil];
}

-(void)changeStatus{
    
//    self.canScroll = YES;
    self.tabOne.canScroll = NO;
    self.tabTwo.canScroll = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)setupView
{
    UIView *view = [[UIView alloc] init];
    [self.backScrollView addSubview:view];
    self.secendView = view;
    view.backgroundColor = [UIColor redColor];
    
    HomeTableView *tab = [[HomeTableView alloc] init];
    [self.segmentScrollView addSubview:tab];
    self.tabOne = tab;
    tab.delegate = self;
    tab.dataSource = self;
    tab.tag = 100;
    tab.canScroll = NO;
    
    HomeTableView *tab1 = [[HomeTableView alloc] init];
    [self.segmentScrollView addSubview:tab1];
    self.tabTwo = tab1;
    tab1.delegate = self;
    tab1.dataSource = self;
    tab1.tag = 101;
    tab1.canScroll = NO;
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%.2f",scrollView.contentOffset.y);
    if (scrollView.tag == 100 || scrollView.tag == 101) {
        if (!self.tabOne.canScroll) {
            scrollView.contentOffset = CGPointZero;
        }
        if (scrollView.contentOffset.y <= 0 ) {
            self.tabOne.canScroll = NO;
            scrollView.contentOffset = CGPointZero;
            [self changeStatus];
        }
        scrollView.showsVerticalScrollIndicator = self.tabOne.canScroll?YES:NO;
    } else {
    
        CGFloat bottomCellOffset = 383;
        if (scrollView.contentOffset.y >= bottomCellOffset) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            self.tabOne.canScroll = YES;
            self.tabTwo.canScroll = YES;

        } else {
 
            if (self.tabOne.canScroll == YES) {
                scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            }
        }
    }
}

#pragma mark - Getter

- (HomeHeaderTimeView *)headerView
{
    if (!_headerView) {
        _headerView = [[HomeHeaderTimeView alloc] init];
        [self.backScrollView addSubview:_headerView];
        [_headerView didClickLoaction:^{
            NSLog(@"---点击了定位---");
            FlutterViewController *flutterVC = [[FlutterViewController alloc]initWithProject:nil nibName:nil bundle:nil];
            flutterVC.title = @"我是Flutter页面";
            [self.navigationController pushViewController:flutterVC animated:YES];
        } clickAddiress:^(BOOL open) {
            NSLog(@"---点击了小区地址---");
        }];
    }
    return _headerView;
}

- (UIScrollView *)backScrollView
{
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] init];
//        _backScrollView.bounces = NO;
        _backScrollView.delegate = self;
//        _backScrollView.pagingEnabled = YES;
        [self.view addSubview:_backScrollView];
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.showsVerticalScrollIndicator = NO;

    }
    return _backScrollView;
}

- (HomeSegmentScrollView *)segmentScrollView
{
    if (!_segmentScrollView) {
        _segmentScrollView = [[HomeSegmentScrollView alloc] init];
        _segmentScrollView.bounces = NO;
//        _segmentScrollView.delegate = self;
        _segmentScrollView.pagingEnabled = YES;
        [self.backScrollView addSubview:_segmentScrollView];
//        _backScrollView.showsHorizontalScrollIndicator = NO;
//        _backScrollView.showsVerticalScrollIndicator = NO;
        _segmentScrollView.scrollsToTop = NO;
        _segmentScrollView.backgroundColor = [UIColor grayColor];
    }
    return _segmentScrollView;
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
    self.backScrollView.frame = self.view.bounds;
    self.backScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 200 + 500);
    self.secendView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), CGRectGetWidth(self.view.frame), 300);
    
    self.segmentScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.secendView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 200);
    self.segmentScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 2, CGRectGetHeight(self.view.frame) - 200);
    
    self.tabOne.frame = CGRectMake(0, 0, CGRectGetWidth(self.segmentScrollView.frame), CGRectGetHeight(self.segmentScrollView.frame));
    self.tabTwo.frame = CGRectMake(CGRectGetWidth(self.segmentScrollView.frame), 0, CGRectGetWidth(self.segmentScrollView.frame), CGRectGetHeight(self.segmentScrollView.frame));
}

@end
