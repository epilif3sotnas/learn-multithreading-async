# nim
import
    std/[
        asyncfile,
        asyncdispatch
    ]


type
    File* = ref object

proc newFile*(): File =
    return File()

proc get*(self: File, path: string): Future[string] {.async.} =
    if path.len() == 0:
        return "PATH IS EMPTY"

    let file = openAsync(path, fmRead)
    let fileContent = await file.readAll()
    file.close()

    return fileContent