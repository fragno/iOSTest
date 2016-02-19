//
//  ViewController.m
//  LocalAuthenticationDemo
//
//  Created by fragno on 16/1/8.
//  Copyright © 2016年 fragno. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Authenticate using your finger";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    NSLog(@"User is authenticated successfully");
                                } else {
                                    switch (error.code) {
                                        case LAErrorAuthenticationFailed:
                                            NSLog(@"Authentication Failed");
                                            break;
                                            
                                        case LAErrorUserCancel:
                                            NSLog(@"User pressed Cancel button");
                                            break;
                                            
                                        case LAErrorUserFallback:
                                            NSLog(@"User pressed \"Enter Password\"");
                                            break;
                                            
                                        default:
                                            NSLog(@"Touch ID is not configured");
                                            break;
                                    }
                                    NSLog(@"Authentication Fails");
                                }
                            }];
    } else {
        NSLog(@"Can not evaluate Touch ID");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
