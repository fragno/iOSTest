

#import <Foundation/Foundation.h>

@interface CloudRWLock : NSObject

- (void)lockRead;
- (BOOL)tryLockRead;
- (void)unLockRead;

- (void)lockWrite;
- (BOOL)tryLockWrite;
- (void)unLockWrite;

@end
