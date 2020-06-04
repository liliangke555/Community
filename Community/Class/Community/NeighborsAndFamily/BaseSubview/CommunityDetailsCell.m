//
//  CommunityDetailsCell.m
//  Community
//
//  Created by MAC on 2020/6/3.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "CommunityDetailsCell.h"
#import "NSString+StringSize.h"

#import "CommunityImageCell.h"

@interface CommunityDetailsCell ()

@property (strong, nonatomic) UIImageView * headerImage;
@property (strong, nonatomic) UILabel * nameLabel;
@property (strong, nonatomic) UIButton * realButton;
@property (strong, nonatomic) UILabel * timeLabel;
@property (strong, nonatomic) UILabel * detailsLabel;
@property (strong, nonatomic) UIButton * likeButton;
@property (strong, nonatomic) UIButton * comButton;
@property (strong, nonatomic) UIButton * shareButton;
@property (strong, nonatomic) UIButton * moreButton;
@property (strong, nonatomic) CommunityImageView * imageViewData;
@property (strong, nonatomic) CommunityWebView * webView;

@end

static CGFloat const NameFont = 16.0f;
static CGFloat const realNameHeight = 12.0f;
static CGFloat const headerImageSize = 32.0f;
static CGFloat const DetailFont = 14.0f;
static CGFloat const TimeFont = 12.0f;
static CGFloat const LeftSpacing = 16.0f;

@implementation CommunityDetailsCell
#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupView];
}
#pragma mark - SetupView
- (void)setupView
{
    //头像
    UIImageView *headerImage = [[UIImageView alloc] init];
    [self addSubview:headerImage];
    self.headerImage = headerImage;
    [headerImage.layer setCornerRadius:headerImageSize / 2.0f];
    if (@available(iOS 13.0, *)) {
        [headerImage setImage:[UIImage systemImageNamed:@"person"]];
        [headerImage setBackgroundColor:[UIColor systemGray5Color]];
    } else {
        // Fallback on earlier versions
    }
    [headerImage setContentMode:UIViewContentModeCenter];
    
    // 名字label
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    [nameLabel setFont:[UIFont boldSystemFontOfSize:NameFont]];
    self.nameString = @"大菠萝的大菠萝";
    
    // 已实名
    UIButton *realButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:realButton];
    self.realButton = realButton;
    UIImage *bimage = nil;
    if (@available(iOS 13.0, *)) {
        bimage = [UIImage systemImageNamed:@"checkmark.shield.fill"];
    } else {
        // Fallback on earlier versions
    }
    [realButton setImage:bimage forState:UIControlStateNormal];
    [realButton setBackgroundColor:MainGreenColor];
    [realButton setTitle:@"已实名" forState:UIControlStateNormal];
    [realButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [realButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [realButton.layer setCornerRadius:realNameHeight / 2.0f];
    
    UILabel *time = [[UILabel alloc] init];
    [time setFont:[UIFont systemFontOfSize:TimeFont]];
    if (@available(iOS 13.0, *)) {
        [time setTextColor:[UIColor systemGray3Color]];
    } else {
        // Fallback on earlier versions
    }
    [self addSubview:time];
    self.timeLabel  = time;
    [time setTextAlignment:NSTextAlignmentRight];
    self.timeString = @"9小时前";
    
    UILabel *details = [[UILabel alloc] init];
    [self addSubview:details];
    self.detailsLabel = details;
    [details setFont:[UIFont systemFontOfSize:DetailFont]];
    [details setNumberOfLines:0];
    self.detailString = @"嶌葵が今までに歌った作品群とはガラリと世界感が異なる詞世界。「このまま世界が消えてもわたしの命はあなたと」赤い糸に導かれた運命を歌う、渾身のバラード。2017年1月8日(日)スタートする瀬戸朝香主演 NHKのプレミアムドラマ『女の中にいる他人』の主題歌。";
    
    UIColor *color = RGBACOLOR(96, 99, 97, 1);
    UIButton *like = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:like];
    self.likeButton = like;
    UIImage *image = nil;
    UIImage *selectedImage = nil;
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:@"heart"];
        selectedImage = [UIImage systemImageNamed:@"heart.fill"];
    } else {
        // Fallback on earlier versions
    }
    [like.titleLabel setFont:[UIFont systemFontOfSize:TimeFont]];
    [like setImage:image forState:UIControlStateNormal];
    [like setImage:selectedImage forState:UIControlStateSelected];
    [like setTitleColor:color forState:UIControlStateNormal];
    [like setTitleColor:color forState:UIControlStateSelected];
    like.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [like addTarget:self action:@selector(likeDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.likeNum = 34;
    
    UIButton *com = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:com];
    self.comButton = com;
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:@"pencil.and.outline"];
    } else {
        // Fallback on earlier versions
    }
    [com.titleLabel setFont:[UIFont systemFontOfSize:TimeFont]];
    [com setImage:image forState:UIControlStateNormal];
    [com setTitleColor:color forState:UIControlStateNormal];
    com.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [com addTarget:self action:@selector(comDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.commNum = 59;
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:share];
    self.shareButton = share;
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:@"arrowshape.turn.up.right"];
    } else {
        // Fallback on earlier versions
    }
    [share.titleLabel setFont:[UIFont systemFontOfSize:TimeFont]];
    [share setImage:image forState:UIControlStateNormal];
    [share setTitleColor:color forState:UIControlStateNormal];
    share.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [share addTarget:self action:@selector(shareDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [share setTitle:@"分享" forState:UIControlStateNormal];
    
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:more];
    self.moreButton = more;
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:@"ellipsis"];
    } else {
        // Fallback on earlier versions
    }
    [more.titleLabel setFont:[UIFont systemFontOfSize:TimeFont]];
    [more setImage:image forState:UIControlStateNormal];
    [more setTitleColor:color forState:UIControlStateNormal];
    more.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [more addTarget:self action:@selector(moreDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //图片容器
    CommunityImageView *view = [[CommunityImageView alloc] init];
    [self addSubview:view];
    self.imageViewData = view;
    
    CommunityWebView *webView = [[CommunityWebView alloc] init];
    [self addSubview:webView];
    self.webView = webView;
    webView.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headerImage.frame = CGRectMake(LeftSpacing, 16, headerImageSize, headerImageSize);
    
    CGFloat nameWidth = [self.nameString getWidthWithHeight:24 font:NameFont];
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImage.frame) + 8, CGRectGetMidY(self.headerImage.frame) - 12, nameWidth, 24);
    
    
    self.realButton.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame), CGRectGetMidY(self.nameLabel.frame) - realNameHeight / 2.0f, 56, realNameHeight);
    
    CGFloat timeWidth = [self.timeString getWidthWithHeight:24 font:TimeFont];
    self.timeLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - timeWidth - 16, CGRectGetMidY(self.headerImage.frame) - 12, timeWidth, 24);
    
    
    self.detailsLabel.frame = CGRectMake(CGRectGetMinX(self.headerImage.frame), CGRectGetMaxY(self.headerImage.frame) + 8, CGRectGetWidth(self.frame) - 32, _detailHeight);
    
    self.likeButton.frame = CGRectMake(LeftSpacing, CGRectGetHeight(self.frame) - 30 - 16, 70, 30);
    self.comButton.frame = CGRectMake(CGRectGetMaxX(self.likeButton.frame), CGRectGetMinY(self.likeButton.frame), 70, 30);
    self.shareButton.frame = CGRectMake(CGRectGetMaxX(self.comButton.frame), CGRectGetMinY(self.likeButton.frame), 70, 30);
    self.moreButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 86, CGRectGetMinY(self.likeButton.frame), 70, 30);
    CGFloat width = CGRectGetWidth(self.frame);
    if (self.imageArray.count == 4) {
        width -= (_imageHeight - 4) / 2.0f;
    }
    self.imageViewData.frame = CGRectMake(0, CGRectGetMaxY(self.detailsLabel.frame) + 8, width, _imageHeight);
    
    self.webView.frame = CGRectMake(LeftSpacing, CGRectGetMaxY(self.detailsLabel.frame) + 8, CGRectGetWidth(self.frame) - LeftSpacing * 2, _imageHeight-8);
}
#pragma mark - Helper Handle
- (void)likeDidClick:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    _isLike = sender.isSelected;
    if (sender.selected) {
        self.likeNum += 1;
    } else {
        self.likeNum -= 1;
    }
}

- (void)comDidClick:(UIButton *)sender
{
    
}
- (void)shareDidClick:(UIButton *)sender
{
    
}
-(void)moreDidClick:(UIButton *)sender
{
    
}
#pragma mark - Setter
- (void)setIsLike:(BOOL)isLike
{
    _isLike = isLike;
    self.likeButton.selected = isLike;
}
- (void)setLikeNum:(NSInteger)likeNum
{
    _likeNum = likeNum;
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",(long)likeNum] forState:UIControlStateNormal];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",(long)likeNum] forState:UIControlStateSelected];
}
- (void)setCommNum:(NSInteger)commNum
{
    _commNum = commNum;
    [self.comButton setTitle:[NSString stringWithFormat:@"%ld",(long)commNum] forState:UIControlStateNormal];
}
- (void)setDetailString:(NSString *)detailString
{
    _detailString = detailString;
    self.detailsLabel.text = detailString;
    CGFloat detailHeight = [detailString getLabelHeightWithWidth:SCREEN_WIDTH - 32 font:DetailFont];
    _detailHeight = detailHeight;
}
- (void)setNameString:(NSString *)nameString
{
    _nameString = nameString;
    self.nameLabel.text = nameString;
}
- (void)setTimeString:(NSString *)timeString
{
    _timeString = timeString;
    self.timeLabel.text = timeString;
}
- (void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = [imageArray mutableCopy];
    self.imageViewData.iamgeArray = imageArray;
    if (imageArray.count == 1) {
        UIImage *image = imageArray[0];
        CGSize imageSize = image.size;
        if (imageSize.width > imageSize.height) {
            CGFloat maxWidth = (SCREEN_WIDTH - (LeftSpacing * 2)) / 2.0f;
            _imageHeight = maxWidth * imageSize.height / imageSize.width + 8;
        } else {
            CGFloat maxWidth = (SCREEN_WIDTH - (LeftSpacing * 2)) / 2.0f + 8;
            _imageHeight = maxWidth;
        }
    } else if (imageArray.count == 2 || imageArray.count == 3) {
        _imageHeight = (SCREEN_WIDTH - (LeftSpacing * 2) - 8) / 3.0f + 8;
    } else if (imageArray.count == 4 || imageArray.count <= 6){
        _imageHeight = ((SCREEN_WIDTH - LeftSpacing * 2 - 8) / 3.0f) * 2 + 4 + 8;
    } else {
        _imageHeight = ((SCREEN_WIDTH - LeftSpacing * 2 - 8) / 3.0f) * 3 + 8 + 8;
    }
}

- (void)setIsWeb:(BOOL)isWeb
{
    _isWeb = isWeb;
    if (isWeb) {
        _imageHeight = 58;
        self.imageViewData.hidden = YES;
        self.webView.hidden = NO;
    } else {
        self.imageViewData.hidden = NO;
        self.webView.hidden = YES;
    }
}
 - (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.webView.titleString = titleString;
}
- (void)setImageString:(NSString *)imageString
{
    _imageString = imageString;
    self.webView.imageString = imageString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

#pragma mark -

@interface CommunityImageView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView * coll;

@end

@implementation CommunityImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
#pragma mark - SetupView
- (void)setupView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    CGFloat itemW = (SCREEN_WIDTH - 5*16) / 4;
//    CGFloat itemH = CGRectGetHeight(self.frame) - 26;
//    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 4;
    flowLayout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
//    collectionView.la
    if (@available(iOS 13.0, *)) {
        collectionView.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        // Fallback on earlier versions
    }
    collectionView.scrollEnabled = NO;
     [collectionView registerClass:[CommunityImageCell class] forCellWithReuseIdentifier:@"CommunityImageCell"];
    
    [self addSubview:collectionView];
    self.coll = collectionView;
}
#pragma mark - UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.iamgeArray.count == 1) {
        CGFloat imageHeight = 0;
        CGFloat maxWidth = (SCREEN_WIDTH - (LeftSpacing * 2)) / 2.0f;
        UIImage *image = self.iamgeArray[indexPath.row];
            CGSize imageSize = image.size;
            if (imageSize.width > imageSize.height) {
                imageHeight = maxWidth * imageSize.height  / imageSize.width;
            } else {
                imageHeight = maxWidth;
                maxWidth = imageHeight * imageSize.width  / imageSize.height;
            }
        return CGSizeMake(maxWidth, imageHeight);
    }
    CGFloat width = (SCREEN_WIDTH - 32 - 8) / 3.0;
    return CGSizeMake(width, width);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.iamgeArray.count > 9 ? 9 : self.iamgeArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommunityImageCell" forIndexPath:indexPath];
    cell.image = self.iamgeArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

}
#pragma mark - Layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.coll.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
- (void)setIamgeArray:(NSMutableArray *)iamgeArray
{
    _iamgeArray = [iamgeArray mutableCopy];
    [self.coll reloadData];
}

@end

#pragma mark - WebView

@interface CommunityWebView ()

@property (strong, nonatomic) UIImageView * bimageView;
@property (strong, nonatomic) UILabel * titleLabel;

@end

@implementation CommunityWebView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    if (@available(iOS 13.0, *)) {
        [self setBackgroundColor:[UIColor systemGray6Color]];
    } else {
        // Fallback on earlier versions
    }
    [self.layer setCornerRadius:5.0f];
    self.clipsToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.bimageView = imageView;
    if (@available(iOS 13.0, *)) {
        [imageView setImage:[UIImage systemImageNamed:@"link"]];
        [imageView setContentMode:UIViewContentModeCenter];
        [imageView setBackgroundColor:[UIColor systemGray5Color]];
    } else {
        // Fallback on earlier versions
    }
    
    UILabel *title = [[UILabel alloc] init];
    [self addSubview:title];
    self.titleLabel = title;
    [title setFont:[UIFont systemFontOfSize:DetailFont]];
    [title setNumberOfLines:2];
    [title setText:@"风雨同路30年 伴您同行真经典\n昔日中文金曲的日文原唱 濳伏多年 光华再现"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bimageView.frame = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.bimageView.frame) + 8, 0, CGRectGetWidth(self.frame) - 8 - CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
}

 - (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.titleLabel.text = titleString;
}
- (void)setImageString:(NSString *)imageString
{
    _imageString = imageString;
    self.bimageView.image = [UIImage imageNamed:imageString];
}
@end
