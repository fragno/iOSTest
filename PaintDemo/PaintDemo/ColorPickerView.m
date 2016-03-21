//
//  ColorPickerView.m
//  PaintDemo
//
//  Created by fragno on 16/3/7.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "ColorPickerView.h"

@interface ColorPickerView ()

@property (nonatomic, strong) CAGradientLayer *gradentLayer;

@end


@implementation ColorPickerView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}

#pragma mark - Action
- (void)tapped:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(colorPicked:)]) {
        [self.delegate colorPicked:[self colorOfPoint:[sender locationInView:self]]];
    }
    
    NSLog(@"%@", [self colorOfPoint:[sender locationInView:self]]);
}

#pragma mark - Setters && Getters
- (CAGradientLayer *)gradentLayer
{
    return (CAGradientLayer *)self.layer;
}

- (void)setColors:(NSArray *)colors
{
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)[color CGColor]];
    }
    
    self.gradentLayer.colors = cgColors;
}

#pragma mark - Private
- (UIColor *)colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [self.layer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

@end
