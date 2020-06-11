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
@property (assign, nonatomic) BOOL isReal;
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

@property (nonatomic, copy) void(^didClickWeb)(void);

- (void)didReviewImage:(void(^)(UICollectionView *collectionView,NSInteger index))review;
- (id)viewAtIndex:(NSInteger)index;

@end

@interface CommunityImageView : UIView

@property (strong, nonatomic) UICollectionView * coll;
@property (strong, nonatomic) NSMutableArray * imageArray;
- (void)selectedReviewImage:(void(^)(UIImageView *imageView,NSInteger index))review;

@end

@interface CommunityWebView : UIView

@property (nonatomic, copy) NSString *imageString;
@property (nonatomic, copy) NSString *titleString;

@property (nonatomic, copy) void(^didClick)(void);

@end

NS_ASSUME_NONNULL_END
