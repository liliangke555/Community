//
//  NeighborsController.m
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "NeighborsController.h"
#import "NetghborsViewModel.h"
#import "LDWebViewController.h"


@interface NeighborsController ()

@property (strong, nonatomic) NetghborsViewModel * viewModel;

@end

@implementation NeighborsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self refreshHeaderData];
    
    self.tableView.delegate = self.viewModel;
    self.tableView.dataSource = self.viewModel;
}

-(void)refreshHeaderData
{
    __weak typeof(self)weakSelf = self;
    [NetghborsViewModel refreshWithCallBack:^(NSArray * _Nonnull data) {
        weakSelf.headerData = [NSMutableArray arrayWithArray:data];
    }];
}

#pragma mark - Getter

- (NetghborsViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[NetghborsViewModel alloc] init];
        __weak typeof(self)weakSelf = self;
        [_viewModel didClickWebView:^{
            LDWebViewController *vc = [[LDWebViewController alloc] init];
            vc.urlStr = @"https://rsdsd.cc/forum.php?mod=viewthread&tid=1825&extra=page%3D1%26filter%3Dtypeid%26typeid%3D23";
//            [weakSelf presentViewController:vc animated:YES completion:nil];
            vc.hookAjax = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _viewModel;
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
