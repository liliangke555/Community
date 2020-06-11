//
//  ReleaseContentView.m
//  Community
//
//  Created by MAC on 2020/6/8.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "ReleaseContentView.h"
#import "LxGridViewFlowLayout.h"
#import "ContentImageCell.h"

@interface ReleaseContentView ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UITextView * textView;
@property (strong, nonatomic) UILabel * placeHolderLabel;
@property (strong, nonatomic) UICollectionView * collectionView;
@property (strong, nonatomic) LxGridViewFlowLayout * layout;

@property (nonatomic, copy) void(^didClickAdd)(void);
@property (nonatomic, copy) void(^didClickImageView)(NSInteger);
@property (nonatomic, copy) void(^deleteAction)(NSInteger);
@property (nonatomic, copy) void(^changeAction)(NSInteger ,NSInteger);
@end

static CGFloat const Margin = 4;
static CGFloat const LeftDistance = 16;
static NSInteger const MaxPhoto = 9;

@implementation ReleaseContentView

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
    UITextView *textView = [[UITextView alloc] init];
    [self addSubview:textView];
    self.textView = textView;
    [textView setFont:[UIFont systemFontOfSize:15]];
    if (@available(iOS 13.0, *)) {
        [textView setTextColor:[UIColor labelColor]];
        [textView setBackgroundColor:[UIColor systemBackgroundColor]];
    } else {
        // Fallback on earlier versions
        [textView setTextColor:[UIColor blackColor]];
        [textView setBackgroundColor:[UIColor whiteColor]];
    }
    textView.delegate = self;
    
    UILabel *label = [[UILabel alloc] init];
    [textView addSubview:label];
    self.placeHolderLabel = label;
    if (@available(iOS 13.0, *)) {
        [label setTextColor:[UIColor systemGray2Color]];
    } else {
        // Fallback on earlier versions
        [label setTextColor:[UIColor grayColor]];
    }
    [label setFont:[UIFont systemFontOfSize:15]];
    label.text = @"有什么想说的...";
    
    LxGridViewFlowLayout *layout = [[LxGridViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout = layout;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    if (@available(iOS 13.0, *)) {
        collectionView.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        // Fallback on earlier versions
    }
    collectionView.scrollEnabled = NO;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView registerClass:[ContentImageCell class] forCellWithReuseIdentifier:@"ContentImageCell"];
    collectionView.scrollEnabled = NO;
}
- (void)didClickAdd:(void (^)(void))clickAdd
{
    self.didClickAdd = clickAdd;
}
- (void)didClickImageView:(void (^)(NSInteger))click
{
    self.didClickImageView = click;
}
- (void)didDeleted:(void (^)(NSInteger))deleted
{
    self.deleteAction = deleted;
}
- (void)changeItemIndex:(void (^)(NSInteger,NSInteger))change
{
    self.changeAction = change;
}
- (void)reloadData
{
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource.count >= MaxPhoto) {
        return MaxPhoto;
    }
    return self.dataSource.count + 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ContentImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ContentImageCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.item == self.dataSource.count) {
        if (@available(iOS 13.0, *)) {
            cell.imageView.image = [UIImage systemImageNamed:@"plus.circle"];
        } else {
            // Fallback on earlier versions
        }
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = self.dataSource[indexPath.item];
//        cell.asset = _selectedAssets[indexPath.item];
        cell.deleteBtn.hidden = NO;
    }
    cell.gifLable.hidden = YES;
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == self.dataSource.count) {
        if (self.didClickAdd) {
            self.didClickAdd();
        }
    } else {
        if (self.didClickImageView) {
            self.didClickImageView(indexPath.item);
        }
    }
}
#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < self.dataSource.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < self.dataSource.count && destinationIndexPath.item < self.dataSource.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = self.dataSource[sourceIndexPath.item];
    [self.dataSource removeObjectAtIndex:sourceIndexPath.item];
    [self.dataSource insertObject:image atIndex:destinationIndexPath.item];
    
    if (self.changeAction) {
        self.changeAction(sourceIndexPath.item, destinationIndexPath.item);
    }
    [_collectionView reloadData];
}
#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= self.dataSource.count) {
        [self.dataSource removeObjectAtIndex:sender.tag];
        if (self.deleteAction) {
            self.deleteAction(sender.tag);
        }
        [self.collectionView reloadData];
        return;
    }
    
    [self.dataSource removeObjectAtIndex:sender.tag];

    if (self.deleteAction) {
        self.deleteAction(sender.tag);
    }
    __weak typeof(self)weakSelf = self;
    [self.collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [weakSelf.collectionView reloadData];
    }];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0 ) {
        //添加placeholder
        _placeHolderLabel.hidden = NO;
        //按钮不让点击
    }else{
        _placeHolderLabel.hidden = YES;
    }
}
#pragma mark - Getter
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark - Setter
- (void)setDidClickAdd:(void (^)(void))didClickAdd
{
    _didClickAdd = didClickAdd;
}
#pragma mark - Layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = CGRectMake(LeftDistance, 0, CGRectGetWidth(self.frame) - LeftDistance * 2, 150);
    self.placeHolderLabel.frame = CGRectMake(5, 0, CGRectGetWidth(self.textView.frame), 30);
    
    CGFloat itemWH = (CGRectGetWidth(self.frame) - 2 * LeftDistance - 2 * Margin) / 3.0f;
    _layout.itemSize = CGSizeMake(itemWH, itemWH);
    _layout.minimumInteritemSpacing = 0;
    _layout.minimumLineSpacing = Margin;
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(self.textView.frame));
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
