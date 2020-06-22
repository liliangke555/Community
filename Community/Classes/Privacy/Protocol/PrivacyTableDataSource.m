//
//  PrivacyTableDataSource.m
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "PrivacyTableDataSource.h"
#import "PrivacyModel.h"

#import "PrivacyViewCell.h"

@implementation PrivacyTableDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 88)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 32)];
    [view addSubview:titleLabel];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [titleLabel setText:@"360社区"];
    
    UILabel *suTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(tableView.frame), 56)];
    [suTitle setFont:[UIFont systemFontOfSize:12]];
    [suTitle setTextColor:RGBACOLOR(183, 183, 183, 1)];
    [suTitle setNumberOfLines:0];
    [suTitle setText:@"为了给您提供更好的社区家庭服务，360社区需要获取您的以下权限和信息"];
    [view addSubview:suTitle];
    return view;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 88)];
//    view.backgroundColor = [UIColor whiteColor];
//
//    return view;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 88;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 88.0f;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrivacyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[PrivacyViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    PrivacyModel *model = self.array[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.details;
    cell.imageView.image = [UIImage imageNamed:@"tabbar3_selected"];
//    cell.titleLabel.text=((CustomModel *)[_array objectAtIndex:indexPath.row]).title;
    return cell;
}
@end
