//
//  ViewController.m
//  WebViewTest
//
//  Created by fragno on 15/8/29.
//  Copyright (c) 2015年 fragno. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *uiwebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://dev.xuebang.avosapps.com/m/index.html#/teacher"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.uiwebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
