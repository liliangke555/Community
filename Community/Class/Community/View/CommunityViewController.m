//
//  CommunityViewController.m
//  Test
//
//  Created by Yue Zhang on 2020/3/23.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "CommunityViewController.h"
#import "LDCommunitySegment.h"
#import "NeighborsController.h"
#import "FamilyController.h"
#import "ReleaseCommunityController.h"

@interface CommunityViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) LDCommunitySegment * segment;
@property (strong, nonatomic) NeighborsController * neighbors;
@property (strong, nonatomic) FamilyController * family;

@property (strong, nonatomic) UIButton * sendButton;

@end

static CGFloat const sendButtonSize = 50.0f;

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
        [self.navigationController.navigationBar setBarTintColor:[UIColor systemBackgroundColor]];
    } else {
        // Fallback on earlier versions
        self.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    }
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.segment.contentOffX = scrollView.contentOffset.x / SCREEN_WIDTH;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //ScrollView中根据滚动距离来判断当前页数
    int page = (int)scrollView.contentOffset.x/SCREEN_WIDTH;
    
    // 设置页码
    self.segment.selectedIndex = page;
}

#pragma mark - setView

- (void)setupView
{
    LDCommunitySegment *segment = [LDCommunitySegment segmentWithTitles:@[@"邻里动态",@"家庭动态"]];
    [self.view addSubview:segment];
    __weak typeof(self)weakSelf = self;
    [segment setDidChengeSelected:^(NSInteger index) {
        [weakSelf.scrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
    }];
    self.segment = segment;
    
    [self addChildViewController:self.neighbors];
    [self.scrollView addSubview:self.neighbors.view];
    [self addChildViewController:self.family];
    [self.scrollView addSubview:self.family.view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = nil;
    button.layer.shadowOffset =  CGSizeMake(0.5, 0.5);
    button.layer.shadowOpacity = 0.5;
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:@"plus.circle.fill"];
        [button setBackgroundColor:[UIColor systemBackgroundColor]];
        button.layer.shadowColor =  [UIColor labelColor].CGColor;
    } else {
        // Fallback on earlier versions
        button.layer.shadowColor =  [UIColor blackColor].CGColor;
    }
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [self.view addSubview:button];
    self.sendButton = button;
    [button.layer setCornerRadius:sendButtonSize / 2.0f];
    [button addTarget:self action:@selector(dragMoving:withEvent:)forControlEvents:UIControlEventTouchDragInside];
    [button addTarget:self action:@selector(sendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Touch

#pragma mark - Helper Handle

/// 按钮拖拽事件
/// @param c 按钮对象
/// @param ev touch
- (void)dragMoving:(UIControl *) c withEvent:ev
{
    c.selected = YES;
    c.center = [[[ev allTouches] anyObject] locationInView:self.view];
}

/// 按钮点击事件
/// @param sender button对象
- (void)sendButtonAction:(UIButton *)sender
{
    //拖拽时selected = YES,所以判断selected为YES则说明拖拽结束，不是点击事件。
    if (sender.isSelected) {
        [self changeButtonFrame:sender];
        return;
    }
    NSLog(@"---点击了发布按钮---");
    ReleaseCommunityController *vc = [[ReleaseCommunityController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/// 判断拖拽边界。 不让button拖出屏幕视线
/// @param sender 发布button
- (void)changeButtonFrame:(UIButton *)sender
{
    CGFloat centerX = CGRectGetWidth(self.view.frame) - sendButtonSize / 2.0f - 16;
    CGFloat centerY = sender.center.y;
    CGFloat minCenterY = 64;
    CGFloat maxCenterY = CGRectGetHeight(self.view.frame) - 100 - sendButtonSize / 2.0f;
    if (sender.center.x <= CGRectGetWidth(self.view.frame) /2.0f) {
        centerX = 16 + sendButtonSize / 2.0f;
    }
    if (centerY <= minCenterY) {
        centerY = minCenterY;
    }
    if (centerY >= maxCenterY) {
        centerY = maxCenterY;
    }
    [UIView animateWithDuration:0.25f animations:^{
        sender.center = CGPointMake(centerX, centerY);
    }];
    sender.selected = NO;
}

#pragma mark - Getter

- (NeighborsController *)neighbors
{
    if (!_neighbors) {
        _neighbors = [[NeighborsController alloc] init];
    }
    return _neighbors;
}
- (FamilyController *)family
{
    if (!_family) {
        _family = [[FamilyController alloc] init];
    }
    return _family;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        [self.view addSubview:_scrollView];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat maxY = 24;
    if (HighIPhoneX) {
        maxY += 40;
    }
    self.segment.frame = CGRectMake(0, maxY, CGRectGetWidth(self.view.frame), 44);
    self.scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.segment.frame), SCREEN_WIDTH, CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.segment.frame));
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.segment.frame));
    
    self.neighbors.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    self.family.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    self.sendButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - sendButtonSize - 16, CGRectGetHeight(self.view.frame) - 64 - sendButtonSize - 44, sendButtonSize, sendButtonSize);
}

@end
