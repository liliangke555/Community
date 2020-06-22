//
//  HomeTableView.m
//  Community
//
//  Created by MAC on 2020/6/12.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "HomeTableView.h"

@interface HomeTableView ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@end

@implementation HomeTableView

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)setCanScroll:(BOOL)canScroll
{
    _canScroll = canScroll;
//    self.scrollEnabled = canScroll;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
