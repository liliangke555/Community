//
//  PrivacyModel.h
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrivacyModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSString *imageUrl;

- (instancetype)initWithTitle:(NSString *)title details:(NSString *)details imae:(NSString *)imageUrl;

@end

NS_ASSUME_NONNULL_END
