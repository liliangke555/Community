//
//  CommunityImageCell.h
//  Community
//
//  Created by MAC on 2020/6/4.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommunityImageCell : UICollectionViewCell

@property (strong, nonatomic) UIImage * image;
@property (strong, nonatomic) UIImageView * backImageView;

@property (strong, nonatomic) id data;

@end

NS_ASSUME_NONNULL_END
