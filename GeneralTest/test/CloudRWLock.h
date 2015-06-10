//
//  CloudRWLock.h
//  WeiyunModel
//
//  Created by Rico on 13-7-17.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CloudRWLock : NSObject

- (void)lockRead;
- (BOOL)tryLockRead;
- (void)unLockRead;

- (void)lockWrite;
- (BOOL)tryLockWrite;
- (void)unLockWrite;

@end
