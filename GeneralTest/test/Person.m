//
//  Person.m
//  test
//
//  Created by chrisfnxu on 6/10/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)getFullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

+ (instancetype)createWithFirstName:(NSString *)firstName lastName:(NSString *)lastName
{
    Person *person = [[Person alloc] init];
    person.firstName = firstName;
    person.lastName = lastName;
    
    return person;
}

@end