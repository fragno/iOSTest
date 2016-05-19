//
//  ViewController.m
//  AnimationTest
//
//  Created by fragno on 16/3/29.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIButton *screenshotEditButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _screenshotEditButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _screenshotEditButton.layer.cornerRadius = 25;
    _screenshotEditButton.layer.borderWidth = 1.0;
    _screenshotEditButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_screenshotEditButton setImage:[UIImage imageNamed:@"cartoon"] forState:UIControlStateNormal];
    [self.view addSubview:_screenshotEditButton];
    _screenshotEditButton.center = self.view.center;
    
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    [path1 addArcWithCenter:CGPointMake(_screenshotEditButton.frame.size.width/2.0,
                                       _screenshotEditButton.frame.size.height/2.0)
                    radius:35
                startAngle:0
                  endAngle:2 * M_PI
                 clockwise:YES];
    
    CAShapeLayer * circleLayer1 = [[CAShapeLayer alloc] init];
    circleLayer1.strokeColor = [UIColor grayColor].CGColor;
    circleLayer1.fillColor = [UIColor clearColor].CGColor;
    circleLayer1.lineWidth = 15.0;
    circleLayer1.path = path1.CGPath;
    [_screenshotEditButton.layer addSublayer:circleLayer1];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:CGPointMake(_screenshotEditButton.frame.size.width/2.0,
                                       _screenshotEditButton.frame.size.height/2.0)
                    radius:35
                startAngle:-M_PI_2
                  endAngle:3 * M_PI_2
                 clockwise:YES];
    
    CAShapeLayer * circleLayer = [[CAShapeLayer alloc] init];
    circleLayer.strokeColor = [UIColor blueColor].CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.lineWidth = 5.0;
    circleLayer.path = path.CGPath;
    [_screenshotEditButton.layer addSublayer:circleLayer];
    
    circleLayer.strokeStart = 0;
    circleLayer.strokeEnd = 1;
    
    // Then apply the animation.
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    // Change the model layer's property first.
    drawAnimation.duration = 3.0;
    drawAnimation.repeatCount = 1;
    drawAnimation.removedOnCompletion = YES;
    drawAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    drawAnimation.toValue   = [NSNumber numberWithFloat:0.0];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    drawAnimation.delegate = self;
    [circleLayer addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [_screenshotEditButton removeFromSuperview];
    }
}

@end
