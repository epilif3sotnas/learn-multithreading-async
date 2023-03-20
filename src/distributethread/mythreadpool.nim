# nim
import
    std/[
        asyncdispatch,
        cpuinfo
    ]

# internal
import
    ./../tasks/distributetask

# external
import
    asyncthreadpool


type MyThreadPool* = ref object
    threadpool: ThreadPool
    taskDistributor: DistributeTask

proc newMyThreadPool*(): MyThreadPool =
    let numThreads = (countProcessors() / 2).int()
    
    if numThreads == 0:
        numThreads = 1

    return MyThreadPool(
        threadpool = newThreadPool(numThreads)
    )

proc processService*[TService, TArg, TReturn](
    self: MyThreadPool,
    service: TService,
    arg: TArg
): TReturn =
    return waitFor(
        self.threadpool.spawn(
            self.taskDistributor.distributeTask(
                service,
                arg
            )
        )
    )

proc processService*[TService, TReturn](
    self: MyThreadPool,
    service: TService,
): TReturn =
    return waitFor(
        self.threadpool.spawn(
            self.taskDistributor.distributeTask(
                service
            )
        )
    )