//
//  LoadingView.h
//  LoadingTest
//
//  Created by fragno on 15/8/7.
//  Copyright (c) 2015年 fragno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

+ (LoadingView *)showInView:(UIView *)view animating:(BOOL)animating;
+ (LoadingView *)showInView:(UIView *)view animating:(BOOL)animating modal:(BOOL)modal;
+ (LoadingView *)showInWindowWithAnimating:(BOOL)animating modal:(BOOL)modal;
+ (void)stopInView:(UIView *)view;
+ (void)stopInWindow;

@end
