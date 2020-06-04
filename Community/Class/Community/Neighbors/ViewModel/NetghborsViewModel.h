//
//  NetghborsViewModel.h
//  Community
//
//  Created by MAC on 2020/6/3.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetghborsViewModel : NSObject

+ (void)refreshWithCallBack:(void(^)(NSArray *))callBack;

@end

NS_ASSUME_NONNULL_END
