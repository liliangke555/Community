//
//  SettingsUserController.m
//  Community
//
//  Created by MAC on 2020/6/1.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "SettingsUserController.h"
#import "SettingHeaderCell.h"
#import "SettingsUserCell.h"

@interface SettingsUserController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SettingsUserController
#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTintColor:RGBACOLOR(71, 71, 71, 1)];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    self.titleString = @"编辑资料";
    self.subTitle = @"编辑个人信息";
    
    self.tableView.rowHeight = 100;
    [self.tableView registerClass:[SettingsUserCell class] forCellReuseIdentifier:@"userCell"];
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100;
    } else {
        return 64;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SettingHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imagecell"];
        if (!cell) {
            cell = [[SettingHeaderCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"imagecell"];
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.detailTextLabel setText:@"更换头像"];
        return cell;
    } else {
        SettingsUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"昵称";
            cell.subTitleLabel.text = @"大菠萝";
        }
        if (indexPath.row == 2) {
            cell.titleLabel.text = @"个性签名";
            cell.subTitleLabel.text = @"介绍下自己吧";
            cell.subTitleLabel.textColor = RGBACOLOR(163, 165, 164, 1);
        }
        if (indexPath.row == 3) {
            cell.titleLabel.text = @"其他信息";
//            cell.subTitleLabel.text = @"大菠萝";
        }
        return cell;;
    }
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
