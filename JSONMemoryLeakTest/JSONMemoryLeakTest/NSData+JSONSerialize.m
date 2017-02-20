//
//  NSData+JSONSerialize.m
//  JSONMemoryLeakTest
//
//  Created by fragno on 16/12/21.
//  Copyright © 2016年 alipay. All rights reserved.
//

#import "NSData+JSONSerialize.h"

@implementation NSData (JSONSerialize)

- (id)JSONValue {
    
    id result = nil;
    @try
    {
        NSError* error = nil;
        result = [NSJSONSerialization JSONObjectWithData:self options:0 error:&error];
        if (result == nil)
            NSLog(@"-JSONValue failed. Error is: %@", error);
    }
    @catch (NSException *exception)
    {
        NSLog(@"-JSONValue failed. Exception: %@", exception);
    }
    return result;
    
}

@end
