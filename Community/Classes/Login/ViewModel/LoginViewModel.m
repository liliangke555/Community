//
//  LoginViewModel.m
//  Test
//
//  Created by Yue Zhang on 2020/3/21.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LoginViewModel.h"

NSString *const LoginViewModelViewTypeKey = @"viewType";
NSString *const LoginViewModelIsEnableLogionKey = @"isEnableLogion";

@implementation LoginViewModel

- (instancetype)initWithLoginModel:(ResidentLoginVo *)loginModel {
     self = [super init];
     if (!self) return nil;
     if (loginModel.nickname.length > 0) {
         _userName = loginModel.nickname;
     } else {
         _userName = [NSString stringWithFormat:@"守望%@", loginModel.id];
     }
         return self;
 }
- (void)toLogin
{
    if (self.viewType == LoginOnekey) {
        
        if ([self.delegate respondsToSelector:@selector(goVerification)]) {
            [self.delegate goVerification];
        }
        
    } else if (self.viewType == LoginPassword) {
        if (self.userName.length == 11 && self.passWord.length > 0) {
            
        }
    } else {
        if (self.userName.length == 11) {
            if ([self.delegate respondsToSelector:@selector(goVerification)]) {
                [self.delegate goVerification];
            }
        }
    }
}
- (void)goVerificationLogin
{
    
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 101) {
        self.userName = textField.text;
    }
    if (textField.tag == 102) {
        self.passWord = textField.text;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
- (void)textFieldDidChangeSelection:(UITextField *)textField
{
    if (self.viewType == LoginPassword) {
        if (self.userName.length > 0 && textField.text.length > 0) {
            
            self.isEnableLogion = YES;
            
        } else if (self.passWord.length > 0 && textField.text.length > 0) {
            self.isEnableLogion = YES;
        } else {
            self.isEnableLogion = NO;
        }
    } else if (self.viewType == LoginVerification) {
        if (textField.text.length > 0 || self.userName.length > 0) {
            self.isEnableLogion = YES;
        } else {
            self.isEnableLogion = NO;
        }
    }
}
#pragma mark - LoginSelectorDelegate
- (void)didSelectedIndex:(NSInteger)index
{
    if (self.viewType == LoginOnekey) {
        if (index == 0) {
            self.viewType = LoginVerification;
            self.isEnableLogion = self.userName.length > 0;
        } else {
            self.viewType = LoginPassword;
            self.isEnableLogion = (self.userName.length > 0 && self.passWord.length > 0);
        }
    } else if (self.viewType == LoginPassword) {
        if (index == 0) {
            self.viewType = LoginOnekey;
            self.isEnableLogion = YES;
        } else if (index == 1) {
            self.viewType = LoginVerification;
            self.isEnableLogion = self.userName.length > 0;
        } else {

        }
    } else {
        if (index == 0) {
            self.viewType = LoginOnekey;
        } else {
            self.viewType = LoginPassword;
            self.isEnableLogion = (self.userName.length > 0 && self.passWord.length > 0);
        }
    }
//    if (self.didChangeType) {
//        self.didChangeType(self.viewType);
//    }
}

#pragma mark - Setter



@end
