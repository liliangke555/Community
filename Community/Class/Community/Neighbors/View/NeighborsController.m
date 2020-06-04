//
//  NeighborsController.m
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "NeighborsController.h"
#import "NetghborsViewModel.h"


@interface NeighborsController ()

@end

@implementation NeighborsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self refreshHeaderData];
}

-(void)refreshHeaderData
{
    __weak typeof(self)weakSelf = self;
    [NetghborsViewModel refreshWithCallBack:^(NSArray * _Nonnull data) {
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
