//
//  UIViewController+AutoLog.m
//  LogTest
//
//  Created by fragno on 15/11/5.
//  Copyright © 2015年 fragno. All rights reserved.
//

#import "UIViewController+AutoLog.h"
#import "UIView+LogName.h"
#import <objc/runtime.h>

@implementation UIViewController (AutoLog)

+ (void)load
{
    Method originalViewDidAppear = class_getInstanceMethod(self, @selector(viewDidAppear:));
    Method replacementViewDidAppear = class_getInstanceMethod(self, @selector(autoLogViewDidAppear:));
    method_exchangeImplementations(originalViewDidAppear, replacementViewDidAppear);
    
    Method originalViewDidDisAppear = class_getInstanceMethod(self, @selector(viewDidDisappear:));
    Method replacementViewDidDisAppear = class_getInstanceMethod(self, @selector(autoLogViewDidDisappear:));
    method_exchangeImplementations(originalViewDidDisAppear, replacementViewDidDisAppear);
}

- (void)autoLogViewDidAppear:(BOOL)animated
{
    [self autoLogViewDidAppear:animated];
    
    UIView *view = [self.view superview];
    NSString *logString = self.view.logName;
    while (![view isMemberOfClass:[UIWindow class]] && view) {
        logString = [NSString stringWithFormat:@"%@|%@", view.logName, logString];
        
        view = [view superview];
    }
    
    NSLog(@"%@|openPage", logString);
}

- (void)autoLogViewDidDisappear:(BOOL)animated
{
    [self autoLogViewDidDisappear:animated];
    
    UIView *view = [self.view superview];
    NSString *logString = self.view.logName;
    while (![view isMemberOfClass:[UIWindow class]] && view) {
        logString = [NSString stringWithFormat:@"%@|%@", view.logName, logString];
        
        view = [view superview];
    }
    
    NSLog(@"%@|closePage", logString);
}

@end
