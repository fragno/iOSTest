//
//  ViewController.m
//  RunloopTest
//
//  Created by chrisfnxu on 3/26/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 在新线程中运行：
    [self performSelectorInBackground:@selector(testRunloop) withObject:nil];
}

- (void)testRunloop
{
    // 获取当前线程的Run loop
    NSRunLoop* myRunLoop = [NSRunLoop currentRunLoop];
    
    // 创建一个run loop观察者对象；观察事件为每次循环的所有活动；
    CFRunLoopObserverContext  context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    CFRunLoopObserverRef  observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                             kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
    if (observer)
    {
        // 将Cocoa的NSRunLoop类型转换成Core Foundation的CFRunLoopRef类型
        CFRunLoopRef cfLoop = [myRunLoop getCFRunLoop];
        // 添加观察者对象到该run loop上
        CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
    }
    
    // 创建定时器，每0.1秒触发
    //    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(doFireTimer:) userInfo:nil repeats:YES];

    [self performSelector:@selector(printHello3) withObject:self afterDelay:0.1];
    [self performSelector:@selector(printHello2) withObject:self afterDelay:0.1];
    [self performSelector:@selector(printHello) withObject:self afterDelay:0.1];
    
    //  重复启动run loop 5次：
    NSInteger loopCount = 5;
    do
    {
        NSLog(@"loopCount: %ld", loopCount);
        // 启动run loop开始循环，直到指定的时间才结束，这里就是持续1秒；
        // 当调用runUnitDate方法时，观察者检测到循环已经启动，开始根据循环的各个阶段的事件，调用上面注册的myRunLoopObserver回调函数。
        [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        // 运行完之后，会再一次调用回调函数，状态是kCFRunLoopExit，表示循环结束。
        
        loopCount--;
    }
    while (loopCount);
    
    NSLog(@"The End.");
}

- (void)doFireTimer:(NSTimer*)timer
{
    NSLog(@"fire timer!");
}

- (void)printHello
{
    NSLog(@"hello world");
}

- (void)printHello2
{
    NSLog(@"hello world 2");
}

- (void)printHello3
{
    NSLog(@"hello world 3");
}

// Run loop观察者的回调函数：
void myRunLoopObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"run loop entry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"run loop before timers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"run loop before sources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"run loop before waiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"run loop after waiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"run loop exit");
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
