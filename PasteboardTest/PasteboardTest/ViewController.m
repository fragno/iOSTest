//
//  ViewController.m
//  PasteboardTest
//
//  Created by fragno on 15/8/27.
//  Copyright (c) 2015年 fragno. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *uiLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showPasteboard)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showPasteboard
{
    self.uiLabel.text = [UIPasteboard generalPasteboard].string;
    NSLog(@"pasteboard types: %@", [UIPasteboard generalPasteboard].pasteboardTypes);
    [[UIPasteboard generalPasteboard] setString:@""];
}

@end
