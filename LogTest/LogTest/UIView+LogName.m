//
//  UIView+LogName.m
//  LogTest
//
//  Created by fragno on 15/11/5.
//  Copyright © 2015年 fragno. All rights reserved.
//

#import "UIView+LogName.h"
#import <objc/runtime.h>

static const void *logNameKey = &logNameKey;
static const void *logActionKey = &logActionKey;

@implementation UIView (LogName)
@dynamic logName;
@dynamic logAction;

- (NSString *)logName
{
    return objc_getAssociatedObject(self, logNameKey);
}

- (void)setLogName:(NSString *)logName
{
    objc_setAssociatedObject(self, logNameKey, logName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)logAction
{
    return objc_getAssociatedObject(self, logActionKey);
}

- (void)setLogAction:(NSString *)logAction
{
    objc_setAssociatedObject(self, logActionKey, logAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
