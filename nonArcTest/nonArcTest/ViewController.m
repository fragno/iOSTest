//
//  ViewController.m
//  nonArcTest
//
//  Created by chrisfnxu on 6/23/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "ViewController.h"
#import "TestSingleton.h"
#import "TestObject.h"

static NSArray *testArray;

@interface ViewController ()
{
    NSString *procrtCarrierName;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
}


#pragma mark -
#pragma mark - test

- (void)test
{
    if ([NSThread isMainThread]) {
        
        __block BOOL complete = NO;
        
        dispatch_block_t block = ^{
            complete = YES;
        };
        
        // 主线程runloop 等待
        while (complete == NO) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                block();
            });
            
            NSDate* waitDate = [NSDate dateWithTimeIntervalSinceNow:0.01f];
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:waitDate];
        }
    }
}

/**
 *  测试对某个对象的变量的强引用不会对该对象retain
 */
- (void)testRetainObjMember
{
    TestObject *obj = [[[TestObject alloc] init] autorelease];
    obj.testArray = [NSArray arrayWithObjects:@"dasdsa", nil];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@", obj.testArray);
        [obj.testArray retain];
    });
}

/**
 * 结论:
 * 1、单例不会导致内存泄漏
 */
- (void)testSingleton
{
    TestSingleton *test = [TestSingleton instance];
    test.str = [[NSString alloc] initWithFormat:@"dadsa"];
    
    NSLog(@"%@", test.str);
    NSLog(@"%@", test.str);
}

// 结论：
// 1、static变量不会导致内存泄漏，初步估计是因为static变量的存储位置和普通的不一样
// 2、block会retain所有的变量，因为Block_Copy会retain全部的变量
- (void)testStaticVariableLeak
{
    
    testArray = [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"4", nil];
    
    
    NSLog(@"%ld", (long)[testArray retainCount]);
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"%ld", (long)[testArray retainCount]);
        NSLog(@"%ld", (long)[testArray retainCount]);
    });
}

@end
