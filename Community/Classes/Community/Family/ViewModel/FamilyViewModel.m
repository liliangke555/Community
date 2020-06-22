//
//  FamilyViewModel.m
//  Community
//
//  Created by MAC on 2020/6/3.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "FamilyViewModel.h"
#import "CommunityHeaderModel.h"

@implementation FamilyViewModel

+ (void)refreshWithCallBack:(void (^)(NSArray * _Nonnull))callBack
{
    CommunityHeaderModel *model = [[CommunityHeaderModel alloc] init];
    model.image = @"lock.shield.fill";
    model.bage = @"6";
    model.title = @"家庭保险";
    
    CommunityHeaderModel *model1 = [[CommunityHeaderModel alloc] init];
    model1.image = @"yensign.circle.fill";
    model1.bage = @"优惠券";
    model1.title = @"家庭理财";
    
    CommunityHeaderModel *model2 = [[CommunityHeaderModel alloc] init];
    model2.image = @"tv.circle.fill";
    model2.title = @"家庭设备";
    
    CommunityHeaderModel *model3 = [[CommunityHeaderModel alloc] init];
    model3.image = @"person.2.square.stack.fill";
    model3.title = @"家庭相册";
    
    if (callBack) {
        callBack(@[model,model1,model2,model3]);
    }
}

@end
