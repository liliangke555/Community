//
//  FamilyController.m
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "FamilyController.h"
#import "FamilyViewModel.h"

@interface FamilyController ()

@end

@implementation FamilyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.c
    
    [self refreshHeaderData];
}

- (void)refreshHeaderData
{
    __weak typeof(self)weakSelf = self;
    [FamilyViewModel refreshWithCallBack:^(NSArray * _Nonnull data) {
        weakSelf.headerData = [NSMutableArray arrayWithArray:data];
    }];
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
