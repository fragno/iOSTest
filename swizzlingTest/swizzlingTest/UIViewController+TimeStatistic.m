//
//  UIViewController+TimeStatistic.m
//  swizzlingTest
//
//  Created by fragno on 15/9/9.
//  Copyright (c) 2015年 fragno. All rights reserved.
//

#import "UIViewController+TimeStatistic.h"
#import <objc/runtime.h>

@implementation UIViewController (TimeStatistic)

+ (void)load
{
    SEL originalViewDidAppearSelector = @selector(viewDidAppear:);
    SEL swizzledViewDidAppearSelector = @selector(swizzled_viewDidAppear:);
    Method originalViewDidAppearMethod = class_getInstanceMethod(self, originalViewDidAppearSelector);
    Method swizzledViewDidAppearMethod = class_getInstanceMethod(self, swizzledViewDidAppearSelector);
    class_addMethod(self, originalViewDidAppearSelector,
                    class_getMethodImplementation(self, originalViewDidAppearSelector),
                    method_getTypeEncoding(originalViewDidAppearMethod));
    
    class_addMethod(self, swizzledViewDidAppearSelector,
                    class_getMethodImplementation(self, swizzledViewDidAppearSelector),
                    method_getTypeEncoding(swizzledViewDidAppearMethod));
    method_exchangeImplementations(originalViewDidAppearMethod, swizzledViewDidAppearMethod);
    
    
    SEL originalViewDidDisappearSelector = @selector(viewDidDisappear:);
    SEL swizzledViewDidDisappearSelector = @selector(swizzled_viewDidDisappear:);
    Method originalViewDidDisappearMethod = class_getInstanceMethod(self, originalViewDidDisappearSelector);
    Method swizzledViewDidDisappearMethod = class_getInstanceMethod(self, swizzledViewDidDisappearSelector);
    class_addMethod(self, originalViewDidDisappearSelector,
                    class_getMethodImplementation(self, originalViewDidDisappearSelector),
                    method_getTypeEncoding(originalViewDidDisappearMethod));
    class_addMethod(self, swizzledViewDidDisappearSelector,
                    class_getMethodImplementation(self, swizzledViewDidDisappearSelector),
                    method_getTypeEncoding(swizzledViewDidDisappearMethod));
    method_exchangeImplementations(originalViewDidDisappearMethod, swizzledViewDidDisappearMethod);
    
    
}


- (void)swizzled_viewDidAppear:(BOOL)animated
{
    [self swizzled_viewDidAppear:animated];
    NSLog(@"%lf, %@", [[NSDate date] timeIntervalSince1970], [self description]);
    
}

- (void)swizzled_viewDidDisappear:(BOOL)animated
{
    NSLog(@"%lf, %@", [[NSDate date] timeIntervalSince1970], [self description]);
    [self swizzled_viewDidDisappear:animated];
}


@end
