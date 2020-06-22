//
//  PrivacyModel.m
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "PrivacyModel.h"

@implementation PrivacyModel

- (instancetype)initWithTitle:(NSString *)title details:(NSString *)details imae:(NSString *)imageUrl
{
    PrivacyModel *model = [[PrivacyModel alloc] init];
    model.title = title;
    model.details = details;
    model.imageUrl = imageUrl;
    return model;;
}

@end
