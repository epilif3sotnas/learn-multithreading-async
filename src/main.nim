# nim
import
  std/[
    os,
    tables
  ]

# internal
import
  ./tasks/[
    distributetask,
    fibonacci,
    licensefile,
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
    discard processService[Fibonacci, uint32, uint64](myThreadpool, fibonacci, 50'u32)
    discard processService[LicenseFile, string, string](myThreadpool, file, getCurrentDir() & "/LICENSE")
    discard processService[Index, string, string](myThreadpool, index, "https://www.google.com")
    discard processService[JSONParse, Table[string, string], string](myThreadpool, jsonParse, {"Name": "Filipe", "Description": "Nice JSON"}.toTable())
    discard processService[OSInformation, string](myThreadpool, osInformation)
    discard processService[OSVersion, string](myThreadpool, osVersion)
    discard processService[Square, uint32, uint64](myThreadpool, square, 1_000_000'u32)

when isMainModule:
  main()