//
//  ModelViewController.m
//  presentViewControllerTest
//
//  Created by fragno on 16/1/20.
//  Copyright © 2016年 fragno. All rights reserved.
//

#import "ModelViewController.h"

@interface ModelViewController ()
- (IBAction)btnClicked:(id)sender;

@end

@implementation ModelViewController

-(void)dealloc
{
    NSLog(@"ModelViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"ModelViewController viewDidLoad");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"ModelViewController viewDidDisappear");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"ModelViewController viewWillAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
