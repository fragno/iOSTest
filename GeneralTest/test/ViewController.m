//
//  ViewController.m
//  test
//
//  Created by chrisfnxu on 3/30/15.
//  Copyright (c) 2015 chrisfnxu. All rights reserved.
//

#import "ViewController.h"
#import "CommonDefine.h"
#import "CloudLRUCache.h"
#import <sys/utsname.h>
#import "Person.h"
@import UIKit;
@import JavaScriptCore;

typedef long (^BlkSum)(int, int);

#pragma mark -
#pragma mark - testObj
@interface testObject : NSObject

@property(nonatomic, strong) NSString *string1;

@end

@implementation testObject

- (BOOL)isEqual:(id)object
{
    return YES;
}


- (NSUInteger)hash
{
    NSLog(@"hash value:%ld", (unsigned long)[_string1.description hash]);
    return [_string1.description hash];
}

@end


@interface ViewController ()

@property (nonatomic) const void *bytes;
@property (nonatomic) long length;
@property (nonatomic, strong) NSString *testString;

@property (nonatomic) IBOutlet UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 真机不打印最后一条log
    NSLog(@"viewDidload");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

//    [self test];
//    [self testUIAlertController];
    
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"viewDisDisappear");
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSLog(@"viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    NSLog(@"viewDidLayoutSubviews");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - test functions

// 测试CoreAnimation
- (void)testCoreAnimation
{
    [UIView animateWithDuration:1.0 animations:^{
        self.testView.layer.frame = [[UIScreen mainScreen] bounds];
    }];
}

// 测试block
- (void)testBlock
{
    BlkSum blk1 = ^ long (int a, int b) {
        return a + b;
    };
    NSLog(@"blk1 = %@", blk1);
    
    int base = 100;
    BlkSum blk2 = ^ long (int a, int b) {
        return base + a + b;
    };
    NSLog(@"blk2 = %@", blk2);
    
    BlkSum blk3 = [blk2 copy];
    NSLog(@"blk3 = %@", blk3);
}

/**
 *  测试javaScriptCore
 */
- (void)testJSC
{
    // OC call js
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:@"var num = 5 + 5"];
    [context evaluateScript:@"var names = ['Grace', 'Ada', 'Margaret']"];
    [context evaluateScript:@"var triple = function(value) {return value * 3}"];
    JSValue  *tripleNum = [context evaluateScript:@"triple(num)"];
    
    NSLog(@"js triple result: %d", [tripleNum toInt32]);
    
    JSValue *names = context[@"names"];
    JSValue *initialName = names[0];
    NSLog(@"The first name: %@", [initialName toString]);
    
    JSValue *tripleFunction = context[@"triple"];
    JSValue *result = [tripleFunction callWithArguments:@[@5]];
    NSLog(@"Five tripled: %d", [result toInt32]);
    
    context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"JS Error: %@", exception);
    };
    [context evaluateScript:@"function multiply(value1, value2) { return value1 * value2 "];
    
    context[@"simplifyString"] = ^(NSString *input) {
        NSMutableString *mutableString = [input mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformStripCombiningMarks, NO);
        return  mutableString;
    };
    
    NSLog(@"%@", [context evaluateScript:@"simplifyString('안녕하새요!')"]);
    
    
    // js call OC methods
    // export Person class
    context[@"Person"] = [Person class];
    
    // load Mustache.js
    NSString *mustacheFilePath = [[NSBundle mainBundle] pathForResource:@"mustache" ofType:@"js"];
    NSString *mustacheJSString = [NSString stringWithContentsOfFile:mustacheFilePath encoding:NSUTF8StringEncoding error:nil];
    [context evaluateScript:mustacheJSString];
    
    
    // 记住context就像window一样
    [context evaluateScript:@"\
     var loadPeopleFromJSON = function(jsonString) {\
         var data = JSON.parse(jsonString);\
         var people = [];\
         for (i=0; i<data.length; i++) {\
             var person = Person.createWithFirstNameLastName(data[i].first, data[i].last);\
             person.birthYear = data[i].year;\
             people.push(person);\
         }\
         \
         return people;\
     }\
     "];
    
    // get JSON string
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"person" ofType:@"json"];
    NSString *peopleJSON = [NSString stringWithContentsOfFile:jsonFilePath encoding:NSUTF8StringEncoding error:nil];
    
    // get load function
    JSValue *load = context[@"loadPeopleFromJSON"];
    
    // call with JSON and convert to an NSArray
    JSValue *loadResult = [load callWithArguments:@[peopleJSON]];
    NSArray *people = [loadResult toArray];
    
    // get rendering function and create template
    JSValue *mustacheRender = context[@"Mustache"][@"render"];
    NSString *template = @"{{getFullName}}, born {{birthYear}}";
    
    // loop
    for (Person *person in people) {
        NSLog(@"%@\n", [mustacheRender callWithArguments:@[template, person]]);
    }
}

/**
 *  测试UIAlertController，比UIAlertView好用
 */
- (void)testUIAlertController
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Info"
                                  message:@"You are using UIAlertController"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 *  测试KVC
 */
- (void)testKVC
{
    testObject *testObj = [[testObject alloc] init];
    
    [testObj setValue:@"1212" forKey:@"string1"];
    
    NSLog(@"kvc: %@", [testObj valueForKey:@"string1"]);
    NSLog(@"sting1: %@", testObj.string1);
}


/**
 *  测试获取DeviceName
 */
- (void)testDeviceName
{
    NSLog(@"deviceName :%@", [self deviceName]);
}


/**
 *  测试各种hash的性能
 */
- (void)testCache
{
    CloudLRUCache *cloudcache = [[CloudLRUCache alloc] initWithCapacity:50000];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:50000];
    NSCache *nscache = [[NSCache alloc] init];
    
    TICK;
    for (NSUInteger i = 0; i < 60000; i++) {
        [cloudcache cacheObject:[NSString stringWithFormat:@"%d", (unsigned int)i] forKey:[NSNumber numberWithUnsignedInteger:i]];
    }
    TOCK;
    
#ifdef DEBUG
    startTime = [NSDate date];
#endif
    for (NSUInteger i = 60000; i>0; i--) {
        [cloudcache objectForKey:[NSNumber numberWithUnsignedLong:i]];
    }
    TOCK;
    
#ifdef DEBUG
    startTime = [NSDate date];
#endif
    for (NSUInteger i = 0; i < 60000; i++) {
        [dict setObject:[NSString stringWithFormat:@"%d", (unsigned int)i] forKey:[NSNumber numberWithUnsignedInteger:i]];
    }
    TOCK;
    
#ifdef DEBUG
    startTime = [NSDate date];
#endif
    for (NSUInteger i = 0; i < 60000; i++) {
        [dict objectForKey:[NSNumber numberWithUnsignedInteger:i]];
    }
    TOCK;
    
#ifdef DEBUG
    startTime = [NSDate date];
#endif
    for (NSUInteger i = 0; i < 60000; i++) {
        [nscache setObject:[NSString stringWithFormat:@"%d", (unsigned int)i] forKey:[NSNumber numberWithUnsignedInteger:i]];
    }
    TOCK;
    
#ifdef DEBUG
    startTime = [NSDate date];
#endif
    for (NSUInteger i = 0; i < 60000; i++) {
        [nscache objectForKey:[NSNumber numberWithUnsignedInteger:i]];
    }
    TOCK;
}


/**
 *  测试isEqual函数的hash的关系
 */
- (void)testIsEqualAndHash
{
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *arry1 = [NSArray arrayWithObject:@"1"];
    NSArray *arry2 = [NSArray arrayWithObject:@"2"];
    NSArray *arry3 = [NSArray arrayWithObject:@"3"];
    NSArray *arry4 = [NSArray arrayWithObject:@"4"];
    NSArray *arry5 = [NSArray arrayWithObject:@"5"];
    
    
    NSMutableArray *mutarray = [NSMutableArray array];
    [mutarray addObject:arry1];
    [mutarray addObject:arry2];
    [mutarray addObject:arry3];
    
    NSString *lastStr = [mutarray lastObject];
    NSLog(@"lastStr: %@", lastStr);
    
    [mutarray insertObject:arry4 atIndex:0];
    NSLog(@"lastStr: %@", lastStr);
    
    [mutarray addObject:arry5];
    NSLog(@"lastStr: %@", lastStr);
    
    
    
    testObject *object1 = [[testObject alloc] init];
    object1.string1 = @"1";
    
    testObject *object2 = [[testObject alloc] init];
    object2.string1 = @"2";
    
    //    NSLog(@"object1 hash:%lu", [object1 hash]);
    //    NSLog(@"object2 hash:%lu", [object2 hash]);
    
    if ([object1 isEqual:object2]) {
        NSLog(@"object1 equals object2");
    }else{
        NSLog(@"object1 not equals object2");
    }
    
    NSArray *array = [NSArray arrayWithObjects:object1, nil];
    if ([array containsObject:object2]) {
        NSLog(@"array contains object2");
    }else{
        NSLog(@"array not contains object2");
    }
    
    NSSet *set = [NSSet setWithObjects:object1, nil];
    if ([set containsObject:object2]) {
        NSLog(@"set contains object2");
    }else{
        NSLog(@"set not contains object2");
    }

}

/**
 *  测试NSData和HexString之间转换
 */
- (void)testDataToHexString
{
//    NSString *str = @"12321543265432654364";
    NSString *str = @"232323232323";
    NSData *data = [self hexStringToBinary:str];
    NSString *str2 = [self hexString:data];
    
    NSLog(@"str: %@, data: %@, str2: %@", str, data, str2);
}


#pragma mark -
#pragma mark - private

- (NSString*)hexString:(NSData *)data
{
    static char tbl[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    
    if (nil == data.bytes) {
        return nil;
    }
    
    char* buf = (char*) data.bytes;
    
    NSUInteger resultLength = (data.length * 2) + 1;
    char resultBuffer[resultLength];
    
    for(int i = 0; i < data.length; ++i){
        resultBuffer[2*i] = tbl[(buf[i] & 0xf0) >> 4];
        resultBuffer[2*i+1] = tbl[buf[i] & 0x0f];
    }
    
    resultBuffer[resultLength - 1] = '\0';
    
    NSString * result = [NSString stringWithCString:resultBuffer encoding:NSASCIIStringEncoding];
    
    return result;
}


- (NSData*)hexStringToBinary:(NSString *)str
{
    NSMutableData* result = [[NSMutableData alloc]init];
    char c, s;
    char* src_str = (char*)[str UTF8String];
    
    while(*src_str)
    {
        s = 0x20 | (*src_str++);
        if(s >= '0' && s <= '9')
            c = s - '0';
        else if(s >= 'a' && s <= 'f')
            c = s - 'a' + 10;
        else
            break;
        
        c <<= 4;
        s = 0x20 | (*src_str++);
        if(s >= '0' && s <= '9')
            c += s - '0';
        else if(s >= 'a' && s <= 'f')
            c += s - 'a' + 10;
        else
            break;
        
        [result appendBytes:&c length:1];
    }
    
    return result;
}

- (NSString*)deviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

@end
