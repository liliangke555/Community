//
//  MessageCenterCollectionCell.h
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageCenterCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView * headerImage;
@property (strong, nonatomic) UILabel * titleLabel;
@property (nonatomic, copy) NSString *bageString;

@end

@interface LDBubbleView : UIView

@end

NS_ASSUME_NONNULL_END
