//
//  LoginViewModel.h
//  Test
//
//  Created by Yue Zhang on 2020/3/21.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResidentLoginVo.h"
#import "LoginSelectView.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LoginViewType) {
    LoginOnekey = 0,
    LoginPassword,
    LoginVerification
};

@protocol LoginVerificationDelegate <NSObject>

- (void)goVerification;

@end

extern NSString *const LoginViewModelViewTypeKey; //!<  登录类型 key
extern NSString *const LoginViewModelIsEnableLogionKey; //!< 判断登录按钮是否可点击 key

@interface LoginViewModel : NSObject<LoginSelectorDelegate,UITextFieldDelegate>

@property (nonatomic) LoginViewType viewType;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *verification;

@property (nonatomic, assign) id <LoginVerificationDelegate> delegate;

@property (nonatomic) BOOL isEnableLogion;


- (instancetype)initWithLoginModel:(ResidentLoginVo *)loginModel;
- (void)toLogin;
- (void)goVerificationLogin;

@end

NS_ASSUME_NONNULL_END
