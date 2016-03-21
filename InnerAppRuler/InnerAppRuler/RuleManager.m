//
//  RuleManager.m
//  InnerAppRuler
//
//  Created by fragno on 16/3/14.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "RuleManager.h"

@implementation RuleManager

+ (instancetype)instanceManager
{
    static RuleManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RuleManager alloc] init];
    });
    
    return instance;
}

@end
