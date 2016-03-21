//
//  DataManager.h
//  InnerAppRuler
//
//  Created by fragno on 16/3/14.
//  Copyright © 2016年 rookienerd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (instancetype)instanceManager;

- (NSString *)readJsonDataFromFile:(NSString *)filename;

@end
