# Runloop
## 前沿
网上有很多 RunLoop 的资料。都讲的很好。比如
但有些地方我总是不能很好的理解。通过自我实践，感觉自己理解了，现主要以问答的方式记录下来。

## 疑惑 & 思考
1. runloop 保活线程
	* 线程为什么要保活？
	* 为什么用 runloop 保活，怎样保活？ 
	  
	创建线程非常耗费资源 

## 总结
* runloop 是一个循环
* runloop 需要添加事件源
* runloop 没有事件时，休眠
* runloop 的休眠在内核态，不占用CPU，和通常使用的 while 不同
