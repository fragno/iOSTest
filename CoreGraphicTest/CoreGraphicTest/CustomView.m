//
//  CustomView.m
//  CoreGraphicTest
//
//  Created by fragno on 16/11/9.
//  Copyright © 2016年 alipay. All rights reserved.
//

#import "CustomView.h"
#import <CoreText/CoreText.h>

@implementation CustomView

- (void)drawRect:(CGRect)rect {
    [super drawRect: rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorRef blackColor =[[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f] CGColor];
//    CGContextSetFillColor(context, CGColorGetComponents(blackColor));
//    const char* test = "Hello world";
//    CGContextSelectFont(context, "Helvetica", 20, kCGEncodingMacRoman);
//    CGContextShowTextAtPoint(context, 0, 200, test, strlen(test));
//    
//    const char* str = "This is English text(Quartz 2D).";
//    CGContextShowTextAtPoint(context, 0, 100, str, strlen(str));
//    
//    const char* str1 = "这是中文文本(Quartz 2D)。";
//    CGContextShowTextAtPoint(context, 0, 150, str1, strlen(str1));
//    CGContextAddRect(context, CGRectMake(100, 100, 20, 20));
//    CGContextStrokePath(context);
//
//    CGContextSetFontSize(context, 20);
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置字形变换矩阵为CGAffineTransformIdentity，也就是说每一个字形都不做图形变换
//    CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);
//    CGContextConcatCTM(context, flipVertical);
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"测试富文本显示"];
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 7)];
//    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attributedString);
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect bounds = CGRectMake(10, -100.0, self.bounds.size.width, self.bounds.size.height);
//    CGPathAddRect(path, NULL, bounds);
//    
//    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter,CFRangeMake(0, 0), path, NULL);
//    CTFrameDraw(ctFrame, context);
    
    UniChar *characters;
    CGGlyph *glyphs;
    CFIndex count;
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置字形变换矩阵为CGAffineTransformIdentity，也就是说每一个字形都不做图形变换
    CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);
    CGContextConcatCTM(context, flipVertical);
    
    CTFontRef ctFont = CTFontCreateWithName(CFSTR("STHeitiSC-Light"), 20.0, NULL);
    CTFontDescriptorRef ctFontDesRef = CTFontCopyFontDescriptor(ctFont);
    CFNumberRef pointSizeRef = (CFNumberRef)CTFontDescriptorCopyAttribute(ctFontDesRef, kCTFontSizeAttribute);
    
    CGFontRef cgFont = CTFontCopyGraphicsFont(ctFont,&ctFontDesRef );
    CGContextSetFont(context, cgFont);

    CGFloat fontSize;
    CFNumberGetValue(pointSizeRef, kCFNumberCGFloatType,&fontSize);
    CGContextSetFontSize(context, fontSize);
    NSString* str2 = @"这是中文文本(Quartz 2D)。";
    count = CFStringGetLength((CFStringRef)str2);
    characters = (UniChar *)malloc(sizeof(UniChar) * count);
    glyphs = (CGGlyph *)malloc(sizeof(CGGlyph) * count);
    CFStringGetCharacters((CFStringRef)str2, CFRangeMake(0, count), characters);
    CTFontGetGlyphsForCharacters(ctFont, characters, glyphs, count);
    CGContextShowGlyphsAtPoint(context, 0, self.bounds.size.height - 40, glyphs, str2.length);
    
    free(characters);
    free(glyphs);
    
}

@end
