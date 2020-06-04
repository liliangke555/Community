//
//  CommunityBaseController.m
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "CommunityBaseController.h"
#import "CommunutyTitleView.h"
#import "CommunityDetailsCell.h"

@interface CommunityBaseController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (strong, nonatomic) UITableView * tableView;

@end

@implementation CommunityBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CommunutyTitleView *titleView = [[CommunutyTitleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 102)];
    [self.tableView setTableHeaderView:titleView];
    self.headerView = titleView;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataSource.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailsCell"];
    
    if (indexPath.row % 5 == 0) {
        cell.isWeb = YES;
    } else {
        cell.isWeb = NO;
        if (indexPath.row % 5 == 1) {
            cell.imageArray  = [NSMutableArray arrayWithArray:@[
                    [UIImage imageNamed:@"WechatIMG874"],
                ]];
        }
        if (indexPath.row % 5 == 2) {
            cell.imageArray  = [NSMutableArray arrayWithArray:@[
                    [UIImage imageNamed:@"海报2"],
            ]];
        }
        if (indexPath.row % 5 == 3) {
            cell.imageArray  = [NSMutableArray arrayWithArray:@[
                    [UIImage imageNamed:@"海报2"],
                    [UIImage imageNamed:@"WechatIMG874"],
                    [UIImage imageNamed:@"WechatIMG875"],
                    [UIImage imageNamed:@"WechatIMG876"],
                    [UIImage imageNamed:@"WechatIMG877"],
                    [UIImage imageNamed:@"WechatIMG880"],
                    [UIImage imageNamed:@"WechatIMG881"],
                    [UIImage imageNamed:@"WechatIMG931"],
                    [UIImage imageNamed:@"WechatIMG873"],
            ]];
        }
        if (indexPath.row % 5 == 4) {
            cell.imageArray  = [NSMutableArray arrayWithArray:@[
                    [UIImage imageNamed:@"海报2"],
                    [UIImage imageNamed:@"WechatIMG874"],
                    [UIImage imageNamed:@"WechatIMG875"],
                    [UIImage imageNamed:@"WechatIMG876"],
            ]];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDetailsCell *cell = (CommunityDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];

    return (cell.detailHeight + 110 + cell.imageHeight);
}
#pragma mark - Getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        if (@available(iOS 13.0, *)) {
            _tableView.separatorColor = [UIColor systemBackgroundColor];
        } else {
            // Fallback on earlier versions
            _tableView.separatorColor = [UIColor whiteColor];
        }
        [self.view addSubview:_tableView];
        [_tableView registerClass:[CommunityDetailsCell class] forCellReuseIdentifier:@"detailsCell"];
        _tableView.rowHeight = 240.0f;
    }
    return _tableView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark - Setter

- (void)setHeaderData:(NSMutableArray *)headerData
{
    _headerData = headerData;
    self.headerView.dataSource = [NSMutableArray arrayWithArray:headerData];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat tableHeight = CGRectGetHeight(self.view.bounds) - 49;
    if (HighIPhoneX) {
        tableHeight -= 34;
    }
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), tableHeight);
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
