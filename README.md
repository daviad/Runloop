# Runloop
## 前沿
网上有很多 RunLoop 的资料。都讲的很好。比如
 https://blog.csdn.net/app_ios/article/details/54909381  
 https://blog.ibireme.com/2015/05/18/runloop/   
 https://blog.csdn.net/shenjie12345678/article/details/52050054   
 https://www.cnblogs.com/ioshe/p/5489112.html    
http://www.cnblogs.com/mddblog/p/6435510.html    

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
	* maybe：`while(1) sleep(time)`  只是 Runloop 的一种类似情况。类似是他的 timer source 
	* sleep wait 都可以让 CPU 休息。 但是 wait 会释放资源锁（比如：自己添加的防止数据错乱的锁）。  

4. `[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];` 什么意思  
	
	>Runs the loop once, blocking for input in the specified mode until a given date.

	* once 只执行一次。
	* 有效的一次，即必须执行了 source 事件，就返回，执行后面的代码。不然就 休眠。
	* 如果没有 source 事件， 就 blocking 休眠。这句代码后面的 不会执行
	* given date 到 也会返回。 执行后面代码

5. `[[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];`    什么意思   
	
	>Runs the loop until the specified date, during which time it processes data from all attached input sources.

	* 一直执行 loop （ 有事件处理，没有就休眠）
	* 直到 specified date 到达。退出，不然一直执行。
	* 退出之后，才执行 后面的代码

## 总结
* runloop 是一个循环
* runloop 需要添加事件源
* runloop 没有事件时，休眠
* runloop 的休眠在内核态，不占用CPU，和通常使用的 while 不同

区别
//        
        
