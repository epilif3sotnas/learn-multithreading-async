# nim
import
  std/os

# internal
import
  ./tasks/[
    distributetask,
    fibonacci,
    file,
    index,
    jsonparse,
    osinformation,
    osversion,
    square
  ],
  ./distributethread/mythreadpool



proc main() =
  let
    fibonacci = newFibonacci()
    file = newFile()
    index = newIndex()
    jsonParse = newJsonParse()
    osInformation = newOsInformation()
    osVersion = newOsVersion()
    square = newSquare()

    distributeTask = newDistributeTask()

    myThreadpool = newMyThreadpool(distributeTask)

  for i in 0..<1_000_000:
    discard myThreadpool.processService(fibonacci, 50'u32)
    discard myThreadpool.processService(file, getCurrentDir() & "../LICENSE")
    discard myThreadpool.processService(index, "https://www.google.com")
    discard myThreadpool.processService(jsonParse, @[("Name", "Filipe"), ("Description", "Nice JSON")])
    discard myThreadpool.processService(osInformation)
    discard myThreadpool.processService(osVersion)
    discard myThreadpool.processService(square, 1_000_000'u32)

when isMainModule:
  main()