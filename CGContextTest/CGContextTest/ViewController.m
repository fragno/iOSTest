//
//  ViewController.m
//  CGContextTest
//
//  Created by fragno on 16/10/20.
//  Copyright © 2016年 alipay. All rights reserved.
//

#import "ViewController.h"
#import "DemoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DemoView *view = [[DemoView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
