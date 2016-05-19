//
//  ViewController.m
//  ImageResizeTest
//
//  Created by fragno on 16/3/28.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *leftimage = [UIImage imageNamed:@"left_text_border"];
    UIImage *rightimage = [UIImage imageNamed:@"right_text_border"];
    UIImage *middleimage = [UIImage imageNamed:@"middle_text_border"];
    leftimage = [leftimage resizableImageWithCapInsets:UIEdgeInsetsMake(25, leftimage.size.width - 5, 25, 0)];
    rightimage = [rightimage resizableImageWithCapInsets:UIEdgeInsetsMake(25, 0, 25, rightimage.size.width - 5)];
    middleimage = [middleimage resizableImageWithCapInsets:UIEdgeInsetsMake(middleimage.size.height/2 - 1, 0, middleimage.size.height/2, 0)];
    
    UIImageView *leftimageView = [[UIImageView alloc] initWithImage:leftimage];
    [self.view addSubview:leftimageView];
    
    leftimageView.frame = CGRectMake(50, 50, 90 - middleimage.size.width, 100);
    
    UIImageView *middleimageView = [[UIImageView alloc] initWithImage:middleimage];
    [self.view addSubview:middleimageView];
    middleimageView.frame = CGRectMake(140 - middleimage.size.width + 5, 45, middleimage.size.width, 110);
    
    UIImageView *rightimageView = [[UIImageView alloc] initWithImage:rightimage];
    [self.view addSubview:rightimageView];
    
    rightimageView.frame = CGRectMake(150, 50, 90 - middleimage.size.width, 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
