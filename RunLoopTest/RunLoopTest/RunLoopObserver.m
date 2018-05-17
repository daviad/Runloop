//
//  RunLoopObserver.m
//  RunLoopTest
//
//  Created by  dingxiuwei on 2018/5/17.
//  Copyright © 2018年 丁秀伟. All rights reserved.
//

#import "RunLoopObserver.h"

@implementation RunLoopObserver
+ (void)addRunLoopObserver:(NSRunLoop*)runLoop {
    CFRunLoopObserverRef  observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"即将进入runloop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理timer");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理input Sources");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将睡眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"从睡眠中唤醒，处理完唤醒源之前");
                break;
            case kCFRunLoopExit:
                NSLog(@"退出");
                break;
            default:
                break;
        }
    });
//    // 没有任何事件源则不会进入runloop
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(doFireTimer) userInfo:nil repeats:NO];
    CFRunLoopAddObserver([runLoop getCFRunLoop], observer, kCFRunLoopDefaultMode);
//    [[NSRunLoop currentRunLoop] run];
}
@end
