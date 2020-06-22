//
//  DoorKeyViewController.m
//  Test
//
//  Created by Yue Zhang on 2020/3/23.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "DoorKeyViewController.h"

@interface DoorKeyViewController ()

@end

@implementation DoorKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"钥匙";
    self.view.backgroundColor = [UIColor redColor];
    [self initBackButton];
}

- (void)initBackButton
{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
    back.frame = CGRectMake(0, 0, 50, 50);
    CGPoint point ;
    point.x = self.view.frame.size.width/2;
    point.y = self.view.frame.size.height;
    back.center = point;
    
    [back setBackgroundImage:[UIImage imageNamed:@"DoorCloseBtn"] forState:UIControlStateNormal];
    back.layer.cornerRadius = 25.0;
    
    [back addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    [UIView animateWithDuration:1.2 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:1.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint point1 = back.center;
        if (HighIPhoneX) {
            point1.y -= (34.0 + 34.0);
        }else{
            point1.y -= 34.0;
        }
        back.center = point1;
    } completion:nil];
    
}

- (void)backButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
