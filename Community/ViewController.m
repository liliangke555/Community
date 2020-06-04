//
//  ViewController.m
//  Test
//
//  Created by Yue Zhang on 2020/3/21.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "ViewController.h"
#import "HomePageViewController.h"
#import "FamilyViewController.h"
#import "DoorKeyViewController.h"
#import "CommunityViewController.h"
#import "MineViewController.h"
#import "PrefixHeader.pch"

#import "LoginViewController.h"
#import "PrivacyController.h"
#import "LDNavigationController.h"

#define BarTintColor  RGBACOLOR(240, 240, 240, 1.0)

@interface ViewController ()
{
    UIButton *button;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建首页视图
    UIImage *image = nil;
    UIImage *selectedImage = nil;
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:@"house"];
        selectedImage = [UIImage systemImageNamed:@"house.fill"];
    } else {
        // Fallback on earlier versions
        image = [[UIImage imageNamed:@"tabbar1_unselected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage = [[UIImage imageNamed:@"tabbar1_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    HomePageViewController *c1 = [[HomePageViewController alloc]init];
    c1.tabBarItem.image = image;
    c1.tabBarItem.selectedImage = selectedImage;
    c1.title = @"首页";
    LDNavigationController *n1 = [[LDNavigationController alloc]initWithRootViewController:c1];
    
    //创建邻里圈视图
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:@"person.2"];
        selectedImage = [UIImage systemImageNamed:@"person.2.fill"];
    } else {
        // Fallback on earlier versions
        image = [[UIImage imageNamed:@"tabbar2_unselected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage = [[UIImage imageNamed:@"tabbar2_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    FamilyViewController *c2  = [[FamilyViewController alloc]init];
    c2.tabBarItem.image = image;
    c2.tabBarItem.selectedImage = selectedImage;
    c2.title = @"家庭";
    LDNavigationController *n2 = [[LDNavigationController alloc]initWithRootViewController:c2];
    
    //创建首页视图
    HomePageViewController *c3 = [[HomePageViewController alloc]init];
    LDNavigationController *n3 = [[LDNavigationController alloc]initWithRootViewController:c3];
    
    //创建社区 视图
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:@"heart.circle"];
        selectedImage = [UIImage systemImageNamed:@"heart.circle.fill"];
    } else {
        // Fallback on earlier versions
        image = [[UIImage imageNamed:@"tabbar3_unselected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage = [[UIImage imageNamed:@"tabbar3_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    CommunityViewController *c4  = [[CommunityViewController alloc]init];
    c4.tabBarItem.image = image;
    c4.tabBarItem.selectedImage = selectedImage;
    c4.tabBarItem.title  = @"社区";
    LDNavigationController *n4 = [[LDNavigationController alloc]initWithRootViewController:c4];
    
    //创建更多视图
    MineViewController *c5 = [[MineViewController alloc]init];
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:@"person.crop.circle"];
        selectedImage = [UIImage systemImageNamed:@"person.crop.circle.fill"];
    } else {
        // Fallback on earlier versions
        image = [[UIImage imageNamed:@"tabbar4_unselected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage = [[UIImage imageNamed:@"tabbar4_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    c5.tabBarItem.image = image;
    c5.tabBarItem.selectedImage = selectedImage;
    c5.tabBarItem.title = @"我的";
    LDNavigationController *n5 = [[LDNavigationController alloc]initWithRootViewController:c5];
    
    //添加控制器到TabbarController中
    self.viewControllers = @[n1,n2,n3,n4,n5];
    [self setup];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

 -(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self toLoginView];
    
}

#pragma mark- setup
-(void)setup
{
    //  添加突出按钮
    [self addCenterButtonWithImage:[UIImage imageNamed:@"tabbar3"] selectedImage:[UIImage imageNamed:@"tabbar3"]];
    
    self.delegate = self;
    //  指定当前页——中间页
    self.selectedIndex = 0;
    //设置tabbar的bar背景颜色
    self.tabBar.barTintColor = BarTintColor;
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    
    
}

#pragma mark - Helper Handle

- (void)toLoginView
{
//    LoginViewController *login = [[LoginViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
//    nav.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:nav animated:YES completion:nil];
    
//    PrivacyController *vc = [[PrivacyController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark - addCenterButton
// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage selectedImage:(UIImage*)selectedImage
{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleTopMargin;
    
    CGFloat bolderSizex = (HighIPhoneX ? 10.0 : 20.0);
    //  设定button大小为适应图片
    button.frame = CGRectMake(0.0, 0.0,
                              buttonImage.size.width + bolderSizex,
                              buttonImage.size.height + bolderSizex);
    [button setImage:buttonImage forState:UIControlStateNormal];
    //设置按钮的圆角大小
    button.layer.cornerRadius = (buttonImage.size.width + bolderSizex)/2;
    [button setBackgroundColor:BarTintColor];
    //去掉选中button时候的阴影
    button.adjustsImageWhenHighlighted=NO;
    
    /*
     *  核心代码：设置button的center 和 tabBar的 center 做对齐操作， 同时做出相对的上浮 调整按钮的偏移量
     */
    CGPoint center = self.tabBar.center;
    if (HighIPhoneX) {
         center.y = 15.0 + 12.0;
    }else{
        center.y = 15.0;
    }
    button.center = center;
    
    //添加到tabbar上
    [self.tabBar addSubview:button];
}

- (void)pressChange:(id)sender
{
    button.selected = YES;
    
    //创建界面
    DoorKeyViewController *fvc = [DoorKeyViewController new];
    UINavigationController *uinc = [[UINavigationController alloc]initWithRootViewController:fvc];
    uinc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:uinc animated:YES completion:nil];
}

@end
