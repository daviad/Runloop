//
//  Test2.m
//  RunLoopTest
//
//  Created by  dingxiuwei on 2018/5/17.
//  Copyright © 2018年 丁秀伟. All rights reserved.
//

#import "Test2.h"
#import "TestThread.h"
#import "RunLoopObserver.h"
@implementation Test2

- (void)test {
    TestThread *thread = [[TestThread alloc] initWithTarget:self selector:@selector(threadMethod) object:nil];
    [thread start];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSelector:@selector(performTest) onThread:thread withObject:nil waitUntilDone:NO];
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSelector:@selector(performTest2) onThread:thread withObject:nil waitUntilDone:NO];
    });
}

- (void)threadMethod {
    NSLog(@"thead mothed1");
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [RunLoopObserver addRunLoopObserver:runLoop];
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    [runLoop run];
    [runLoop runUntilDate:[NSDate distantFuture]];
    NSLog(@"thead mothed2");
}

- (void)performTest {
    NSLog(@"performTest");
//    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//    [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
}

- (void)performTest2 {
    NSLog(@"performTest2");
}
@end
