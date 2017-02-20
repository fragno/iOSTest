//
//  ViewController.m
//  JSONMemoryLeakTest
//
//  Created by fragno on 16/12/21.
//  Copyright © 2016年 alipay. All rights reserved.
//

#import "ViewController.h"
#import "NSData+JSONSerialize.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *testStr = @"{'dsadsa':'dsadsad'}";
    NSData *testStrData = [testStr dataUsingEncoding:NSUTF8StringEncoding];
    for (int i=0; i<1000; i++) {
        [self generateData:testStrData];
    }
}


- (NSData *)generateData:(NSData *)testdata {
    NSData *data = [testdata performSelector:@selector(JSONValue)];
    return data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
