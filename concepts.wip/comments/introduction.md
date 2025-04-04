# Introduction

Julia supports two kinds of comments.
Single line comments are preceded by `#` and multiline comments are inserted between `#=` and `=#`.

```julia
add(1, 3) # returns 4

#= Some random code that's no longer needed but not deleted
sub(x, y) = x - y
mulsub(x, y, z) = sub(mul(x, y), z)
=#
```
