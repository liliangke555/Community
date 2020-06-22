//
//  LDNavigationController.m
//  Community
//
//  Created by MAC on 2020/6/1.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LDNavigationController.h"

@interface LDNavigationController ()<UINavigationControllerDelegate>

@end

@implementation LDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.navigationBar.tintColor = RGBACOLOR(71, 71, 71, 1);
    
    __weak typeof(self) weakself = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakself;
    }
}

#pragma mark - UIGestureRecognizerDelegate
//这个方法是在手势将要激活前调用：返回YES允许右滑手势的激活，返回NO不允许右滑手势的激活
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        //屏蔽调用rootViewController的滑动返回手势，避免右滑返回手势引起死机问题
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    //这里就是非右滑手势调用的方法啦，统一允许激活
    return YES;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
        if (root != viewController) {
            UIImage *image = nil;
            if (@available(iOS 13.0, *)) {
                image = [UIImage systemImageNamed:@"chevron.left"];
            } else {
                // Fallback on earlier versions
                image = [UIImage imageNamed:@""];
            }
            UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(popAction:)];
            viewController.navigationItem.leftBarButtonItem = itemleft;
        }
}

- (void)popAction:(id)sender
{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //隐藏地步tabar
    if (self.childViewControllers.count){//即将跳往二级界面
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

//弹回来
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.childViewControllers.count == 2) {//即将跳到根控制器
        self.navigationController.hidesBottomBarWhenPushed = NO;
    }
    return [super popViewControllerAnimated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
