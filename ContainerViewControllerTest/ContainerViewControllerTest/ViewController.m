//
//  ViewController.m
//  ContainerViewControllerTest
//
//  Created by fragno on 15/11/12.
//  Copyright © 2015年 fragno. All rights reserved.
//

#import "ViewController.h"
#import "RedViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    RedViewController *redVC = [[RedViewController alloc] initWithView:redView];
    [redVC present];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
