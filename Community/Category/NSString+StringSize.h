//
//  NSString+StringSize.h
//  Community
//
//  Created by MAC on 2020/6/3.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (StringSize)

- (CGFloat)getLabelHeightWithWidth:(CGFloat)width font: (CGFloat)font;

- (CGFloat)getWidthWithHeight:(CGFloat)height font:(CGFloat)font;

@end

NS_ASSUME_NONNULL_END
