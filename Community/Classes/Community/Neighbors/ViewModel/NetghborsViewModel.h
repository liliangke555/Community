//
//  NetghborsViewModel.h
//  Community
//
//  Created by MAC on 2020/6/3.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetghborsViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>

+ (void)refreshWithCallBack:(void(^)(NSArray *))callBack;
+ (void)refreshDataSource;
- (void)didClickWebView:(void(^)(void))didClick;

@end

NS_ASSUME_NONNULL_END
