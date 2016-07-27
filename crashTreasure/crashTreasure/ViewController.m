//
//  ViewController.m
//  crashTreasure
//
//  Created by chrisfnxu on 6/11/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

#import "TestObject.h"

typedef void (^TestBlock)();

@interface ViewController ()

@property (nonatomic, strong) NSString *unrecognizedSelectorSentStr;
@property (nonatomic, strong) NSMutableArray *testArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:nil
                        options:(NSJSONWritingOptions)NSJSONReadingAllowFragments
                        error:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - testCrash

/**
 *  测试objc_retain crash
 *  使用：在viewdidload中调用[self performSelector:@selector(crashWithIdParam:)];
 *  会造成objc_retaincrash，原因是param对象非法
 */
- (void)crashWithIdParam:(id)param
{
    NSLog(@"let's crash, %@", param);
}


/**
 *  测试对象被释放导致的crash
 *  change the project to non-arc to test
 */
- (void)test
{
#if 0
    TestObject* obj = [[[TestObject alloc] init] autorelease];
    [obj test];
#endif
}

/**
 *  模拟被0除的crash
 */
- (void)crash_divide_by_zero
{
    unsigned int divider = 0;
    unsigned int dividend = 10;
    
    NSLog(@"%d", dividend/divider);
}

/**
 *  模拟对象被释放后发送消息造成的crash
 */
- (void)crash_unrecognized_selector_sent
{
//    Method classMethod = class_getClassMethod ([self class], @selector(hellocrash));
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused"
    Method obj = class_getClassMethod([self class], @selector(alloc));
    
    id (*typed_msgSend)(id, SEL) = (void *)objc_msgSend;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    id obj1 = typed_msgSend(self, @selector(hellocrash));
#pragma clang diagnostic pop
#pragma clang diagnostic pop
}

/**
 *  模拟竞争crash
 */
- (void)crash_SEGV_ACCERR
{
    NSMutableArray *array = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i=0; i<10000; i++) {
            [array addObject:@"ddsad"];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i=0; i<10000; i++) {
            [array addObject:@"ddasd"];
        }
    });
}

@end
