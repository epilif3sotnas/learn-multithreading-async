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
    if url.len() == 0:
        return "URL IS EMPTY"

    if not url.contains("http"):
        return "URL BAD REQUEST"

    return await self.asyncClient.getContent(url)