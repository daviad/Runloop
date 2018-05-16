//
//  TViewController.m
//  RunLoopTest
//
//  Created by 丁秀伟 on 2018/5/17.
//  Copyright © 2018年 丁秀伟. All rights reserved.
//

#import "TViewController.h"

@interface TViewController ()
{
     BOOL end;
}
@end

@implementation TViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSLog(@"start new thread …");
    
    [NSThread detachNewThreadSelector:@selector(runOnNewThread1) toTarget:self withObject:nil];
    
    while (!end) {
        
        NSLog(@"runloop…");
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        NSLog(@"runloop end.");
        
    }
    
    NSLog(@"ok.");
    
}

-(void)runOnNewThread{
    
    NSLog(@"run for new thread …");
    
    sleep(2);
    
    end=YES;
    
    NSLog(@"end.");
    
}

-(void)runOnNewThread1{
    NSLog(@"run for new thread …");
    
    sleep(2);
    
    [self performSelectorOnMainThread:@selector(setEnd) withObject:nil waitUntilDone:NO];
//    这里要说一下，造成while循环后语句延缓执行的原因是，runloop未被唤醒。因为，改变变量的值，runloop对象根本不知道。延缓的时长总是不定的，这是因为，有其他事件在某个时点唤醒了主线程，这才结束了while循环。那么，向主线程发送消息，将唤醒runloop，因此问题就解决了。
    NSLog(@"end.");
    
}

-(void)setEnd{
    
    end=YES;
    
}
@end
