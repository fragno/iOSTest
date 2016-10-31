//
//  DemoView.m
//  CGContextTest
//
//  Created by fragno on 16/10/20.
//  Copyright © 2016年 alipay. All rights reserved.
//

#import "DemoView.h"

@implementation DemoView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
    /*
     context.setLineWidth(10)
     context.setLineCap("round")
     context.setLineJoin("miter")
     context.setMiterLimit(10)
     context.moveTo(20, 20)
     context.lineTo(150, 27)
     context.lineTo(20, 54)
     context.stroke()
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);
    CGContextSetLineWidth(context, 10);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    CGContextMoveToPoint(context, 20, 20);
    CGContextAddLineToPoint(context, 150, 27);
    CGContextAddLineToPoint(context, 20, 54);
    CGContextStrokePath(context);
}

@end
