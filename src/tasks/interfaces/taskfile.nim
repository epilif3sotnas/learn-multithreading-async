# std
import
    std/[
        asyncdispatch
    ]


type
    TaskFile* = concept a
        a.get(string) is Future[string]