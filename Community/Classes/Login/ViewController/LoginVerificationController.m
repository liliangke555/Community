//
//  LoginVerificationController.m
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LoginVerificationController.h"
#import "CodeResignView.h"
#import "LoginButton.h"
#import "LoginSelectView.h"

@interface LoginVerificationController ()<LoginSelectorDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleSubLabel;

@property (nonatomic, strong) CodeResignView *codeView;
@property (nonatomic, strong) LoginButton *loginButton;
@property (nonatomic, strong) LoginSelectView *selectView;

@end

@implementation LoginVerificationController
#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBACOLOR(246, 247, 248, 1);
    
    [self.titleLabel setText:@"请输入验证码"];
    [self.titleSubLabel setText:[NSString stringWithFormat:@"验证码已发送至%@",self.loginViewModel.userName]];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    __weak typeof(self)weakSelf = self;
    self.codeView.codeResignCompleted = ^(NSString * _Nonnull content) {
        NSLog(@"%@",content);
        weakSelf.loginViewModel.verification = content;
        weakSelf.loginButton.enabled = YES;
    };
    self.codeView.codeResignUnCompleted = ^(NSString * _Nonnull content) {
        weakSelf.loginButton.enabled = NO;
    };
}
#pragma mark - IBActions
- (void)loginButtonAction:(UIButton *)sender
{
    [self.loginViewModel goVerificationLogin];
}
#pragma mark - LoginSelectorDelegate
- (void)didSelectedIndex:(NSInteger)index
{
    self.loginViewModel.viewType = index;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Getter

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:28.0f]];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)titleSubLabel
{
    if (!_titleSubLabel) {
        _titleSubLabel = [[UILabel alloc] init];
        [_titleSubLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [_titleSubLabel setTextColor:RGBACOLOR(220, 221, 221, 1)];
//        [_titleSubLabel setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:_titleSubLabel];
    }
    return _titleSubLabel;
}

- (CodeResignView *)codeView
{
    if (!_codeView) {
        _codeView = [[CodeResignView alloc] initWithCodeBits:6];
        [self.view addSubview:_codeView];
    }
    return _codeView;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [LoginButton buttonWithType:UIButtonTypeCustom];
        _loginButton.enableColor = RGBACOLOR(35, 193, 110, 1);
        _loginButton.unableColor = RGBACOLOR(154, 223, 181, 1);
        _loginButton.enabled = NO;
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}

- (LoginSelectView *)selectView
{
    if (!_selectView) {
        _selectView = [LoginSelectView loginSelectViewWithTitles:@[@"一键登录",@"密码登录"]];
        [self.view addSubview:_selectView];
        _selectView.delegate = self;
//        _selectView.delegate = self.loginViewModel;
    }
    return _selectView;
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.titleLabel.frame = CGRectMake(32, CGRectGetMinY(self.view.bounds) + 16, CGRectGetWidth(self.view.bounds) - 64, 44);
    self.titleSubLabel.frame = CGRectMake(32, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.view.bounds) - 64, 20);
    
    self.codeView.frame = CGRectMake(32, CGRectGetMaxY(self.titleSubLabel.frame) + 44, CGRectGetWidth(self.view.bounds) - 64, 44);
    [self.codeView layoutSubviews];
    
    self.loginButton.frame = CGRectMake(32, CGRectGetMaxY(self.codeView.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 44);
    
    self.selectView.frame = CGRectMake(32, CGRectGetMaxY(self.loginButton.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 24);
}
@end
