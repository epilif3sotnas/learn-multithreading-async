# nim
import std/osproc


type
    OSInformation* = ref object

proc newOSInformation*(): OSInformation =
    return OSInformation()

proc proccess*(self: OSInformation): string =
    let output = execCmdEx("neofetch")

    if output[1] != 0:
        return "ERROR FROM THE SYSTEM"

    return output[0]