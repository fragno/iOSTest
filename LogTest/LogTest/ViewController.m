//
//  ViewController.m
//  LogTest
//
//  Created by fragno on 15/11/5.
//  Copyright © 2015年 fragno. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LogName.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view1.backgroundColor = [UIColor redColor];
    view1.center = self.view.center;
    view1.logName = @"view1";
    [self.view addSubview:view1];
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 40, 100, 40)];
    btn1.backgroundColor = [UIColor greenColor];
    btn1.logName = @"btn1";
    btn1.logAction = @"clicked";
    [view1 addSubview:btn1];
    [btn1 addTarget:self action:@selector(btn1Clicked:) forControlEvents:UIControlEventTouchDown];
    
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    btn2.backgroundColor = [UIColor blueColor];
    btn2.frame = CGRectMake(btn1.frame.origin.x, btn1.frame.origin.y + 50,
                            btn1.frame.size.width, btn1.frame.size.height);
    btn2.logName = @"btn2";
    btn2.logAction = @"submitted";
    [view1 addSubview:btn2];
    [btn2 addTarget:self action:@selector(btn2Clicked:) forControlEvents:UIControlEventTouchDown];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)btn1Clicked:(id)sender
{
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.logName = @"vc1";
    vc1.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:vc1 animated:YES];
}

- (void)btn2Clicked:(id)sender
{
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.logName = @"vc2";
    vc2.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:vc2 animated:YES];
}

@end
