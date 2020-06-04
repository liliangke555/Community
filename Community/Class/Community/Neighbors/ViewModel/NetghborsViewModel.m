//
//  NetghborsViewModel.m
//  Community
//
//  Created by MAC on 2020/6/3.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "NetghborsViewModel.h"
#import "CommunityHeaderModel.h"

@implementation NetghborsViewModel

+ (void)refreshWithCallBack:(void (^)(NSArray * _Nonnull))callBack
{
    CommunityHeaderModel *model = [[CommunityHeaderModel alloc] init];
    model.image = @"bag.fill";
    model.bage = @"99+";
    model.title = @"社区电商";
    
    CommunityHeaderModel *model1 = [[CommunityHeaderModel alloc] init];
    model1.image = @"creditcard.fill";
    model1.bage = @"55";
    model1.title = @"物业缴费";
    
    CommunityHeaderModel *model2 = [[CommunityHeaderModel alloc] init];
    model2.image = @"rosette";
    model2.bage = @"优惠券";
    model2.title = @"生活服务";
    
    CommunityHeaderModel *model3 = [[CommunityHeaderModel alloc] init];
    model3.image = @"table.badge.more.fill";
    model3.bage = @"NEW";
    model3.title = @"更多服务";
    
    if (callBack) {
        callBack(@[model,model1,model2,model3]);
    }
}

@end
