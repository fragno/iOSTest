//
//  main.m
//  NanoFreeTest
//
//  Created by fragno on 16/12/18.
//  Copyright © 2016年 alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import <malloc/malloc.h>
#import <mach/mach.h>
#import <mach/vm_map.h>

int main(int argc, char * argv[]) {
    // 以下代码是将vm_map可能用到的内存消耗到nano_zone附近, 也就是地址0x17xxxxxx附近
//    vm_address_t vm_addr;
//    mach_vm_size_t allocation_size = 1032192;
//    mach_vm_offset_t allocation_mask = 0;
//    int alloc_flags = VM_FLAGS_ANYWHERE | VM_MAKE_TAG(3);
//    
//    kern_return_t kr;
//    for (NSInteger i=0; i<2800; i++) {
//        kr = vm_map(mach_task_self(), &vm_addr, allocation_size,
//                    allocation_mask, alloc_flags, MEMORY_OBJECT_NULL, 0, FALSE,
//                    VM_PROT_DEFAULT, VM_PROT_ALL, VM_INHERIT_DEFAULT);
//        if (kr) {
//            NSLog(@"Error %d", kr);
//        } else {
//            printf("vm_map addr: 0x%lx\n", (unsigned long)vm_addr);
//            // 分配0x17xxxxxxx附近的时候不用再分配内存, 跳出循环触发bug, 这里是在0x172xxxxxx跳出更容易触发crash
//            if ((unsigned long)vm_addr>>28 == 0x17 && (unsigned long)vm_addr>>24 == 0x172) {
//                break;
//            }
//        }
//    }
//    
    
    // 以下代码是为了触发malloc的bug
    @autoreleasepool {
        for (NSInteger i=0; i<10000; i++) {
            int size_k = 1024 * 6;
            char* buffer = (char*)malloc(size_k);
            memset(buffer, i, size_k);
            NSData* data = [NSData dataWithBytes:buffer length:size_k];
            
            @try {
                NSData* newData = [NSKeyedArchiver archivedDataWithRootObject:data];
                NSLog(@"12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890");
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
        }
    }
    
    return 0;
}
