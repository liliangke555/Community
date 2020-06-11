//
//  CommunityListModel.h
//  Community
//
//  Created by MAC on 2020/6/5.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommunityListModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) BOOL isReal;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, strong) NSArray *images;

@property (nonatomic, copy) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
