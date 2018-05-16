//
//  ViewController.m
//  RunLoopTest
//
//  Created by 丁秀伟 on 2018/5/16.
//  Copyright © 2018年 丁秀伟. All rights reserved.
//

#import "ViewController.h"
#import "TestThread.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TestThread *thread = [[TestThread alloc] initWithTarget:self selector:@selector(threadRun) object:nil];
    thread.name = @"test thread";
    [thread start];
    [thread directCall];
}

- (void)threadRun {
    NSLog(@"thread name:%@",[NSThread currentThread].name);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
