# nim
import
    std/[
        cpuinfo,
        threadpool
    ]

# internal
import
    ./../tasks/distributetask


type MyThreadPool* = ref object
    taskDistributor: DistributeTask

proc newMyThreadPool*(taskDistributor: DistributeTask): MyThreadPool =
    var 
        maxNumThreads = (4 * countProcessors()).uint8()
        minNumThreads = maxNumThreads.shr(1)
    
    if maxNumThreads == 0:
        maxNumThreads = 4'u8
        minNumThreads = 2'u8

    setMaxPoolSize(maxNumThreads)
    setMinPoolSize(minNumThreads)

    return MyThreadPool(
        taskDistributor: taskDistributor
    )

proc processService*[TService, TArg, TReturn](
    self: MyThreadPool,
    service: TService,
    arg: TArg
): TReturn =
    return ^spawn(
        self.taskDistributor.distributeTask(
            service,
            arg
        )
    )

proc processService*[TService, TReturn](
    self: MyThreadPool,
    service: TService,
): TReturn =
    return ^spawn(
        self.taskDistributor.distributeTask(service)
    )