//
//  ViewController.m
//  RunLoopTest
//
//  Created by 丁秀伟 on 2018/5/16.
//  Copyright © 2018年 丁秀伟. All rights reserved.
//

#import "ViewController.h"
#import "TestThread.h"
#import "TViewController.h"
#import "Test2.h"

@interface ViewController ()
{
    TestThread *m_thread;
    Test2 *m_test;
    BOOL mo;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Test2 *t2 = [[Test2 alloc] init];
    [t2 test];
    
//    m_test = [[Test2 alloc] init];
//    [m_test test];
    return;
    TViewController *tv = [[TViewController alloc] init];
    [self addChildViewController:tv];
    [self.view addSubview:tv.view];
    return;
    // Do any additional setup after loading the view, typically from a nib.
    
// 1. 临时变量 test
//    TestThread *thread = [[TestThread alloc] initWithTarget:self selector:@selector(threadRun) object:nil];
//    thread.name = @"test thread";
//    [thread start];
//    [thread directCall];
    
   // 2. 临时变量 + runloop test
//    TestThread *thread = [[TestThread alloc] initWithTarget:self selector:@selector(threadRunAndAddRunloop) object:nil];
//    thread.name = @"test thread";
//    [thread start];
    
    // 3. 成员变量 + runloop test  响应 perform
    m_thread = [[TestThread alloc] initWithTarget:self selector:@selector(threadRunAndAddRunloop) object:nil];
    m_thread.name = @"m_thread thread";
    [m_thread start];
    mo = YES;
    
//     4. 成员变量 test 不响应 perform
//        m_thread = [[TestThread alloc] initWithTarget:self selector:@selector(threadRun) object:nil];
//        m_thread.name = @"m_thread thread";
//        [m_thread start];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(60, 60, 60, 50)];
    btn.backgroundColor =[UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(callThreadMethod) forControlEvents:UIControlEventTouchUpInside];
}

- (void)threadRun {
    NSLog(@"thread name:%@",[NSThread currentThread].name);
}

- (void)threadRunAndAddRunloop {
    NSLog(@"thread name:%@",[NSThread currentThread].name);
    while  (mo) {
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
        sleep(1);
    }
    NSLog(@"mo tai");
}

//  crash!!!!!
- (void)threadRunAndAddRunloop_timeSorce {
    NSLog(@"thread name:%@",[NSThread currentThread].name);
    [[NSRunLoop currentRunLoop] addTimer:[[NSTimer alloc] init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
}

- (void)performTest {
        mo = NO;
    NSLog(@"performTest thread name:%@",[NSThread currentThread].name);
}
- (void)callThreadMethod {
     mo = NO;
    [self performSelector:@selector(performTest) onThread:m_thread withObject:nil waitUntilDone:NO];
}

@end
