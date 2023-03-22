# nim
import
    std/[
        strutils,
        httpclient,
        asyncdispatch
    ]


type
    Index* = ref object
        asyncClient: AsyncHttpClient

proc newIndex*(): Index =
    return Index(asyncClient: newAsyncHttpClient())

proc get*(self: Index, url: string): Future[string] {.async.} =
    return await self.asyncClient.getContent(url)