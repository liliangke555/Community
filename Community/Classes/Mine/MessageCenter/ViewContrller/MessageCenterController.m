//
//  MessageCenterController.m
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "MessageCenterController.h"
#import "MessageHeaderView.h"
#import "MessageCenterNotiCell.h"
#import "MessageCenterCommunityNoticeCell.h"

@interface MessageCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MessageHeaderView *headerView;
@property (strong, nonatomic) UITableView * tableView;

@end

@implementation MessageCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (@available(iOS 13.0, *)) {
        UIColor *color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
                return RGBACOLOR(0, 0, 0, 1);
            }
            return RGBACOLOR(85, 103, 122, 1);
        }];
        self.view.backgroundColor = color;
        [self.navigationController.navigationBar setBarTintColor:color];
    } else {
        // Fallback on earlier versions
        self.view.backgroundColor = RGBACOLOR(85, 103, 122, 1);
        [self.navigationController.navigationBar setBarTintColor:RGBACOLOR(85, 103, 122, 1)];
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self headerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 74;
    }
    return 180;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MessageCenterNotiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotiCel"];
        return cell;
    }
    MessageCenterCommunityNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityNotice"];
    return cell;
}

#pragma mark - Getter

- (MessageHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[MessageHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 156)];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[MessageCenterNotiCell class] forCellReuseIdentifier:@"NotiCel"];
        [_tableView setTableFooterView:[UIView new]];
        [_tableView registerClass:[MessageCenterCommunityNoticeCell class] forCellReuseIdentifier:@"CommunityNotice"];
        if (@available(iOS 13.0, *)) {
            [_tableView setSeparatorColor:[UIColor systemBackgroundColor]];
        } else {
            // Fallback on earlier versions
            [_tableView setSeparatorColor:[UIColor whiteColor]];
        }
    }
    return _tableView;
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.headerView.frame));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
