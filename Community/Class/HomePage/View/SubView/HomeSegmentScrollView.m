//
//  HomeSegmentScrollView.m
//  Community
//
//  Created by MAC on 2020/6/12.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "HomeSegmentScrollView.h"

@interface HomeSegmentScrollView ()<UIGestureRecognizerDelegate>

@end

@implementation HomeSegmentScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
