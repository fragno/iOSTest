//
//  ViewController.m
//  XibTest
//
//  Created by fragno on 15/12/17.
//  Copyright © 2015年 fragno. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"]];
    
//    UINib *nib = [UINib nibWithNibName:@"TestView" bundle:bundle];
    
    UIViewController *vc = [[UIViewController alloc] initWithNibName:@"TestView" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
