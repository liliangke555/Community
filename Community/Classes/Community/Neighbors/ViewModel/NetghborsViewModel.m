//
//  NetghborsViewModel.m
//  Community
//
//  Created by MAC on 2020/6/3.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "NetghborsViewModel.h"
#import "CommunityHeaderModel.h"
#import "CommunityDetailsCell.h"
#import "CommunityListModel.h"
#import <YBImageBrowser/YBIBImageData.h>
#import <YBImageBrowser/YBImageBrowser.h>
#import <YBImageBrowser/YBIBVideoData.h>


@interface NetghborsViewModel ()
@property (nonatomic, copy) void(^didClickWebView)(void);
@end

static NSInteger const testNum = 7;
@implementation NetghborsViewModel

+ (void)refreshWithCallBack:(void (^)(NSArray * _Nonnull))callBack
{
    CommunityHeaderModel *model = [[CommunityHeaderModel alloc] init];
    model.image = @"bag.fill";
    model.bage = @"99+";
    model.title = @"社区电商";
    
    CommunityHeaderModel *model1 = [[CommunityHeaderModel alloc] init];
    model1.image = @"creditcard.fill";
    model1.bage = @"55";
    model1.title = @"物业缴费";
    
    CommunityHeaderModel *model2 = [[CommunityHeaderModel alloc] init];
    model2.image = @"rosette";
    model2.bage = @"优惠券";
    model2.title = @"生活服务";
    
    CommunityHeaderModel *model3 = [[CommunityHeaderModel alloc] init];
    model3.image = @"table.badge.more.fill";
    model3.bage = @"NEW";
    model3.title = @"更多服务";
    
    if (callBack) {
        callBack(@[model,model1,model2,model3]);
    }
}

+ (void)refreshDataSource
{
    
}

- (void)didClickWebView:(void (^)(void))didClick
{
    self.didClickWebView = didClick;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataSource.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailsCell"];
    
    cell.isReal = indexPath.row % 2 == 0;
    if (indexPath.row % testNum == 0) {
        cell.isWeb = YES;
        cell.timeString = @"刚刚";
        cell.nameString = @"🌰😄我我発売)の企画で、現在考えられる最高峰のスペックと";
        cell.titleString = @"Net Audio Vol.19』";
        cell.detailString = @"出道至今包办个人专辑大部份词曲创作，大胆多变的曲风和细腻入微的歌词深受乐评人的赞誉";
        __weak typeof(self)weakSelf = self;
        [cell setDidClickWeb:^{
            if (weakSelf.didClickWebView) {
                weakSelf.didClickWebView();
            }
        }];
        
    } else {
        cell.isWeb = NO;
        cell.timeString = [NSString stringWithFormat:@"%ld小时前",indexPath.row];
        cell.detailString = @"《美雪集》（全名《美雪集-原曲流行极品》）";
        if (indexPath.row % testNum == 1) {
            cell.nameString = @"🍐梨子";
            cell.imageArray  = [NSMutableArray arrayWithArray:@[
                @"http://g.hiphotos.baidu.com/image/pic/item/6d81800a19d8bc3e770bd00d868ba61ea9d345f2.jpg",
                ]];
        }
        if (indexPath.row % testNum == 2) {
            cell.nameString = @"🍌的香蕉啊";
            cell.imageArray  = [NSMutableArray arrayWithArray:@[
                    @"http://img2.xkhouse.com/bbs/hfhouse/data/attachment/forum/corebbs/2009-11/2009113011534566298.jpg",
                    @"http://a.hiphotos.baidu.com/image/pic/item/e824b899a9014c087eb617650e7b02087af4f464.jpg",
                    @"http://c.hiphotos.baidu.com/image/pic/item/9c16fdfaaf51f3de1e296fa390eef01f3b29795a.jpg",
                    @"http://d.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f119945cbe2fe9925bc317d2a.jpg",
                    @"http://h.hiphotos.baidu.com/image/pic/item/902397dda144ad340668b847d4a20cf430ad851e.jpg",
                    @"http://b.hiphotos.baidu.com/image/pic/item/359b033b5bb5c9ea5c0e3c23d139b6003bf3b374.jpg",
                    @"http://a.hiphotos.baidu.com/image/pic/item/8d5494eef01f3a292d2472199d25bc315d607c7c.jpg",
                    @"http://b.hiphotos.baidu.com/image/pic/item/e824b899a9014c08878b2c4c0e7b02087af4f4a3.jpg",
                    @"http://g.hiphotos.baidu.com/image/pic/item/6d81800a19d8bc3e770bd00d868ba61ea9d345f2.jpg"
            ]];
        }
        if (indexPath.row % testNum == 3) {
            cell.nameString = @"🍎的苹果";
            cell.imageArray  = [NSMutableArray arrayWithArray:@[
                @"店招1.jpg",
//                @"http://h.hiphotos.baidu.com/image/pic/item/902397dda144ad340668b847d4a20cf430ad851e.jpg",
            ]];
        }
        if (indexPath.row % testNum == 4) {
            cell.nameString = @"🍍的大菠萝";
            cell.imageArray  = [NSMutableArray arrayWithArray:@[
                @"WechatIMG875.jpeg",
                @"海报2.jpg",
                @"WechatIMG874.jpeg",
                @"WechatIMG876.jpeg"
            ]];
        }
        if (indexPath.row % testNum == 5) {
            cell.nameString = @"🍑的桃子啊啊";
            cell.imageArray  = [NSMutableArray arrayWithArray:@[
                @"localBigImage0.jpeg",
                @"localImage1.gif",
            ]];
        }
        if (indexPath.row % testNum == 6) {
            cell.nameString = @"🍒的小樱桃树😄这还是东方红啊师傅红啊圣诞节佛i";
            cell.imageArray  = [NSMutableArray arrayWithArray:@[
                @"localVideo0.mp4",
                @"localLongImage0.jpeg",
            ]];
        }
    }
    __weak typeof(self)weakSelf = self;
    [cell didReviewImage:^(UICollectionView *collectionView,NSInteger index) {
        [weakSelf showBrowerWithIndex:index data:cell.imageArray view:cell];
    }];
    return cell;
}

- (void)showBrowerWithIndex:(NSInteger)index data:(NSMutableArray *)data view:(CommunityDetailsCell *)cell
{
    NSMutableArray *datas = [NSMutableArray array];
    [data enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
         if ([obj hasSuffix:@".mp4"] && [obj hasPrefix:@"http"]) { // 网络视频
               YBIBVideoData *data = [YBIBVideoData new];
               data.videoURL = [NSURL URLWithString:obj];
               data.projectiveView = [cell viewAtIndex:idx];
               [datas addObject:data];
            
           } else if ([obj hasSuffix:@".mp4"]) {// 本地视频
               NSString *path = [[NSBundle mainBundle] pathForResource:obj.stringByDeletingPathExtension ofType:obj.pathExtension];
               YBIBVideoData *data = [YBIBVideoData new];
               data.videoURL = [NSURL fileURLWithPath:path];
               data.projectiveView = [cell viewAtIndex:idx];
               [datas addObject:data];
               
           } else if ([obj hasPrefix:@"http"]) { // 网络图片
               YBIBImageData *data = [YBIBImageData new];
               data.imageURL = [NSURL URLWithString:obj];
               data.projectiveView = [cell viewAtIndex:idx];
               [datas addObject:data];
               
           } else {// 本地图片
               YBIBImageData *data = [YBIBImageData new];
               data.imageName = obj;
               data.projectiveView = [cell viewAtIndex:idx];
               [datas addObject:data];
               
           }
    }];

    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = index;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
//    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    [browser show];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityDetailsCell *cell = (CommunityDetailsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];

    return (cell.detailHeight + 110 + cell.imageHeight);
}

#pragma mark - Setter

- (void)setDidClickWebView:(void (^)(void))didClickView
{
    _didClickWebView = didClickView;
}

@end
