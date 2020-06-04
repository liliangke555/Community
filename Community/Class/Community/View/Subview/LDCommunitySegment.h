//
//  LDCommunitySegment.h
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDCommunitySegment : UIView

@property (assign, nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) CGFloat contentOffX;
@property (nonatomic, copy) void(^didChengeSelected)(NSInteger index);

+ (instancetype)segmentWithTitles:(NSArray <NSString *>*)titles;

@end

@interface LDPointView : UIView

@end

NS_ASSUME_NONNULL_END
