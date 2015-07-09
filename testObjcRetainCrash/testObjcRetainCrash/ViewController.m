//
//  ViewController.m
//  testObjcRetainCrash
//
//  Created by chrisfnxu on 6/29/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "ViewController.h"
#import "MenuItem.h"
#import "Widget.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Widget *widget = [[Widget alloc] init];
    
    MenuItem *item = [[MenuItem alloc] initWIthTarget:widget action:@selector(someMethod:) withObject:nil];
    
    [item performAction];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
