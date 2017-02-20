//
//  ViewController.m
//  CoreGraphicTest
//
//  Created by fragno on 16/11/9.
//  Copyright © 2016年 alipay. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CustomView *customView = [[CustomView alloc] initWithFrame:self.view.frame];
    customView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
