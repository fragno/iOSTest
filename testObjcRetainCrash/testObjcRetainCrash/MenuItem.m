//
//  MenuItem.m
//  testObjcRetainCrash
//
//  Created by chrisfnxu on 6/29/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (instancetype)initWIthTarget:(id)target action:(SEL)action withObject:(id)object
{
    if (self = [super init]) {
        self.target = target;
        self.action = action;
        self.object = object;
    }
    
    return self;
}

- (void)performAction
{
    if (self.target && self.action)
    {
        if (self.object)
        {
            [self.target performSelector:self.action withObject:self.object];
        }
        else
        {
            [self.target performSelector:self.action];
        }
    }
}

@end
