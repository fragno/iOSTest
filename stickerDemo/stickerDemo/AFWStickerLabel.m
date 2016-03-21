//
// AFWStickerLabel.m
//
// Created by fragno on 3/2/16.
// Copyright (c) 2016 alipay. All rights reserved.
//

#import "AFWStickerLabel.h"


#define kSPUserResizableViewGlobalInset 5.0
#define kSPUserResizableViewDefaultMinWidth 48.0
#define kSPUserResizableViewInteractiveBorderSize 10.0
#define kZDStickerViewControlSize 36.0


@interface AFWStickerLabel () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *resizingControl;
@property (strong, nonatomic) UIImageView *closeControl;

@property (nonatomic) BOOL preventsLayoutWhileResizing;

@property (nonatomic) CGFloat prevAngle;
@property (nonatomic) CGPoint prevPoint;
@property (nonatomic) CGAffineTransform startTransform;

@property (nonatomic) CGPoint touchStart;
@property (nonatomic, weak) UITouch *touch;

@property (nonatomic, assign) BOOL isScaling;
@property (nonatomic, assign) BOOL isRotating;

@property (nonatomic, assign) CGRect originalContentFrame;

@property (nonatomic, assign) BOOL isInStickerMode;

@end



@implementation AFWStickerLabel
@synthesize isInStickerMode = _isInStickerMode;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupDefaultAttributes];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupDefaultAttributes];
    }
    
    return self;
}

- (void)exitStickerMode
{
    if (self.isInStickerMode) {
        self.isInStickerMode = NO;
    }
}

- (void)enterStickerMode
{
    if (!self.isInStickerMode) {
        self.isInStickerMode = YES;
    }
}


#pragma mark - Override
- (void)drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = {20, 50, 20, 50};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self isTransforming]) {
        return;
    }
    
    [self enableTransluceny:YES];
    
    if (!self.touch) {
        self.touch = [touches anyObject];
    }
    self.touchStart = [self.touch locationInView:self.superview];
    if ([self.stickerLabelDelegate respondsToSelector:@selector(stickerDidBeginEditing:)]) {
        [self.stickerLabelDelegate stickerDidBeginEditing:self];
    }
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self enableTransluceny:NO];
    
    // Notify the delegate we've ended our editing session.
    if ([self.stickerLabelDelegate respondsToSelector:@selector(stickerDidEndEditing:)]) {
        [self.stickerLabelDelegate stickerDidEndEditing:self];
    }
}



- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self enableTransluceny:NO];
    
    // Notify the delegate we've ended our editing session.
    if ([self.stickerLabelDelegate respondsToSelector:@selector(stickerDidCancelEditing:)]) {
        [self.stickerLabelDelegate stickerDidCancelEditing:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self isTransforming] || touches.count > 1) {
        return;
    }
    
    [self enableTransluceny:YES];
    
    CGPoint touchLocation = [self.touch locationInView:self];
    if (CGRectContainsPoint(self.resizingControl.frame, touchLocation)) {
        return;
    }
    
    // 移动过了之后，进入sticker模式
    [self enterStickerMode];
    
    CGPoint touch = [self.touch locationInView:self.superview];
    [self translateUsingTouchLocation:touch];
    self.touchStart = touch;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


#pragma mark - GestureRecognizer
- (void)closeTap:(UIPanGestureRecognizer *)recognizer
{
    if ([self.stickerLabelDelegate respondsToSelector:@selector(stickerDidClose:)]) {
        [self.stickerLabelDelegate stickerDidClose:self];
    }

    UIView *close = (UIView *)[recognizer view];
    [close.superview removeFromSuperview];
}

- (void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateBegan) {
        [self enableTransluceny:YES];
        self.prevPoint = [recognizer locationInView:self.superview];
        self.prevAngle = atan2([recognizer locationInView:self.superview].y - self.center.y,
                               [recognizer locationInView:self.superview].x - self.center.x);
        
    } else if ([recognizer state] == UIGestureRecognizerStateChanged) {
        [self enableTransluceny:YES];
        self.layer.anchorPoint = CGPointMake(0.5, 0.5);
        
        // Resizing
        CGPoint point = [recognizer locationInView:self.superview];
        float wRatioChange = [self distanceBetweenPoint1:point point2:self.center] / [self distanceBetweenPoint1:self.prevPoint point2:self.center];
        CGAffineTransform scaleform = CGAffineTransformScale(self.transform, wRatioChange, wRatioChange);
        self.prevPoint = [recognizer locationInView:self.superview];
        
        
        // Rotation
        float ang = atan2([recognizer locationInView:self.superview].y - self.center.y,
                          [recognizer locationInView:self.superview].x - self.center.x);
        float angleDiff = self.prevAngle - ang;
        CGAffineTransform rotateForm = CGAffineTransformMakeRotation(-angleDiff);
        self.transform = CGAffineTransformConcat(rotateForm, scaleform);
        self.prevAngle = ang;
        
        // 调整close和resize位置
        CGAffineTransform originalTransform = CGAffineTransformInvert(self.transform);
        [self.closeControl setTransform:originalTransform];
        [self.resizingControl setTransform:originalTransform];
        
    } else if ([recognizer state] == UIGestureRecognizerStateEnded) {
        [self enableTransluceny:NO];
    }
}

- (void)rotateView:(UIRotationGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
        sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
        [sender setRotation:0];
    }
}

- (void)pinchView:(UIPinchGestureRecognizer *)sender
{
    [self adjustAnchorPointForGestureRecognizer:sender];
    
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
        sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
        sender.scale = 1;
        
        // 调整close和resize位置
        CGAffineTransform originalTransform = CGAffineTransformInvert(sender.view.transform);
        [self.closeControl setTransform:originalTransform];
        [self.resizingControl setTransform:originalTransform];
    }
}

#pragma mark - Private
- (CGFloat)distanceBetweenPoint1:(CGPoint)point1 point2:(CGPoint)point2
{
    CGFloat dx = point1.x - point2.x;
    CGFloat dy = point1.y - point2.y;
    return sqrt(dx*dx + dy*dy);
}

- (void)setupDefaultAttributes
{
    self.userInteractionEnabled = YES;
    
    if (kSPUserResizableViewDefaultMinWidth > self.bounds.size.width*0.5) {
        self.minWidth = kSPUserResizableViewDefaultMinWidth;
        self.minHeight = self.bounds.size.height * (kSPUserResizableViewDefaultMinWidth/self.bounds.size.width);
        
    } else {
        self.minWidth = self.bounds.size.width*0.5;
        self.minHeight = self.bounds.size.height*0.5;
    }

    self.preventsPositionOutsideSuperview = YES;
    self.preventsLayoutWhileResizing = YES;
    self.translucencySticker = YES;

    self.closeControl = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                      kZDStickerViewControlSize, kZDStickerViewControlSize)];
    self.closeControl.backgroundColor = [UIColor clearColor];
    self.closeControl.image = [UIImage imageNamed:@"share_close"];
    self.closeControl.userInteractionEnabled = YES;
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTap:)];
    [self.closeControl addGestureRecognizer:closeTap];
    [self addSubview:self.closeControl];
    self.closeControl.center = CGPointMake(0, 0);

    self.resizingControl = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-kZDStickerViewControlSize,
                                                                        self.frame.size.height-kZDStickerViewControlSize,
                                                                        kZDStickerViewControlSize,
                                                                        kZDStickerViewControlSize)];
    self.resizingControl.backgroundColor = [UIColor clearColor];
    self.resizingControl.userInteractionEnabled = YES;
    self.resizingControl.image = [UIImage imageNamed:@"share_resize"];
    UIPanGestureRecognizer*panResizeGesture = [[UIPanGestureRecognizer alloc]
                                               initWithTarget:self
                                                       action:@selector(resizeTranslate:)];
    [self.resizingControl addGestureRecognizer:panResizeGesture];
    [self addSubview:self.resizingControl];
    self.resizingControl.center = CGPointMake(self.frame.size.width, self.frame.size.height);

    self.prevAngle = atan2(self.frame.origin.y+self.frame.size.height - self.center.y,
                            self.frame.origin.x+self.frame.size.width - self.center.x);
    
    [self enterStickerMode]; // 默认sticker模式
    
    [self addGestureRecognizers];
}

- (void)addGestureRecognizers
{
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                          action:@selector(rotateView:)];
    self.multipleTouchEnabled = YES;
    rotationGestureRecognizer.delegate = self;
    [self addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(pinchView:)];
    self.multipleTouchEnabled = YES;
    pinchGestureRecognizer.delegate = self;
    [self addGestureRecognizer:pinchGestureRecognizer];
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}


- (void)enableTransluceny:(BOOL)state
{
    if (self.translucencySticker == YES) {
        if (state == YES) {
            self.alpha = 0.65;
        } else {
            self.alpha = 1.0;
        }
    }
}

- (BOOL)isTransforming
{
    return self.isScaling || self.isRotating;
}


- (void)translateUsingTouchLocation:(CGPoint)touchPoint
{
    CGPoint newCenter = CGPointMake(self.center.x + touchPoint.x - self.touchStart.x,
                                    self.center.y + touchPoint.y - self.touchStart.y);
    
    if (self.preventsPositionOutsideSuperview) {
        // Ensure the translation won't cause the view to move offscreen.
        CGFloat midPointX = CGRectGetMidX(self.bounds);
        if (newCenter.x > self.superview.bounds.size.width - midPointX) {
            newCenter.x = self.superview.bounds.size.width - midPointX;
        }
        
        if (newCenter.x < midPointX) {
            newCenter.x = midPointX;
        }
        
        CGFloat midPointY = CGRectGetMidY(self.bounds);
        if (newCenter.y > self.superview.bounds.size.height - midPointY) {
            newCenter.y = self.superview.bounds.size.height - midPointY;
        }
        
        if (newCenter.y < midPointY) {
            newCenter.y = midPointY;
        }
    }
    
    self.center = newCenter;
}

#pragma mark - Getters && Setters

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    self.resizingControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
                                           self.bounds.size.height-kZDStickerViewControlSize,
                                           kZDStickerViewControlSize,
                                           kZDStickerViewControlSize);

    self.closeControl.frame = CGRectMake(0, 0,
                                          kZDStickerViewControlSize, kZDStickerViewControlSize);
}

- (void)setIsInStickerMode:(BOOL)isInStickerMode
{
    _isInStickerMode = isInStickerMode;
    self.closeControl.hidden = !isInStickerMode;
    self.resizingControl.hidden = !isInStickerMode;
}

- (BOOL)isInStickerMode
{
    return (_isInStickerMode && self.hidden == NO && self.alpha != 0);
}

@end
