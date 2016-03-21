//
//  ViewController.m
//  PaintDemo
//
//  Created by fragno on 16/3/4.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "ViewController.h"
#import "PaintView.h"
#import "ColorPickerView.h"

@interface ViewController ()<ColorPickerViewProtocol>

@property (nonatomic, strong) PaintView *paintView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PaintSetting *setting = [PaintSetting paintSetting];
    self.paintView= [[PaintView alloc] initWithPaintSetting:setting];
    self.paintView.backgroundColor = [UIColor whiteColor];
    self.paintView.frame = self.view.frame;
    [self.view addSubview:self.paintView];
    
    UIButton *undoButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 600, 100, 50)];
    undoButton.backgroundColor = [UIColor greenColor];
    [undoButton setTitle:@"undo" forState:UIControlStateNormal];
    [undoButton addTarget:self action:@selector(undo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:undoButton];
    
    UIButton *redoButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 600, 100, 50)];
    redoButton.backgroundColor = [UIColor greenColor];
    [redoButton setTitle:@"redo" forState:UIControlStateNormal];
    [redoButton addTarget:self action:@selector(redo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:redoButton];
    
    UIButton *cleanButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 600, 100, 50)];
    cleanButton.backgroundColor = [UIColor greenColor];
    [cleanButton setTitle:@"clean" forState:UIControlStateNormal];
    [cleanButton addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cleanButton];
    
    ColorPickerView *view = [[ColorPickerView alloc] initWithFrame:CGRectMake(300.0f, 50.0f, 20.0f, 400.0f)];
    view.delegate = self;
    view.colors = [NSArray arrayWithObjects:[UIColor yellowColor], [UIColor greenColor], [UIColor redColor], nil];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ColorPickerViewProtocol
- (void)colorPicked:(UIColor *)color
{
    self.paintView.paintSetting.lineColor = color;
}

#pragma mark - Action
- (void)undo:(id)sender
{
    [self.paintView undo];
}

- (void)redo:(id)sender
{
    [self.paintView redo];
}

- (void)clean:(id)sender
{
    [self.paintView clean];
}

@end
