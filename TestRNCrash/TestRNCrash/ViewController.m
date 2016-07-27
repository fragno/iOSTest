//
//  ViewController.m
//  TestRNCrash
//
//  Created by fragno on 16/5/19.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "ViewController.h"
#import <AFWReactNative/RCTRootView.h>

@interface ViewController ()

@property (nonatomic, strong) NSMutableSet *tmpSet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tmpSet = [NSMutableSet set];
    
    NSLock *lock = [[NSLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [lock lock];
            [_tmpSet containsObject:@"dasd"];
            NSLog(@"containsObject");
            [lock unlock];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        while (1) {
                [lock lock];
                [_tmpSet addObject:@"dasd"];
            NSLog(@"addObject");
                [lock unlock];
            }
    });
    
    
    
//    NSURL *jsCodeLocation = [NSURL URLWithString:@"http:/localhost:8081/index.ios.bundle?platform=ios&dev=true"];
//    
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"AwesomeProject" initialProperties:nil launchOptions:nil];
//    
//    [self.view addSubview:rootView];
//    rootView.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
