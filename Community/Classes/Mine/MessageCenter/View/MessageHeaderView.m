//
//  MessageHeaderView.m
//  Community
//
//  Created by 大菠萝 on 2020/4/23.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "MessageHeaderView.h"
#import "UIView+CornerCliper.h"
#import "MessageCenterCollectionCell.h"

@implementation MessageHeaderView

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
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, CGRectGetWidth(self.frame) - 32 - 100, 32)];
    [self addSubview:title];
    [title setText:@"消息中心"];
    [title setFont:[UIFont boldSystemFontOfSize:20]];
    [title setTextColor:[UIColor whiteColor]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"一键已读" forState:UIControlStateNormal];
    button.frame = CGRectMake(CGRectGetWidth(self.frame) - 116, CGRectGetMidY(title.frame) - 12, 100, 24);
    [button.layer setCornerRadius:12];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button setBackgroundColor:RGBACOLOR(93, 110, 126, 1)];
    [self addSubview:button];
    [button setImage:[UIImage imageNamed:@"tabbar2_selected"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    {
        MessageTitleView *titleView = [[MessageTitleView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame) + 16, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 54)];
        [self addSubview:titleView];
        [titleView setBackgroundColor:[UIColor whiteColor]];
        [titleView clipCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:10.0f];
    }
    
}

- (void)buttonAction:(UIButton *)sender
{
    
}


@end

@interface MessageTitleView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation MessageTitleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}

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
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (SCREEN_WIDTH - 5*16) / 4;
    CGFloat itemH = CGRectGetHeight(self.frame) - 26;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.sectionInset = UIEdgeInsetsMake(8, 16, 8, 16);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 16;
    flowLayout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    if (@available(iOS 13.0, *)) {
        collectionView.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        // Fallback on earlier versions
    }
    
     [collectionView registerClass:[MessageCenterCollectionCell class] forCellWithReuseIdentifier:@"TTQVideoListCell"];
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCenterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TTQVideoListCell" forIndexPath:indexPath];
    UIImage *image = nil;
    NSString *string = nil;
    if (indexPath.row == 0) {
        if (@available(iOS 13.0, *)) {
            image = [UIImage systemImageNamed:@"bell.fill"];
        } else {
            // Fallback on earlier versions
        }
        string = @"通知";
    }
    if (indexPath.row == 1) {
        if (@available(iOS 13.0, *)) {
            image = [UIImage systemImageNamed:@"pencil.and.outline"];
        } else {
            // Fallback on earlier versions
        }
        string = @"评论";
    }
    if (indexPath.row == 2) {
        if (@available(iOS 13.0, *)) {
            image = [UIImage systemImageNamed:@"heart.fill"];
        } else {
            // Fallback on earlier versions
        }
        string = @"喜欢";
    }
    if (indexPath.row == 3) {
        if (@available(iOS 13.0, *)) {
            image = [UIImage systemImageNamed:@"arrowshape.turn.up.right.fill"];
        } else {
            // Fallback on earlier versions
        }
        string = @"分享";
    }
    [cell.headerImage setImage:image];
    [cell.titleLabel setText:string];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

}
@end
