//
//  Person.h
//  test
//
//  Created by chrisfnxu on 6/10/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import JavaScriptCore;

@class Person;

@protocol PersonJSExports <JSExport>

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property NSInteger ageToday;

- (NSString *)getFullName;

+ (instancetype)createWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end


@interface Person : NSObject <PersonJSExports>

@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;
@property NSInteger ageToday;

@end

