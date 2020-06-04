//
//  MineViewController.m
//  Test
//
//  Created by Yue Zhang on 2020/3/23.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MessageCenterController.h"
#import "SettingsController.h"
#import "SettingsUserController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MineHeaderView *headerView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"我的";
    
//    [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
//
//    }];
    [self tableView];
    [self headerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"call"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"家人管理";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"消息中心";
    } else {
        cell.textLabel.text = @"设置";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        MessageCenterController *vc = [[MessageCenterController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        SettingsController *vc = [SettingsController new];
        vc.titleString  = @"设置";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - Getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 320, SCREEN_WIDTH, CGRectGetHeight(self.view.frame) - 320) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.rowHeight = AutoSizeScaleX * 44;
//        _tableView.sectionHeaderHeight = 88.0f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (MineHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
        [self.view addSubview:_headerView];
        __weak typeof(self)weakSelf = self;
        [_headerView setDidTapView:^{
            SettingsUserController *vc = [[SettingsUserController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _headerView;
}
#pragma mark - Layout
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    self.tableView.frame = CGRectMake(0, 320, SCREEN_WIDTH, CGRectGetHeight(self.view.frame) - 320);
}
@end
