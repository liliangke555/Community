//
//  LoginSelectView.h
//  Community
//
//  Created by 大菠萝 on 2020/4/21.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginSelectorDelegate <NSObject>

- (void)didSelectedIndex:(NSInteger)index;

@end

@interface LoginSelectView : UIView

@property (nonatomic, strong) NSArray <NSString *>* titles;
//@property (nonatomic, weak) void(^didChange)(NSInteger index);
@property (nonatomic, assign) id <LoginSelectorDelegate> delegate;

+ (instancetype)loginSelectViewWithTitles:(NSArray <NSString *>*)titles;

- (instancetype)initWithTitles:(NSArray *)titles;


@end

NS_ASSUME_NONNULL_END
