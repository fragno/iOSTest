//
// AFWStickerLabel.h
//
// Created by fragno on 3/2/16.
// Copyright (c) 2016 alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AFWStickerLabelDelegate;


@interface AFWStickerLabel : UILabel

/**
 *  控制是否可以移出父view，default = YES
 */
@property (nonatomic, assign) BOOL preventsPositionOutsideSuperview;

/**
 *  缩放的时候sticker是否半透明
 */
@property (nonatomic, assign) BOOL translucencySticker;

/**
 *  是否处于stickerMode，sticker模式即可以关闭、伸缩、平移、旋转的模式
 */
@property (nonatomic, assign, readonly) BOOL isInStickerMode;

/**
 *  缩放最小宽度
 */
@property (nonatomic, assign) CGFloat minWidth;

/**
 *  缩放最小高度
 */
@property (nonatomic, assign) CGFloat minHeight;


@property (weak, nonatomic) id <AFWStickerLabelDelegate> stickerLabelDelegate;


/**
 *  退出sticker模式
 */
- (void)exitStickerMode;

/**
 *  进入sticker模式
 */
- (void)enterStickerMode;

@end


@protocol AFWStickerLabelDelegate <NSObject>
@optional
- (void)stickerDidBeginEditing:(AFWStickerLabel *)sticker;
- (void)stickerDidEndEditing:(AFWStickerLabel *)sticker;
- (void)stickerDidCancelEditing:(AFWStickerLabel *)sticker;
- (void)stickerDidClose:(AFWStickerLabel *)sticker;
@end
