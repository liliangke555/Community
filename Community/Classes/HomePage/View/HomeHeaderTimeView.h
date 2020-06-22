//
//  HomeHeaderTimeView.h
//  Community
//
//  Created by MAC on 2020/6/10.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderTimeView : UIView

@property (nonatomic, copy) NSString *locationString;
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *headerImageString;

@property (nonatomic, strong) NSDate *date;

- (void)didClickLoaction:(void(^)(void))location clickAddiress:(void(^)(BOOL open))address;

@end

@interface TimeView : UIView

@property (strong, nonatomic) NSDate * date;
@property (nonatomic, copy) NSString *string;

@end

NS_ASSUME_NONNULL_END
