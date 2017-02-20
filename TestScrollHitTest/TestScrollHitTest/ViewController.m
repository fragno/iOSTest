//
//  ViewController.m
//  TestScrollHitTest
//
//  Created by fragno on 16/11/16.
//  Copyright © 2016年 alipay. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 300, 50)];
    scrollView.contentSize = CGSizeMake(400, 50);
    scrollView.backgroundColor = [UIColor greenColor];
    BaseView *view = [[BaseView alloc] initWithFrame:CGRectMake(0, 10, 400, 30)];
    [view addGestureRecognizer:pan];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor redColor];
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 400, 30)];
    [view addSubview:slider];
    [scrollView addSubview:view];
    [self.view addSubview:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pan:(UIPanGestureRecognizer *)ges {
    
}

@end
