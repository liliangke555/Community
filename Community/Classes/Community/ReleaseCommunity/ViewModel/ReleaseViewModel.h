//
//  ReleaseViewModel.h
//  Community
//
//  Created by MAC on 2020/6/8.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReleaseViewModel : NSObject

- (void)uploadDataCompletion:(void(^)(BOOL succeed))completion;

@end

NS_ASSUME_NONNULL_END
