//
//  CTFrameParserConfig.h
//  Community
//
//  Created by MAC on 2020/5/29.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTFrameParserConfig : NSObject

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat fontSize;
@property (assign, nonatomic) CGFloat lineSpace;
@property (strong, nonatomic) UIColor * textColor;

@end

NS_ASSUME_NONNULL_END
