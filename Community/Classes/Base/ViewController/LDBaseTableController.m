//
//  LDBaseTableController.m
//  Community
//
//  Created by MAC on 2020/6/1.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LDBaseTableController.h"
#import "UIView+CornerCliper.h"

@interface LDBaseTableController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>


@end

@implementation LDBaseTableController
#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    [self setUpView];
}

- (void)setUpView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 64)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMidY(titleView.bounds) - 28, CGRectGetWidth(titleView.bounds)- 32, 20)];
    [titleLabel setText:_titleString];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [titleView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    self.titleBackView = titleView;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(titleView.frame) - 10, CGRectGetWidth(titleView.frame), 10)];
    [bottomView clipCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:10];
    bottomView.backgroundColor = [UIColor whiteColor];
    [titleView addSubview:bottomView];
    
    if (@available(iOS 13.0, *)) {
        [titleView setBackgroundColor:[UIColor systemBackgroundColor]];
        [titleLabel setTextColor:[UIColor labelColor]];
        [bottomView setBackgroundColor:[UIColor systemBackgroundColor]];
    } else {
        // Fallback on earlier versions
        [titleView setBackgroundColor:[UIColor whiteColor]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [bottomView setBackgroundColor:[UIColor whiteColor]];
    }
    
    [self.tableView setTableHeaderView:titleView];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= 32) {
        self.navigationItem.title = self.titleLabel.text;
    } else {
        self.navigationItem.title = @"";
    }
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
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
        _tableView.separatorColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - Setter

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.titleLabel.text = titleString;
}

- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    if (subTitle && ![subTitle isEqualToString:@""]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.titleLabel.frame) + 5, CGRectGetWidth(self.titleBackView.bounds) - 32, 17)];
        [label setText:_subTitle];
        [label setFont:[UIFont systemFontOfSize:11]];
        [self.titleBackView addSubview:label];
        [label setTextColor:[UIColor grayColor]];
    }
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
}

- (void)dealloc
{
    NSLog(@"%@---dealloc",NSStringFromClass([self class]));
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
