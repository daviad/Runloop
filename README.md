# Runloop
## 前沿
网上有很多 RunLoop 的资料。都讲的很好。比如
 https://blog.csdn.net/app_ios/article/details/54909381
 https://blog.ibireme.com/2015/05/18/runloop/
 https://blog.csdn.net/shenjie12345678/article/details/52050054

但有些地方我总是不能很好的理解。通过自我实践，感觉自己理解了，现主要以问答的方式记录下来。

## 疑惑 & 思考
1. runloop 保活线程
	* 线程为什么要保活？
	* 为什么用 runloop 保活，怎样保活？ 
	  
	 - 创建线程非常耗费资源。 
	 - 线程对象 NSThread 和一般的对象操作方式不一样。线程的方法调用通过 start 启动，由线程自己（CPU）调度执行。 （performSelector... 等方法由系统 runloop 封装实现，后面再讲）直接调用线程的执行方法没有在其线程执行的效果。 
	 - 由测试可知，局部 thread selector（threadRun）执行接受，thread 就dealloc了。即使全局变量也无法执行 theadRun 了。即使通过performSelector 也没有效果。
	 - 线程一般都是一次执行完任务，就销毁了
2. 线程  休眠
3. while（1） sleep  wait

## 总结
* runloop 是一个循环
* runloop 需要添加事件源
* runloop 没有事件时，休眠
* runloop 的休眠在内核态，不占用CPU，和通常使用的 while 不同

区别
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
