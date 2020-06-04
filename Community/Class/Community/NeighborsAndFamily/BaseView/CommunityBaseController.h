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

@property (strong, nonatomic) CommunutyTitleView * headerView;
@property (strong, nonatomic) NSMutableArray * headerData;
@property (strong, nonatomic) NSMutableArray * dataSource;

@end

NS_ASSUME_NONNULL_END
