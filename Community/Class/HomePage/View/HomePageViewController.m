//
//  HomePageViewController.m
//  Test
//
//  Created by Yue Zhang on 2020/3/23.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeHeaderTimeView.h"

@interface HomePageViewController ()

@property (strong, nonatomic) HomeHeaderTimeView * headerView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - Getter

- (HomeHeaderTimeView *)headerView
{
    if (!_headerView) {
        _headerView = [[HomeHeaderTimeView alloc] init];
        [self.view addSubview:_headerView];
        [_headerView didClickLoaction:^{
            NSLog(@"---点击了定位---");
        } clickAddiress:^(BOOL open) {
            NSLog(@"---点击了小区地址---");
        }];
    }
    return _headerView;
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
}

@end
