//
//  TestThread.m
//  RunLoopTest
//
//  Created by 丁秀伟 on 2018/5/16.
//  Copyright © 2018年 丁秀伟. All rights reserved.
//

#import "TestThread.h"

@implementation TestThread
- (void)dealloc {
    NSLog(@"TestThread dealloc");
}
- (void)directCall {
    NSLog(@"directCall in thread name:%@",[NSThread currentThread].name);
}
@end
