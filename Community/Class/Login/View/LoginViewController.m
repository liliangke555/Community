//
//  LoginViewController.m
//  Community
//
//  Created by Yue Zhang on 2020/4/20.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "UnderlineText.h"
#import "LoginButton.h"
#import "LoginSelectView.h"
#import "LoginVerificationController.h"



@interface LoginViewController ()<LoginVerificationDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *phoneSubLabel;

@property (nonatomic, strong) UnderlineText *phoneText;
@property (nonatomic, strong) UnderlineText *passwordText;

@property (nonatomic, strong) LoginButton *loginButton;
@property (nonatomic, strong) LoginSelectView *selectView;

@property (nonatomic, strong) UILabel *remarksLabel;

@property (nonatomic, strong) LoginViewModel *loginModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUIInView];
}

#pragma mark - Setup
- (void)setUIInView
{
    self.view.backgroundColor = RGBACOLOR(246, 247, 248, 1);
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"DoorCloseBtn"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.phoneLabel setText:@"181****0028"];
    [self.phoneSubLabel setText:@"账号安全 放心登录"];
    [self.titleLabel setText:@"欢迎登录"];
    [self.phoneText setPlaceholder:@"请输入手机号"];
    [self.passwordText setPlaceholder:@"请输入密码"];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    
    [self.remarksLabel setText:@"登录代表同意中国移动认证服务条款和用户协议，隐私政策并使用本机号码登录"];
    
    [self.loginModel addObserver:self forKeyPath:LoginViewModelViewTypeKey options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
    [self.loginModel addObserver:self forKeyPath:LoginViewModelIsEnableLogionKey options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:LoginViewModelViewTypeKey]) {
        switch (self.loginModel.viewType) {
            case LoginOnekey:
                [self oneKeyLoginView];
                break;
            case LoginPassword:
                [self passwordLoginView];
                break;
            default:
                [self verificationLoginView];
                break;
        }
    }
    if ([keyPath isEqualToString:LoginViewModelIsEnableLogionKey]) {
        self.loginButton.enabled = self.loginModel.isEnableLogion;
    }
    
}

#pragma mark - Helper Hanlde

- (void)oneKeyLoginView
{
    [self.view endEditing:YES];
    self.phoneSubLabel.hidden = NO;
    self.phoneLabel.hidden = NO;
    [UIView animateWithDuration:.25f animations:^{
        self.phoneSubLabel.alpha = 1.0f;
        self.phoneLabel.alpha = 1.0f;
        self.loginButton.frame = CGRectMake(32, CGRectGetMaxY(self.phoneSubLabel.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 44);
        self.selectView.frame = CGRectMake(32, CGRectGetMaxY(self.loginButton.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 24);
        self.passwordText.alpha = 0.0f;
        self.phoneText.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.loginButton.enabled = YES;
        self.passwordText.hidden = YES;
        self.phoneText.hidden = YES;
        self.selectView.titles = @[@"验证登录",@"密码登录"];
        self.selectView.frame = CGRectMake(32, CGRectGetMaxY(self.loginButton.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 24);
        [self.loginButton setTitle:@"本机号码一键登录" forState:UIControlStateNormal];
    }];
}

- (void)passwordLoginView
{
    [self.view endEditing:YES];
    self.passwordText.hidden = NO;
    self.phoneText.hidden = NO;
    [UIView animateWithDuration:.25f animations:^{
        self.loginButton.frame = CGRectMake(32, CGRectGetMaxY(self.passwordText.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 44);
        self.selectView.frame = CGRectMake(32, CGRectGetMaxY(self.loginButton.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 24);
        self.passwordText.alpha = 1;
        self.phoneText.alpha = 1.0f;
        self.phoneSubLabel.alpha = 0.0f;
        self.phoneLabel.alpha = 0.0f;
//        self.loginButton.enabled = NO;
    } completion:^(BOOL finished) {
        self.selectView.titles = @[@"一键登录",@"验证登录",@"忘记密码"];
        self.selectView.frame = CGRectMake(32, CGRectGetMaxY(self.loginButton.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 24);
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        self.phoneSubLabel.hidden = YES;
        self.phoneLabel.hidden = YES;
    }];
}

- (void)verificationLoginView
{
    [self.view endEditing:YES];
    self.phoneText.hidden = NO;
    [UIView animateWithDuration:0.25f animations:^{
        self.loginButton.frame = CGRectMake(32, CGRectGetMaxY(self.phoneText.frame) + 16, CGRectGetWidth(self.view.frame) - 64, 44);
        self.selectView.frame = CGRectMake(32, CGRectGetMaxY(self.loginButton.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 24);
        self.phoneText.alpha = 1.0f;
        self.phoneSubLabel.alpha = 0.0f;
        self.phoneLabel.alpha = 0.0f;
//        self.loginButton.enabled = NO;
    } completion:^(BOOL finished) {
        [self.loginButton setTitle:@"获取短信验证码" forState:UIControlStateNormal];
        self.passwordText.alpha = 0.0f;
        self.passwordText.hidden = YES;
        self.selectView.titles = @[@"一键登录",@"密码登录"];
        self.selectView.frame = CGRectMake(32, CGRectGetMaxY(self.loginButton.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 24);
        self.phoneSubLabel.hidden = YES;
        self.phoneLabel.hidden = YES;
    }];
}
#pragma mark - LoginVerificationDelegate

- (void)goVerification
{
    LoginVerificationController *vc = [[LoginVerificationController alloc] init];
    vc.loginViewModel = self.loginModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Event Handle

- (void)loginButtonAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self.loginModel toLogin];

}

- (void)backButtonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - Setter

#pragma mark - Getter
- (LoginViewModel *)loginModel
{
    if (!_loginModel) {
        _loginModel = [[LoginViewModel alloc] init];
        _loginModel.viewType = LoginPassword;
        _loginModel.delegate = self;

    }
    return _loginModel;
}
- (LoginSelectView *)selectView
{
    if (!_selectView) {
        _selectView = [LoginSelectView loginSelectViewWithTitles:@[@"一键登录",@"验证登录",@"忘记密码"]];
        [self.view addSubview:_selectView];
        _selectView.delegate = self.loginModel;
    }
    return _selectView;
}
- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [LoginButton buttonWithType:UIButtonTypeCustom];
        _loginButton.enableColor = MainGreenColor;
        _loginButton.unableColor = RGBACOLOR(154, 223, 181, 1);
        _loginButton.enabled = NO;
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}

- (UITextField *)phoneText
{
    if (!_phoneText) {
        _phoneText = [[UnderlineText alloc] init];
        _phoneText.delegate = self.loginModel;
        _phoneText.tag = 101;
        [self.view addSubview:_phoneText];
    }
    return _phoneText;
}

- (UnderlineText *)passwordText
{
    if (!_passwordText) {
        _passwordText = [[UnderlineText alloc] init];
        _passwordText.delegate = self.loginModel;
        _passwordText.tag = 102;
        [self.view addSubview:_passwordText];
    }
    return _passwordText;
}

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

- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        [_phoneLabel setFont:[UIFont boldSystemFontOfSize:28.0f]];
        [_phoneLabel setTextColor:[UIColor blackColor]];
        [_phoneLabel setTextAlignment:NSTextAlignmentCenter];
        _phoneLabel.hidden = YES;
        _phoneLabel.alpha = 0.0f;
        [self.view addSubview:_phoneLabel];
    }
    return _phoneLabel;
}

- (UILabel *)phoneSubLabel
{
    if (!_phoneSubLabel) {
        _phoneSubLabel = [[UILabel alloc] init];
        [_phoneSubLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [_phoneSubLabel setTextColor:RGBACOLOR(220, 221, 221, 1)];
        [_phoneSubLabel setTextAlignment:NSTextAlignmentCenter];
        _phoneSubLabel.hidden = YES;
        _phoneSubLabel.alpha = 0.0f;
        [self.view addSubview:_phoneSubLabel];
    }
    return _phoneSubLabel;
}

- (UILabel *)remarksLabel
{
    if (!_remarksLabel) {
        _remarksLabel = [[UILabel alloc] init];
        [_remarksLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [_remarksLabel setTextColor:RGBACOLOR(35, 193, 110, 1)];
        [_remarksLabel setTextAlignment:NSTextAlignmentCenter];
        [_remarksLabel setNumberOfLines:0];
        [self.view addSubview:_remarksLabel];
    }
    return _remarksLabel;
}

#pragma mark - Layout
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.titleLabel.frame = CGRectMake(32, CGRectGetMinY(self.view.bounds) + 16, CGRectGetWidth(self.view.bounds) - 64, 44);
    self.phoneText.frame = CGRectMake(32, CGRectGetMaxY(self.titleLabel.frame) + 64, CGRectGetWidth(self.view.bounds) - 64, 44);
    
    self.phoneLabel.frame = CGRectMake(32, CGRectGetMaxY(self.titleLabel.bounds) + 64, CGRectGetWidth(self.view.bounds) - 64, 44);
    self.phoneSubLabel.frame = CGRectMake(32, CGRectGetMaxY(self.phoneLabel.frame), CGRectGetWidth(self.view.bounds) - 64, 20);
    
    self.passwordText.frame = CGRectMake(32, CGRectGetMaxY(self.phoneText.frame) + 16, CGRectGetWidth(self.view.frame) - 64, 44);
    self.loginButton.frame = CGRectMake(32, CGRectGetMaxY(self.passwordText.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 44);
    self.selectView.frame = CGRectMake(32, CGRectGetMaxY(self.loginButton.frame) + 16, CGRectGetWidth(self.view.bounds) - 64, 24);
    
    self.remarksLabel.frame = CGRectMake(64, CGRectGetMaxY(self.view.frame)-200, CGRectGetWidth(self.view.bounds) - 128, 100);
}
@end
