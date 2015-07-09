//
//  MenuItem.h
//  testObjcRetainCrash
//
//  Created by chrisfnxu on 6/29/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (weak, nonatomic) id target;
@property (unsafe_unretained, nonatomic) SEL action;
@property (strong, nonatomic) id object;
- (instancetype)initWIthTarget:(id)target action:(SEL)action withObject:(id)object;
- (void)performAction;

@end
