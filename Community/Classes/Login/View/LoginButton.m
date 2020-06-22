//
//  LoginButton.m
//  Community
//
//  Created by 大菠萝 on 2020/4/21.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LoginButton.h"

@implementation LoginButton

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (enabled) {
        [self setBackgroundColor:self.enableColor];
    } else {
        [self setBackgroundColor:self.unableColor];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.layer setCornerRadius:5.0f];
    [self setClipsToBounds:YES];
}


@end
