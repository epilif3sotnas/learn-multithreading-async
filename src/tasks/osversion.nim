# nim
import
    std/osproc


type
    OSVersion* = ref object

proc newOSVersion*(): OSVersion =
    return OSVersion()

proc process*(self: OSVersion): string =
    let output = execCmdEx("uname -a")

    if output[1] != 0:
        return "ERROR FROM THE SYSTEM"

    return output[0]