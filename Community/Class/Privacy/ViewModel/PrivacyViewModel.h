//
//  PrivacyViewModel.h
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^callback) (NSArray *array);

@interface PrivacyViewModel : NSObject

- (void)requestWithCallback:(callback)callBack;

@end

NS_ASSUME_NONNULL_END
