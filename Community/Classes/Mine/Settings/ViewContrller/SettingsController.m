//
//  SettingsController.m
//  Community
//
//  Created by MAC on 2020/6/1.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "SettingsController.h"
#import "LDSettingsCell.h"
#import <SDWebImage/SDImageCache.h>

@interface SettingsController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIButton * button;

@end

@implementation SettingsController
#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTintColor:RGBACOLOR(71, 71, 71, 1)];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    self.tableView.rowHeight = 64.0f;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.layer setCornerRadius:5.0f];
    [self.view addSubview:button];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setBackgroundColor:RGBACOLOR(242, 242, 242, 1)];
    [button setTitleColor:MainGreenColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelLogin:) forControlEvents:UIControlEventTouchUpInside];
    _button = button;
}
#pragma mark - IBActions

- (void)cancelLogin:(UIButton *)sender
{
    
}
#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[LDSettingsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"账号与安全";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"隐私设置";
        cell.hideLine = NO;
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"清理缓存";
        NSUInteger bytesCache = [[SDImageCache sharedImageCache] totalDiskSize];
        //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
        float MBCache = bytesCache/1000.0f/1000.0f;
        NSString*str = [NSString stringWithFormat:@"%.2fMB", MBCache];
        cell.detailTextLabel.text = str;
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"检测更新";
    }
    if (indexPath.row == 4) {
        cell.textLabel.text = @"关于360社区";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        NSUInteger bytesCache = [[SDImageCache sharedImageCache] totalDiskSize];
        NSString *string = nil;
        if (bytesCache == 0) {
            string = @"还没有缓存,不需要清理哦!";
        } else {
            //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
            float MBCache = bytesCache/1000.0f/1000.0f;
            string = [NSString stringWithFormat:@"缓存大小%.2fM.是否清除缓存?",MBCache];
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                       message:string
                                                                preferredStyle:UIAlertControllerStyleAlert];
        __weak typeof(self)weakSelf = self;
        if (bytesCache != 0) {
            UIAlertAction *yesaction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[SDImageCache sharedImageCache] clearMemory];
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    [weakSelf.tableView reloadData];
                }];
            }];
            [alert addAction:yesaction];
        }
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 88);
    self.button.frame = CGRectMake(16, CGRectGetMaxY(self.tableView.frame), CGRectGetWidth(self.view.frame) - 32, 44);
}

@end
