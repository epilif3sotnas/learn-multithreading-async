# std
import
    std/[
        json,
        tables
    ]


type
    JSONParse* = ref object

proc newJSONParse*(): JSONParse =
    return JSONParse()

proc parse*(self: JSONParse, obj: Table[string, string]): string =
    if obj.len() < 1:
        return "INVALID SEQUENCE"

    return $(%obj)