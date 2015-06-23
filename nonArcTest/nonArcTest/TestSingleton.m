//
//  TestSingleton.m
//  nonArcTest
//
//  Created by chrisfnxu on 6/23/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "TestSingleton.h"

@implementation TestSingleton

+ (instancetype)instance
{
    static TestSingleton *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            [[[self class] alloc] init];
        }
    });
    
    return instance;
}



@end
