//
//  HomePageViewController.m
//  Test
//
//  Created by Yue Zhang on 2020/3/23.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "HomePageViewController.h"

#import "CoreTextView.h"

@interface HomePageViewController ()

@property(nonatomic,strong) id subscriber;

@property (nonatomic, strong) UILabel *label;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.view.backgroundColor = [UIColor systemGreenColor];
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"---创建信号---");
        [subscriber sendNext:@"hahahahha "];
        self->_subscriber = subscriber;
        RACDisposable * disponse = [RACDisposable disposableWithBlock:^{
            NSLog(@"当信号发送完成或者发送错误，就会自动执行这个block,执行完Block后，当前信号就不在被订阅了。");
        }];
        
        return disponse ;
    }];
    
    RACMulticastConnection *connect = [signal publish];
    
    
    // 订阅信号
    [connect.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",[NSString stringWithFormat:@"receive:--%@",x]);
        [[RACScheduler mainThreadScheduler] schedule:^{
            [self.label setText:[NSString stringWithFormat:@"现在时间：%@",x]];
        }];
        
    }];
    
//    [connect.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",[NSString stringWithFormat:@"receive:---%@",x]);
//    }];
    [connect connect];
    
    [[RACSignal interval:1.0f onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:x];
        [self.subscriber sendNext:strDate];
    }];
    
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"------1-----");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"------2-----");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"------3-----");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"------4-----");
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"------5-----");
    });
    
    CoreTextView *view = [[CoreTextView alloc] initWithFrame:CGRectMake(16, 132, CGRectGetWidth(self.view.frame) - 32, 300)];
    view.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:view];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [_subscriber sendNext:@"lol"];
//    [_subscriber sendCompleted];
//    [_subscriber sendNext:@"lalala"]; // 不会执行
//}
#pragma mark - Getter
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        [self.view addSubview:_label];
        [_label setFont:[UIFont boldSystemFontOfSize:24]];
        if (@available(iOS 13.0, *)) {
            [_label setTextColor:[UIColor systemGray3Color]];
        } else {
            // Fallback on earlier versions
            [_label setTextColor:[UIColor grayColor]];
        }
        [_label setTextAlignment:NSTextAlignmentCenter];
    }
    return _label;
}
#pragma mark - Layout
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.label.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 32);
}
@end
