//
//  CommunityImageCell.m
//  Community
//
//  Created by MAC on 2020/6/4.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "CommunityImageCell.h"

@interface CommunityImageCell ()

@property (strong, nonatomic) UIImageView * backImageView;

@end

@implementation CommunityImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self.layer setCornerRadius:5.0f];
    self.clipsToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    if (@available(iOS 13.0, *)) {
        [imageView setBackgroundColor:[UIColor systemGray4Color]];
    } else {
        // Fallback on earlier versions
    }
    [self addSubview:imageView];
    self.backImageView = imageView;
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.backImageView.image = image;
}
@end
