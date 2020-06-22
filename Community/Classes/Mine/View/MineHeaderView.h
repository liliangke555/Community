//
//  MineHeaderView.h
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderView : UIView

@property (nonatomic, copy) void(^didTapView)(void);

@end

NS_ASSUME_NONNULL_END
