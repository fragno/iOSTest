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

    [self testCrash];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - testCrash

- (void)testCrash_divide_by_zero
{
    unsigned int divider = 0;
    unsigned int dividend = 10;
    
    NSLog(@"%d", dividend/divider);
}


- (void)testCrash_unrecognized_selector_sent
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


- (void)testCrash
{
    self.testArray = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    NSLog(@"1: %p", self.testArray);
    
    TestBlock testBlock = ^{
        [self.testArray addObject:@"4"];
        NSLog(@"3: %p", self.testArray);
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), testBlock);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        for (int i=0; i<1000; i++) {
            self.testArray = [NSMutableArray arrayWithObjects:@"3", @"4", nil];
            NSLog(@"2: %p", self.testArray);
        }
    });
    
}

@end
