//
//  DerivativeClass.m
//  CategoryInheritanceTest
//
//  Created by fragno on 16/10/31.
//  Copyright © 2016年 alipay. All rights reserved.
//

#import "DerivativeClass.h"
#import "BaseClass+Category.h"

@implementation DerivativeClass

- (void)testLog {
    NSLog(@"derivative log");
}

- (void)categoryLog {
    NSLog(@"derivative category log");
}

@end
