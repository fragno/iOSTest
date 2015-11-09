//
//  ViewController.m
//  PopupTestViewController
//
//  Created by fragno on 15/11/4.
//  Copyright © 2015年 fragno. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *inputField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    _inputField.backgroundColor = [UIColor redColor];
    _inputField.layer.cornerRadius = 25;
    _inputField.textAlignment = NSTextAlignmentCenter;
    _inputField.center = self.view.center;
    _inputField.delegate = self;
    [self.view addSubview:_inputField];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    [self.inputField convertRect:self.inputField.frame fromView:view];
    [view addSubview:self.inputField];
    return YES;
}

@end
