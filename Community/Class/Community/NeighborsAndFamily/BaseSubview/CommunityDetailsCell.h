//
//  CommunityDetailsCell.h
//  Community
//
//  Created by MAC on 2020/6/3.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommunityDetailsCell : UITableViewCell

@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, copy) NSString *detailString;
@property (assign, nonatomic) CGFloat detailHeight;

@property (assign, nonatomic) NSInteger likeNum;
@property (assign, nonatomic) NSInteger commNum;
@property (assign, nonatomic) BOOL isLike;

@property (strong, nonatomic) NSMutableArray * imageArray;
@property (assign, nonatomic) CGFloat imageHeight;

@property (assign, nonatomic) BOOL isWeb;
@property (nonatomic, copy) NSString *imageString;
@property (nonatomic, copy) NSString *titleString;

@end

@interface CommunityImageView : UIView

@property (strong, nonatomic) NSMutableArray * iamgeArray;

@end

@interface CommunityWebView : UIView

@property (nonatomic, copy) NSString *imageString;
@property (nonatomic, copy) NSString *titleString;

@end

NS_ASSUME_NONNULL_END
