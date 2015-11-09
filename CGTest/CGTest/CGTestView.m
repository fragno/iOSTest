//
//  CGTestView.m
//  CGTest
//
//  Created by fragno on 15/9/6.
//  Copyright (c) 2015年 fragno. All rights reserved.
//

#import "CGTestView.h"

typedef enum : NSUInteger {
    AFWActivityMenuArrowUp = 1UL << 0,
    AFWActivityMenuArrowDown = 1UL << 1
} AFWActivityMenuArrowDirection;

@interface CGTestView()

@property(nonatomic, assign) AFWActivityMenuArrowDirection arrowDirection;
@property(nonatomic, assign) NSInteger arrowWidth;
@property(nonatomic, assign) NSInteger arrowHeight;
@property(nonatomic, assign) NSInteger roundCorner;

@end

@implementation CGTestView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.arrowDirection = AFWActivityMenuArrowUp;
        self.arrowHeight = 10;
        self.arrowWidth = 10;
        self.roundCorner = 50;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width, height = rect.size.height - 200;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    if (self.arrowDirection == AFWActivityMenuArrowDown) {
        CGPathMoveToPoint(path, NULL, rect.origin.x + self.roundCorner, rect.origin.y);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + width - self.roundCorner, rect.origin.y);
        CGPathAddArc(path, NULL, rect.origin.x+width-self.roundCorner, rect.origin.y + self.roundCorner, self.roundCorner, -0.5*M_PI, 0, NO);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + width, rect.origin.y + height - self.roundCorner);
        CGPathAddArc(path, NULL, rect.origin.x + width - self.roundCorner, rect.origin.y + height - self.roundCorner, self.roundCorner, 0, 0.5*M_PI, NO);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + width / 2 + self.arrowWidth / 2  , rect.origin.y + height);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + width / 2, rect.origin.y + height + self.arrowHeight);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + width / 2 - self.arrowWidth / 2, rect.origin.y + height);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + self.roundCorner, rect.origin.y + height);
        CGPathAddArc(path, NULL, rect.origin.x + self.roundCorner, rect.origin.y + height - self.roundCorner, self.roundCorner, 0.5*M_PI, M_PI, NO);
        CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + self.roundCorner);
        CGPathAddArc(path, NULL, rect.origin.x + self.roundCorner, rect.origin.y + self.roundCorner, self.roundCorner, M_PI, 1.5*M_PI, NO);
    } else {
        CGPathMoveToPoint(path, NULL, rect.origin.x + self.roundCorner, rect.size.height);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + width - self.roundCorner, rect.size.height);
        CGPathAddArc(path, NULL, rect.origin.x + width - self.roundCorner, rect.size.height - self.roundCorner, self.roundCorner, 0.5*M_PI, 0, YES);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + width,  self.arrowHeight + self.roundCorner);
        CGPathAddArc(path, NULL, rect.origin.x + width - self.roundCorner, self.arrowHeight + self.roundCorner, self.roundCorner, 0, -0.5*M_PI, YES);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + width / 2 + self.arrowWidth / 2  , self.arrowHeight);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + width / 2, 0);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + width / 2 - self.arrowWidth / 2, self.arrowHeight);
        CGPathAddLineToPoint(path, NULL, rect.origin.x + self.roundCorner, self.arrowHeight);
        CGPathAddArc(path, NULL, rect.origin.x + self.roundCorner, rect.origin.y + self.arrowHeight + self.roundCorner, self.roundCorner, -0.5*M_PI, -M_PI, YES);
        CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.size.height - self.roundCorner);
        CGPathAddArc(path, NULL, rect.origin.x + self.roundCorner, rect.size.height - self.roundCorner, self.roundCorner, M_PI, 0.5*M_PI, YES);
    }
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    CGContextFillPath(context);
    CGPathRelease(path);
}


@end
