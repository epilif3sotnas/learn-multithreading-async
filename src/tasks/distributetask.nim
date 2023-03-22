# nim
import
    std/[
        asyncdispatch,
        tables
    ]

# internal
import
    ./interfaces/[
        taskfile,
        taskmathcalculation,
        taskos,
        taskparser
    ]


type
    DistributeTask* = ref object

proc newDistributeTask*(): DistributeTask =
    return DistributeTask()

proc distributeTask*(
    self: DistributeTask,
    service: TaskFile,
    arg: string
): string =
    if arg.len() == 0:
        return "NO ARG"

    return waitFor service.get(arg)

proc distributeTask*(
    self: DistributeTask,
    service: TaskMathCalculation,
    arg: SomeUnsignedInt
): uint64 =
    return service.compute(arg)

proc distributeTask*(
    self: DistributeTask,
    service: TaskOS
): string =
    return service.process()

proc distributeTask*[TArg](
    self: DistributeTask,
    service: TaskParser,
    arg: TArg
): string =
    return service.parse(arg)