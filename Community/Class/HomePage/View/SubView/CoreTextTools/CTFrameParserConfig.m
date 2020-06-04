//
//  CTFrameParserConfig.m
//  Community
//
//  Created by MAC on 2020/5/29.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = RGBACOLOR(108, 108, 108, 1);
    }
    return self;
}

@end
