# Package

# Required

version       = "0.1.0"
author        = "epilif3sotnas <filipesantos1999@hotmail.com>"
description   = "Learn Multithreading and Async."
license       = "Apache-2.0"


# Optional

srcDir        = "src"
binDir        = "target"
bin           = @["main"]
backend       = "cpp"


# Dependencies

requires "nim >= 1.6",
        "asyncthreadpool >= 0"