---
title: 常用Java性能工具
tags:
  - java
  - performance
  - gc
categories:
  - Tech
date: 2019-09-24 18:14:13
---

# 常用Java性能工具

## jps - JVM Process Status Tool

```sh
jps 

jps -v  # 列出jvm参数
```

## jstat - 查看gc

```sh
$ jstat -gcutil 451 1000 5 # 进程451号，间隔1000ms，一共5次
  S0     S1     E      O      M     CCS    YGC     YGCT    FGC    FGCT     GCT   
  0.00 100.00  93.96   7.54  94.57  92.19    573   16.549     0    0.000   16.549
  0.00 100.00  93.96   7.54  94.57  92.19    573   16.549     0    0.000   16.549
  0.00 100.00  93.96   7.54  94.57  92.19    573   16.549     0    0.000   16.549
  0.00 100.00  93.96   7.54  94.57  92.19    573   16.549     0    0.000   16.549
  0.00 100.00  94.12   7.54  94.57  92.19    573   16.549     0    0.000   16.549
```

- S0: 新生代中Survivor space 0区已使用空间的百分比
- S1: 新生代中Survivor space 1区已使用空间的百分比
- E: 新生代已使用空间的百分比
- O: 老年代已使用空间的百分比
- P: 永久带已使用空间的百分比
- YGC: 从应用程序启动到当前，发生Yang GC 的次数
- YGCT: 从应用程序启动到当前，Yang GC所用的时间【单位秒】
- FGC: 从应用程序启动到当前，发生Full GC的次数
- FGCT: 从应用程序启动到当前，Full GC所用的时间
- GCT: 从应用程序启动到当前，用于垃圾回收的总时间【单位秒】



## async-profiler

> 官网：https://github.com/jvm-profiling-tools/async-profiler
>
> This project is a low overhead sampling profiler for Java that does not suffer from Safepoint bias problem. It features HotSpot-specific APIs to collect stack traces and to track memory allocations. The profiler works with OpenJDK, Oracle JDK and other Java runtimes based on the HotSpot JVM.

仅支持macOS、Linux



## jmap - 进程dump/对象统计

> jvm 性能调优工具之 jmap:https://www.jianshu.com/p/a4ad53179df3

### 查看进程的内存映像信息
```
$ jmap 129
Attaching to process ID 129, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 25.262-b10
0x0000150b88612000      86K     /usr/lib64/libgcc_s-4.8.5-20150702.so.1
0x0000150b88a76000      108K    /usr/lib64/libresolv-2.17.so
0x0000150b88c90000      27K     /usr/lib64/libnss_dns-2.17.so
略
```

### 显示Java堆详细信息
```
$ jmap -heap 129
Attaching to process ID 129, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 25.262-b10

using thread-local object allocation.  
Garbage-First (G1) GC with 4 thread(s) 使用的GC算法

Heap Configuration: 堆配置
   MinHeapFreeRatio         = 40
   MaxHeapFreeRatio         = 70
   MaxHeapSize              = 3623878656 (3456.0MB)
   NewSize                  = 1363144 (1.2999954223632812MB)
   MaxNewSize               = 2173698048 (2073.0MB)
   OldSize                  = 5452592 (5.1999969482421875MB)
   NewRatio                 = 2
   SurvivorRatio            = 8
   MetaspaceSize            = 21807104 (20.796875MB)
   CompressedClassSpaceSize = 1065353216 (1016.0MB)
   MaxMetaspaceSize         = 1073741824 (1024.0MB)
   G1HeapRegionSize         = 1048576 (1.0MB)

Heap Usage: 各内存区域内存使用
G1 Heap:
   regions  = 3456
   capacity = 3623878656 (3456.0MB)
   used     = 41143808 (39.23779296875MB)
   free     = 3582734848 (3416.76220703125MB)
   1.1353528058087383% used
G1 Young Generation:
Eden Space:
   regions  = 9
   capacity = 166723584 (159.0MB)
   used     = 9437184 (9.0MB)
   free     = 157286400 (150.0MB)
   5.660377358490566% used
Survivor Space:
   regions  = 22
   capacity = 23068672 (22.0MB)
   used     = 23068672 (22.0MB)
   free     = 0 (0.0MB)
   100.0% used
G1 Old Generation:
   regions  = 9
   capacity = 3434086400 (3275.0MB)
   used     = 8637952 (8.23779296875MB)
   free     = 3425448448 (3266.76220703125MB)
   0.2515356631679389% used

16840 interned Strings occupying 1780664 bytes.
```

### 显示堆中对象的统计信息
```
$ jmap -histo:live  129

 num     #instances         #bytes  class name
----------------------------------------------
   1:         36110        3324080  [C
   2:         22965        1469760  java.nio.DirectByteBuffer
   3:          2711        1429104  [B
   4:         22937        1284472  org.apache.flink.core.memory.MemorySegment
   5:          8940         992232  java.lang.Class
   6:         22962         918480  sun.misc.Cleaner
   7:            28         917952  [Ljava.util.concurrent.ForkJoinTask;
   8:         36067         865608  java.lang.String
   9:          8017         775248  [Ljava.lang.Object;
  10:         22959         734688  java.nio.DirectByteBuffer$Deallocator
略
```

### 打印类加载器信息
```
$ jmap -finalizerinfo 129
Attaching to process ID 129, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 25.262-b10
Number of objects pending for finalization: 0  -- 说明当前F-QUEUE队列中并没有等待Fializer线程执行final
```


### 生成堆转储快照dump文件
- Java虚拟机的运行时快照
- heap如果比较大的话，就会导致这个过程比较耗时
- 执行的过程中为了保证dump的信息是可靠的，所以会暂停应用， **线上系统慎用**。

```sh
jmap -dump:format=b,file=heapdump.phrof 129
jmap -dump:format=b,file=heapdump.phrof,live 129  # 进活动线程

jmap -dump:live,format=b,file=heap.bin 111

jmap -dump:format=b,file=heapdump.bin <app_pid>
```

### 查看dump文件

方案一：使用jvisualvm查看dump文件（文件>加载，选中输出的dump文件）

方案二：jhat查看dump文件(如果解析过程中出现内存不足，需要加大内存)。通过浏览器访问 http://ip:7000/即可看到分析结果
```
> jhat -J-mx512m heap.bin
...
.....Started HTTP server on port 7000
Server is ready.
```


## jstack - 应用堆栈

```sh
jstack -l pid
```
