//
//  ViewController.m
//  TestRenderInContextCrash
//
//  Created by fragno on 16/6/23.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AliStock.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i=0; i<6; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0,0,1,1);
        [self.view addSubview:view];
    }
    
    [[[[UIApplication sharedApplication] delegate] window] asSnapshotImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
