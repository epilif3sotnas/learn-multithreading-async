type
    TaskParser* = concept a
        a.parse(ref object) is string