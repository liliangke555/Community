//
//  ReleaseViewModel.m
//  Community
//
//  Created by MAC on 2020/6/8.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "ReleaseViewModel.h"

@implementation ReleaseViewModel

- (void)uploadDataCompletion:(void (^)(BOOL))completion
{
    if (completion) {
        completion(YES);
    }
}

@end
