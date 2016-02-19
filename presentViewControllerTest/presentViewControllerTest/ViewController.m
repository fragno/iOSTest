//
//  ViewController.m
//  presentViewControllerTest
//
//  Created by fragno on 16/1/20.
//  Copyright © 2016年 fragno. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)dealloc
{
    NSLog(@"ViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"ViewController viewDidLoad");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"ViewController viewDidDisappear");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"ViewController viewWillAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewHierarchyTest
{
     UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 200, 300)];
     view3.backgroundColor = [UIColor yellowColor];
     view3.layer.zPosition = 100;
     
     UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 200, 300)];
     view4.backgroundColor = [UIColor blueColor];
     
     UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
     view1.backgroundColor = [UIColor redColor];
     [self.view addSubview:view1];
     
     [view1 addSubview:view3];
     [view1 addSubview:view4];
     
     UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 200, 300)];
     view2.backgroundColor = [UIColor greenColor];
     [self.view addSubview:view2];
     
     [self.view bringSubviewToFront:view1];
}

@end
