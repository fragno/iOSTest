//
//  SceneManager.m
//  InnerAppRuler
//
//  Created by fragno on 16/3/14.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "SceneManager.h"

@implementation SceneManager

+ (instancetype)instanceManager
{
    static SceneManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SceneManager alloc] init];
    });
    
    return instance;
}

@end
