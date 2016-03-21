//
//  DataManager.m
//  InnerAppRuler
//
//  Created by fragno on 16/3/14.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import "DataManager.h"

static NSString *const kAFWAIRMetaDataKey = @"__kAFWAIRMetaDataKey__";

#define AIRMetaDataKeyWithName(name) [NSString stringWithFormat:@"%@_%@", kAFWAIRMetaDataKey, name]

@implementation DataManager

+ (instancetype)instanceManager
{
    static DataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] init];
    });
    
    return instance;
}

- (NSString *)readJsonDataFromFile:(NSString *)filename
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSLog(AIRMetaDataKeyWithName(@"dsad"));
    
    return @"";
}

@end
