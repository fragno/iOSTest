//
//  ViewController.m
//  AlertViewTest
//
//  Created by fragno on 15/10/8.
//  Copyright © 2015年 fragno. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"alert test"
                                                     message:@"alert test message"
                                                    delegate:self
                                           cancelButtonTitle:@"cancel"
                                           otherButtonTitles:@"confirm", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
