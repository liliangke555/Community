//
//  LDBaseTableController.h
//  Community
//
//  Created by MAC on 2020/6/1.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDBaseTableController : UIViewController

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *subTitle;

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UIView * titleBackView;

@end

NS_ASSUME_NONNULL_END
