//
//  TestSingleton.h
//  nonArcTest
//
//  Created by chrisfnxu on 6/23/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestSingleton : NSObject

@property (nonatomic, retain) NSString *str;

+ (instancetype)instance;

@end
