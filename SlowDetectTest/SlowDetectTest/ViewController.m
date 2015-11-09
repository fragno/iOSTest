//
//  ViewController.m
//  SlowDetectTest
//
//  Created by fragno on 15/9/21.
//  Copyright © 2015年 fragno. All rights reserved.
//

#import "ViewController.h"
#import "cpu_usage.mm"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
//    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(doFireTimer:) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    // 卡顿可能的原因
//    [self cpuOverload];
    
    // runloop处理耗时事件，比如下载图片
    [self timeCostEvent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - 卡顿情况构造
/**
 *  cpu负载率高
 */
- (void)cpuOverload
{
    // 检测cpu 使用情况
    [self performSelectorInBackground:@selector(backgroundThread) withObject:nil];
    
    long long loop = 5000000000;
    while (loop) {
        loop--;
    }
}


- (void)timeCostEvent
{
    NSURL *url = [[NSURL alloc] initWithString:@"https://zb.oschina.net/action/reward/downloadAttachment?ident=ddf364b2dc5689cdd6ba0084de212af9c29f848a"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    NSURLResponse *resp = [[NSURLResponse alloc] init];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&resp error:&error];
}


#pragma mark -
#pragma mark - private
- (void)backgroundThread
{
    if (![NSThread isMainThread]) {
        //此种方式创建的timer没有添加至runloop中
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.1f target:self selector:@selector(doFireBackgroundTimer:) userInfo:nil repeats:YES];
        
        //将定时器添加到runloop中
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"多线程结束");
    }
}

- (void)doFireBackgroundTimer:(NSTimer *)timer
{
    NSLog(@"cpu usage: %f", cpu_usage());
}

- (void)doFireTimer:(NSTimer *)timer
{
    static NSTimeInterval lastTimeInterval = 0;
    NSLog(@"timeInterval: %lf", [[timer fireDate] timeIntervalSinceReferenceDate] - lastTimeInterval);
    lastTimeInterval = [[timer fireDate] timeIntervalSinceReferenceDate];
}

@end
