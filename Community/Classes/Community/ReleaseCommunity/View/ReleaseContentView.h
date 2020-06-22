//
//  ReleaseContentView.h
//  Community
//
//  Created by MAC on 2020/6/8.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReleaseContentView : UIView

@property (strong, nonatomic) NSMutableArray * dataSource;

- (void)reloadData;

- (void)didClickAdd:(void(^)(void))clickAdd;
- (void)didClickImageView:(void(^)(NSInteger index))click;
- (void)didDeleted:(void(^)(NSInteger index))deleted;
- (void)changeItemIndex:(void(^)(NSInteger index ,NSInteger toIndex))change;

@end

NS_ASSUME_NONNULL_END
