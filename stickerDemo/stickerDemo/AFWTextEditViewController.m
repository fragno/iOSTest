//
//  AFWTextEditViewController.m
//  AFWealth
//
//  Created by fragno on 16/2/29.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "AFWTextEditViewController.h"
#import "AFWStickerLabel.h"
#import "AFWStickerView.h"

static NSString * const placeHolderString = @"轻触编辑文本";

@interface AFWTextEditViewController ()  <UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) UITextView *editView;
@property (nonatomic, strong) UILabel *label;

//@property (nonatomic, strong) AFWStickerLabel *sticker;
@property (nonatomic, strong) AFWStickerView *sticker;

@end

@implementation AFWTextEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _editView = [[UITextView alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    _editView.layer.borderWidth = 2.0f;
    _editView.layer.borderColor = [UIColor redColor].CGColor;
    _editView.delegate = self;
    _editView.textAlignment = NSTextAlignmentCenter;
    _editView.font = [UIFont systemFontOfSize:20];
    _editView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_editView];
    _editView.hidden = YES;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    _label.backgroundColor = [UIColor greenColor];
    _label.numberOfLines=0;
    _label.font = [UIFont systemFontOfSize:20];
    _label.lineBreakMode=NSLineBreakByWordWrapping;
//    _label.minimumScaleFactor=0.1;
    _label.textAlignment=NSTextAlignmentCenter;
    _label.baselineAdjustment = UIBaselineAdjustmentNone;
    
    
    self.sticker = [[AFWStickerView alloc] initWithContentView:_label];
    /*
     _sticker = [[AFWStickerLabel alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
     _sticker.backgroundColor = [UIColor greenColor];
     _sticker.numberOfLines=0;
     _sticker.lineBreakMode=NSLineBreakByWordWrapping;
     _sticker.adjustsFontSizeToFitWidth=YES;
     _sticker.minimumScaleFactor=0.1;
     _sticker.textAlignment=NSTextAlignmentCenter;
     _sticker.baselineAdjustment = UIBaselineAdjustmentNone;
     _sticker.font = [UIFont systemFontOfSize:20];
     _sticker.text = placeHolderString;
     */
    _sticker.preventsPositionOutsideSuperview = YES;
    _sticker.translucencySticker = NO;
    [self.view addSubview:_sticker];
    [_sticker layoutIfNeeded];
    
    // 点击手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(stickerTapped:)];
    [_sticker addGestureRecognizer:tapGestureRecognizer];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:tap2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    
}

#pragma mark - GestureRecognizer
- (void)stickerTapped:(UITapGestureRecognizer *)sender
{
    if (!self.sticker.isInStickerMode) {
        [self.sticker enterStickerMode];
        
    }else{
        self.editView.hidden = NO;
        [self.editView becomeFirstResponder];
        self.sticker.hidden = YES;
    }
}

- (void)backgroundTapped:(UITapGestureRecognizer *)sender
{
    if (self.sticker.isInStickerMode) {
        [self.sticker exitStickerMode];
    }
}


#pragma mark -  <UITextViewDelegate>
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // 按回车收起键盘
    if ([text isEqualToString:@"\n"]) {
        
        self.label.text = textView.text;
        CGRect rect = [textView.text boundingRectWithSize:CGSizeMake(200, 99999999)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{ NSFontAttributeName:self.label.font }
                                                  context:nil];
        
        self.label.bounds = rect;
        
        [textView resignFirstResponder];
        self.editView.hidden = YES;
        self.sticker.hidden = NO;
        return NO;
    }
    
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.markedTextRange != nil) {
        self.placeHolderLabel.alpha = 0;
        return;
    }
    
    if([placeHolderString length] > 0){
        
        if([textView.text length] <= 0 && self.placeHolderLabel.alpha != 1) {
            [UIView animateWithDuration:.1f animations:^{
                [self.placeHolderLabel setAlpha:1];
            }];
            
        }else if([textView.text length] > 0 && self.placeHolderLabel.alpha != 0){
            [UIView animateWithDuration:.1f animations:^{
                [self.placeHolderLabel setAlpha:0];
            }];
        }
    }
}

@end
