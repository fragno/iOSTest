//
//  AFWRunLoopMonitor.m
//  AFWealth
//
//  Created by xunfeng on 15/7/2.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import "AFWRunLoopMonitor.h"

#import <limits.h>

static CFRunLoopObserverRef AFWRunLoopCommonObserver;

/**
 *  @brief  当AFWMoniterPause值为true的时候暂停监视刷新率
 */
static bool AFWMoniterPause = false;

void AFWPerformanceMonitor(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    static int64_t         runloopCycleCount = 0;
    static NSTimeInterval  runloopEnterTime  = 0;
    static NSTimeInterval  runloopWaitTime   = 0;
    static NSTimeInterval  runloopAfterTime  = 0;
    
    switch (activity)
    {
        case kCFRunLoopEntry:
        {
            AS_D(@"RunLoop is Runing");
            runloopEnterTime = [[NSDate date] timeIntervalSince1970];
            break;
        }
        case kCFRunLoopBeforeWaiting:
        {
            
            runloopWaitTime = [[NSDate date] timeIntervalSince1970];
            
            NSTimeInterval interval = 0.0;
            
            if (runloopCycleCount == 1)
            {
                interval = runloopWaitTime - runloopEnterTime;
            }
            else if (runloopCycleCount > 1 && activity == kCFRunLoopBeforeWaiting)
            {
                interval = runloopWaitTime - runloopAfterTime;
            }
            
            if (interval > 0.01755 && !AFWMoniterPause) //理论最大帧率60帧，低于57帧认为有问题
            {
                AS_D(@"Running time exceeds the performance benchmark:(%f)", interval);
            }
            
            if (interval > 1 && !AFWMoniterPause)
            {
                AS_W(@"Running time exceeds the performance Threshold:(%f)", interval);
            }
            
            //AS_D(@"RunLoop is Waiting");
            
            break;
        }
        case kCFRunLoopAfterWaiting:
        {
            runloopAfterTime = [[NSDate date] timeIntervalSince1970];
            break;
        }
        default:
            break;
    }
    
    runloopCycleCount++;
    
    if (runloopCycleCount >= INT64_MAX || runloopCycleCount < 0)
    {
        runloopCycleCount = 1;
    }
    
}


@implementation AFWRunLoopMonitor

+ (void)startMoniter
{
    if (AFWRunLoopCommonObserver)
    {
        return;
    }
    
    [self addNotification];
    
    CFRunLoopObserverContext context = {0 ,(__bridge void *)(self), NULL, NULL};
    
    AFWRunLoopCommonObserver = CFRunLoopObserverCreate(NULL,
                                                    kCFRunLoopEntry | kCFRunLoopBeforeWaiting | kCFRunLoopAfterWaiting,
                                                    true,
                                                    0,
                                                    AFWPerformanceMonitor,
                                                    &context );
    
    CFRunLoopAddObserver(CFRunLoopGetMain(), AFWRunLoopCommonObserver, kCFRunLoopCommonModes);
    
}

+ (void)stopMoniter
{
    if (AFWRunLoopCommonObserver)
    {
        CFRunLoopRemoveObserver(CFRunLoopGetMain(), AFWRunLoopCommonObserver, kCFRunLoopCommonModes);
        CFRelease(AFWRunLoopCommonObserver);
        AFWRunLoopCommonObserver = NULL;
        
        [self removeNotification];
    }
}

+ (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(suspendMonitor) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartMonitor) name:UIKeyboardDidHideNotification object:nil];
}

+ (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (void)suspendMonitor
{
    AFWMoniterPause = true;
}

+ (void)restartMonitor
{
    AFWMoniterPause = false;
}

@end
