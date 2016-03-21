//
//  ColorPickerView.h
//  PaintDemo
//
//  Created by fragno on 16/3/7.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerViewProtocol <NSObject>

@optional
- (void)colorPicked:(UIColor *)color;

@end

@interface ColorPickerView : UIView

@property (nonatomic, strong) NSArray *colors;

@property (nonatomic, weak) id<ColorPickerViewProtocol> delegate;

@end
