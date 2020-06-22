//
//  CoreTextView.m
//  Community
//
//  Created by MAC on 2020/5/29.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "CoreTextView.h"
#import "CoreTextData.h"
#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"

@implementation CoreTextView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = self.bounds.size.width;
    config.lineSpace = 0.0f;
    config.fontSize = 15.0f;
    if (@available(iOS 13.0, *)) {
        config.textColor = [UIColor systemIndigoColor];
    } else {
        // Fallback on earlier versions
    }
    self.data = [CTFrameParser parseContent:@"CoreText是用于处理文字和字体的底层技术。它直接和Core Graphics(又被称为Quartz)打交道。Quartz是一个2D图形渲染引擎，能够处理OSX和iOS中图形显示问题。Quartz能够直接处理字体（font）和字形（glyphs），将文字渲染到界面上，它是基础库中唯一能够处理字形的模块。因此CoreText为了排版，需要将显示的文字内容、位置、字体、字形直接传递给Quartz。与其他UI组件相比，由于CoreText直接和Quartz来交互，所以它具有更高效的排版功能。下面是CoreText的架构图，可以看到，CoreText处在非常底层的位置，上层的UI控件（包含UILable、UITextField及UITextView）和UIWebView都是基于CoreText来实现的。"
                                     config:config];
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }
}


@end
