//
//  CodeResignView.h
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CodeResignCompleted)(NSString *content);
typedef void (^CodeResignUnCompleted)(NSString *content);

@interface CodeResignView : UIView

@property (copy, nonatomic) CodeResignCompleted codeResignCompleted;
@property (copy, nonatomic) CodeResignUnCompleted codeResignUnCompleted;

- (instancetype) initWithCodeBits:(NSInteger)codeBits;

@end

NS_ASSUME_NONNULL_END
