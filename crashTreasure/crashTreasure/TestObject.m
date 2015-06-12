//
//  TestObject.m
//  crashTreasure
//
//  Created by chrisfnxu on 6/11/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

- (void) test
{
    __block TestObject* weakSelf = self;
    double delayInSeconds = 5.0;
    NSLog(@"block will execute in %lf s", delayInSeconds);
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"%@", weakSelf.testString);
    });
}

@end
