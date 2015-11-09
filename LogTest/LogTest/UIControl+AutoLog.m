//
//  UIControl+AutoLog.m
//  LogTest
//
//  Created by fragno on 15/11/5.
//  Copyright © 2015年 fragno. All rights reserved.
//

#import "UIControl+AutoLog.h"
#import "UIView+LogName.h"
#import <objc/runtime.h>

@implementation UIControl (AutoLog)

+ (void)load
{
    Method original = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method replacement = class_getInstanceMethod(self, @selector(sendAutoLogAction:to:forEvent:));
    method_exchangeImplementations(original, replacement);
}

- (void)sendAutoLogAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [self sendAutoLogAction:action to:target forEvent:event];
    
    UIView *view = [self superview];
    NSString *logString = self.logName;
    while (![view isMemberOfClass:[UIWindow class]] && view) {
        logString = [NSString stringWithFormat:@"%@|%@", view.logName, logString];
        
        view = [view superview];
    }
    
    NSLog(@"%@|%@", logString, self.logAction);
}

@end
