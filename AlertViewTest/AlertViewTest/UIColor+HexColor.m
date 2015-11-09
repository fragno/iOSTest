//
//  UIColor+HexColor.m
//  AlertViewTest
//
//  Created by fragno on 15/10/8.
//  Copyright © 2015年 fragno. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor(HexColor)

+ (UIColor *)colorWithHexRGB:(NSString *)hex {
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte = 0, greenByte = 0, blueByte = 0;
    CGFloat alpha = 1.0;
    
    if (nil != hex)
    {
        NSScanner *scanner = [NSScanner scannerWithString:hex];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    
    BOOL hasAlpha = (hex.length == 8);
    if (hasAlpha) {
        redByte = (unsigned char) (colorCode >> 24);
        greenByte = (unsigned char) (colorCode >> 16);
        blueByte = (unsigned char) (colorCode >> 8); // masks off high bits
        alpha = ((float)(colorCode & 0xff)) / 255;
    }
    else {
        redByte = (unsigned char) (colorCode >> 16);
        greenByte = (unsigned char) (colorCode >> 8);
        blueByte = (unsigned char) (colorCode); // masks off high bits
    }
    
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alpha];
    
    return result;
}

@end
