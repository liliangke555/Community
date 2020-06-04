//
//  CommunutyTitleView.m
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "CommunutyTitleView.h"
#import "MessageCenterCollectionCell.h"
#import "CommunityHeaderModel.h"

@interface CommunutyTitleView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation CommunutyTitleView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCenterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TTQVideoListCell" forIndexPath:indexPath];
    CommunityHeaderModel *model = self.dataSource[indexPath.row];
    UIImage *image = nil;
    NSString *string = nil;
        if (@available(iOS 13.0, *)) {
            image = [UIImage systemImageNamed:model.image];
        } else {
            // Fallback on earlier versions
        }
    string = model.title;
    [cell.headerImage setImage:image];
    [cell.titleLabel setText:string];
    cell.bageString = model.bage;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    CommunityHeaderModel *model = self.dataSource[indexPath.row];
    NSLog(@"---点击了-%@---",model.title);
}

#pragma mark - Getter

#pragma mark - Setter

- (void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    [self.collectionView reloadData];
}


@end
