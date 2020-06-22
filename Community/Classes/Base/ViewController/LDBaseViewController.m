//
//  LDBaseViewController.m
//  Community
//
//  Created by Yue Zhang on 2020/4/15.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LDBaseViewController.h"

@interface LDBaseViewController ()

@end

@implementation LDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (@available(iOS 13.0, *)) {
        [self.view setBackgroundColor:[UIColor systemBackgroundColor]];
    } else {
        // Fallback on earlier versions
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
}

- (void)dealloc
{
    NSLog(@"%@---dealloc",NSStringFromClass([self class]));
}


@end
