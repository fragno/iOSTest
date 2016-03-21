//
//  PaintView.m
//  PaintDemo
//
//  Created by fragno on 16/3/4.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "PaintView.h"

@implementation PaintSetting

+ (instancetype)paintSetting
{
    PaintSetting *setting = [[PaintSetting alloc] init];
    setting.lineWidth = 4;
    setting.lineColor = [UIColor redColor];
    setting.linesCapacity = 20;
    return setting;
}

@end

@interface PaintView()


@property(nonatomic, strong) UIBezierPath *bezier;           //贝塞尔曲线
@property(nonatomic, strong) NSMutableArray *cancelledLines;   //Undo线条
@property (nonatomic, strong) NSMutableArray *allLines;      //所有线条

@end

@implementation PaintView

- (instancetype)initWithPaintSetting:(PaintSetting *)paintSetting
{
    if (self = [super init]) {
        self.paintSetting = paintSetting;
        self.cancelledLines = [NSMutableArray arrayWithCapacity:self.paintSetting.linesCapacity];
        self.allLines = [NSMutableArray arrayWithCapacity:self.paintSetting.linesCapacity];
    }
    
    return self;
}

- (void)undo
{
    if (self.allLines.count > 0) {
        NSUInteger index = self.allLines.count - 1;
        [self.cancelledLines addObject:self.allLines[index]];
        [self.allLines removeObjectAtIndex:index];
        [self setNeedsDisplay];
    }
}


-(void)redo
{
    if (self.cancelledLines.count > 0) {
        NSUInteger index = self.cancelledLines.count - 1;
        [self.allLines addObject:self.cancelledLines[index]];
        [self.cancelledLines removeObjectAtIndex:index];
        [self setNeedsDisplay];
    }
}

- (void)clean
{
    [self.allLines removeAllObjects];
    [self.cancelledLines removeAllObjects];
    [self setNeedsDisplay];
}


#pragma mark - Override

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.bezier = [UIBezierPath bezierPath];
    self.bezier.lineJoinStyle = kCGLineJoinRound;
    
    //获取触摸的点
    UITouch *myTouche = [touches anyObject];
    CGPoint point = [myTouche locationInView:self];
    
    //把刚触摸的点设置为bezier的起点
    [self.bezier moveToPoint:point];
    
    //把每条线存入字典中
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [tempDic setObject:self.paintSetting.lineColor forKey:@"lineColor"];
    [tempDic setObject:[NSNumber numberWithFloat:self.paintSetting.lineWidth] forKey:@"lineWidth"];
    [tempDic setObject:self.bezier forKey:@"line"];
    
    [self.allLines addObject:tempDic];
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *myTouche = [touches anyObject];
    CGPoint point = [myTouche locationInView:self];
    
    // 图画
    [self.bezier addLineToPoint:point];
    
    [self setNeedsDisplay];
    
}


- (void)drawRect:(CGRect)rect
{
    //对之前的线的一个重绘过程
    for (int i = 0; i < self.allLines.count; i ++) {
        NSDictionary *tempDic = self.allLines[i];
        UIColor *color = tempDic[@"lineColor"];
        CGFloat width = [tempDic[@"lineWidth"] floatValue];
        UIBezierPath *path = tempDic[@"line"];
        
        [color setStroke];
        [path setLineWidth:width];
        [path stroke];
    }
}


@end
