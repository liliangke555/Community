//
//  CommunityBaseController.h
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class CommunutyTitleView;
@interface CommunityBaseController : LDBaseViewController

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) CommunutyTitleView * headerView;
@property (strong, nonatomic) NSMutableArray * headerData;
@property (strong, nonatomic) NSMutableArray * dataSource;

- (void)selectedImageIndex:(NSInteger)index row:(NSInteger)row;

@end

NS_ASSUME_NONNULL_END
