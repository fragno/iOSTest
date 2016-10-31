//
//  ViewController.m
//  CategoryInheritanceTest
//
//  Created by fragno on 16/10/31.
//  Copyright © 2016年 alipay. All rights reserved.
//

#import "ViewController.h"
#import "BaseClass+Category.h"
#import "DerivativeClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BaseClass *bs = [[BaseClass alloc] init];
    NSLog(@"lohlohloh");
    [bs testLog];
    [bs categoryLog];
    
    DerivativeClass *dc = [[DerivativeClass alloc] init];
    [dc testLog];
    [dc categoryLog];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
