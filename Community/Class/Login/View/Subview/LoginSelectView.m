//
//  LoginSelectView.m
//  Community
//
//  Created by 大菠萝 on 2020/4/21.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LoginSelectView.h"

@interface LoginSelectView ()
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation LoginSelectView

+ (instancetype)loginSelectViewWithTitles:(NSArray *)titles
{
    LoginSelectView *view = [[LoginSelectView alloc] initWithTitles:titles];
    return view;
}

- (instancetype)initWithTitles:(NSArray <NSString *>*)titles
{
    self = [super init];
    if (self) {
        self.titles = titles;
        [self setUpView];
    }
    return self;
}
- (void)setUpView
{
    
}

#pragma mark - Event Hanlder
- (void)buttonAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [self.delegate didSelectedIndex:sender.tag -100];
    }
}
#pragma mark - Layout
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    float width = frame.size.width / self.buttons.count;
    for (int i = 0; i < self.buttons.count; i ++) {
        UIButton *button = [self.buttons objectAtIndex:i];
         
        button.frame = CGRectMake(i * width, 0, width, frame.size.height);
        
        if (i != (self.buttons.count - 1)) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = RGBACOLOR(225, 225, 225, 1);
            line.frame = CGRectMake(width - 1, 2, 1, frame.size.height - 4);
            [button addSubview:line];
        }
    }
}
#pragma mark - Setter
- (void)setTitles:(NSArray<NSString *> *)titles
{
    _titles = titles;
    for (UIButton *button in self.buttons) {
        [button removeFromSuperview];
    }
    [self.buttons removeAllObjects];
    for (int i = 0; i < titles.count; i ++) {
        NSString *title = [titles objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 100;
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:button];
        [self.buttons addObject:button];
    }
}

#pragma mark - Getter

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
@end
