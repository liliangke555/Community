//
//  PrivacyController.m
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "PrivacyController.h"
#import "PrivacyTableDataSource.h"
#import "LoginButton.h"
#import "PrivacyViewModel.h"

@interface PrivacyController ()
@property (nonatomic, strong) PrivacyTableDataSource *tableViewDataSource;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) LoginButton *agreeButton;

@property (nonatomic, strong) UILabel *detailsLabel;

@property (nonatomic, strong) PrivacyViewModel *viewModel;

@end

@implementation PrivacyController
#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.detailsLabel setText:@"您也可以在系统设置中关闭权限，但可能会影响部分功能使用。请在使用前查看并同意 隐私权政策 及 服务条款"];
    [self.agreeButton setTitle:@"同意并继续" forState:UIControlStateNormal];
    [self.backButton setTitle:@"跳过" forState:UIControlStateNormal];
    [self refreshView];
}

- (void)refreshView
{
    __weak typeof(self)weakSelf = self;
    [self.viewModel requestWithCallback:^(NSArray * _Nonnull array) {
        weakSelf.tableViewDataSource.array = array;
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - IBActions
- (void)agreeButtonAction:(UIButton *)sender
{
    
}
- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Getter
- (PrivacyTableDataSource *)tableViewDataSource
{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [[PrivacyTableDataSource alloc]init];
    }
    return _tableViewDataSource;;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self.tableViewDataSource;
        _tableView.delegate = self.tableViewDataSource;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.rowHeight = 60.0f;
        _tableView.sectionHeaderHeight = 88.0f;
    }
    return _tableView;
}
- (UILabel *)detailsLabel
{
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc] init];
            [_detailsLabel setFont:[UIFont systemFontOfSize:12]];
        //    [suTitle setTextColor:RGBACOLOR(183, 183, 183, 1)];
            [_detailsLabel setNumberOfLines:0];
        [self.view addSubview:_detailsLabel];
    }
    return _detailsLabel;
}

- (LoginButton *)agreeButton
{
    if (!_agreeButton) {
        _agreeButton = [LoginButton buttonWithType:UIButtonTypeCustom];
        _agreeButton.backgroundColor = RGBACOLOR(35, 193, 110, 1);
        [_agreeButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_agreeButton];
    }
    return _agreeButton;
}
- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setTitleColor:RGBACOLOR(143, 143, 143, 1) forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
    }
    return _backButton;
}

- (PrivacyViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[PrivacyViewModel alloc] init];
        
    }
    return _viewModel;
}
#pragma mark - Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.backButton.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - 100, 8, 88, 40);
    self.tableView.frame = CGRectMake(32, 64, CGRectGetWidth(self.view.frame) - 64, CGRectGetHeight(self.view.frame) - 64 - 88 - 32);
    self.detailsLabel.frame = CGRectMake(32, CGRectGetMaxY(self.tableView.frame), CGRectGetWidth(self.tableView.frame), 35);
    self.agreeButton.frame = CGRectMake(32, CGRectGetMaxY(self.detailsLabel.frame)+16, CGRectGetWidth(self.tableView.frame), 44);
}

@end
