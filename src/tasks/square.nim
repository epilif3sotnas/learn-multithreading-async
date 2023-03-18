type
    Square* = ref object

proc newSquare*(): Square =
    return Square()

proc compute*(self: Square, num: uint32): uint64 =
    return num * num