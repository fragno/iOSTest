//
//  ViewController.m
//  MessageTest
//
//  Created by fragno on 16/3/23.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController () <MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) MFMessageComposeViewController *vc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self sendMessagebyiAn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendMessagebyiAn
{
    if([MFMessageComposeViewController canSendText]){
        NSString *phoneNumber = @"13888888888";
        if (phoneNumber && phoneNumber.length > 0) {
            self.vc = [[MFMessageComposeViewController alloc] init];
            self.vc.view.backgroundColor = [UIColor whiteColor];
            self.vc.recipients = @[phoneNumber];
            self.vc.messageComposeDelegate = self;
            self.vc.body = @"测试消息";
            [self presentViewController:self.vc animated:YES completion:nil];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    }
}


// 发送短信的委托方法
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result) {
        case MessageComposeResultSent:
            // 短信发送成功
            break;
            
        case MessageComposeResultFailed:
            // 短信发送失败
            break;
            
        case MessageComposeResultCancelled:
            // 短信被用户取消传送
            break;
            
        default:
            break;
    }
}

@end
