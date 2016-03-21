//
//  ActionManager.m
//  InnerAppRuler
//
//  Created by fragno on 16/3/14.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "ActionManager.h"

@implementation ActionManager

+ (instancetype)instanceManager
{
    static ActionManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ActionManager alloc] init];
    });
    
    return instance;
}

@end
