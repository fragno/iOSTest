//
//  AntLogoView.m
//  CGTest
//
//  Created by fragno on 15/9/7.
//  Copyright (c) 2015年 fragno. All rights reserved.
//

#import "AntLogoView.h"

@implementation AntLogoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}



- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 基本设置
    CGFloat lineWidth = 10.0;
    CGFloat outRadius = 50.0;
    CGFloat innerRadius = 20.0;
    CGPoint center = CGPointMake(750/4, 320);
    
    // 设置画笔线条粗细
    CGContextSetLineWidth(context, lineWidth);
    // 设置线条样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 设置画笔颜色：黑色
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    
    CGContextBeginPath(context);
    CGPoint point1 = CGPointMake(center.x - outRadius*cos(0.4*M_PI) - outRadius*0.4,
                                 center.y - outRadius*sin(0.4*M_PI) - outRadius*0.4);
    CGPoint point2 = CGPointMake(center.x - outRadius*cos(0.4*M_PI),
                                 center.y - outRadius*sin(0.4*M_PI));
    CGPoint point3 = CGPointMake(center.x + outRadius*cos(0.4*M_PI),
                                 center.y - outRadius*sin(0.4*M_PI));
    CGPoint point4 = CGPointMake(center.x + outRadius*cos(0.4*M_PI) + outRadius*0.4,
                                 center.y - outRadius*sin(0.4*M_PI) - outRadius*0.4);
    
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextAddArc(context, center.x, center.y, outRadius, 1.4*M_PI, -0.4*M_PI, YES);
    CGContextAddLineToPoint(context, point3.x, point3.y);
    CGContextAddLineToPoint(context, point4.x, point4.y);
    
    CGContextMoveToPoint(context, center.x+innerRadius, center.y);
    CGContextAddArc(context, center.x, center.y, innerRadius, 0, M_PI, NO);
    
    
    
    // 执行绘画
    CGContextStrokePath(context);
}

@end
