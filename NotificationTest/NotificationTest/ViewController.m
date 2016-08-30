//
//  ViewController.m
//  NotificationTest
//
//  Created by fragno on 16/8/29.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSNotificationQueue *notiQueue = [[NSNotificationQueue alloc] initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiProcess:) name:@"test" object:nil];
    
    // CHANGE postingStyle to test
    while (1) {
        NSNotification *noti = [[NSNotification alloc] initWithName:@"test" object:nil userInfo:nil];
        [notiQueue enqueueNotification:noti postingStyle:NSPostASAP coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Notification
- (void)notiProcess:(NSNotification *)noti
{
    NSLog(@"%@", noti);
}

@end
