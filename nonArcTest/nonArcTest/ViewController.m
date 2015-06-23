//
//  ViewController.m
//  nonArcTest
//
//  Created by chrisfnxu on 6/23/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "ViewController.h"
#import "TestSingleton.h"


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
