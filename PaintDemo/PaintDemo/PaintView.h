//
//  PaintView.h
//  PaintDemo
//
//  Created by fragno on 16/3/4.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PaintSetting : NSObject

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 *  线条宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 *  线条存储容量，决定回退次数
 */
@property (nonatomic, assign) NSUInteger linesCapacity;


+ (instancetype)paintSetting;

@end


@interface PaintView : UIView

/**
 *  画图板设置参数
 */
@property (nonatomic, strong) PaintSetting *paintSetting;


/**
 *  初始化
 */
- (instancetype)initWithPaintSetting:(PaintSetting *)paintSetting;

/**
 *  撤销操作
 */
- (void)undo;

/**
 *  恢复操作
 */
- (void)redo;

/**
 *  清楚操作
 */
- (void)clean;

@end
