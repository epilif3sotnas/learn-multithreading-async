# std
import
    std/[
        asyncfile,
        asyncdispatch,
        asyncfutures
    ]


type
    LicenseFile* = ref object

proc newFile*(): LicenseFile =
    return LicenseFile()

proc get*(self: LicenseFile, path: string): Future[string] {.async.} =
    let
        file = openAsync(path, fmRead)
        fileContent = await file.readAll()
    
    file.close()

    return fileContent