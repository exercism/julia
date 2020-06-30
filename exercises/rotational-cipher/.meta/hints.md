## Bonus Tasks

This exercise is quite large and potentially complicated, and that makes it more challenging
and time-consuming to mentor. If you are in Mentor Mode or are intending to request a mentor in Practice Mode, to help your mentor out, please don't submit code for the
bonus exercises until your mentor has reviewed your solution for the first part of the
exercise.

This is a good exercise to experiment with non-standard string literals and metaprogramming.

A short introduction to non-standard string literals can be found in this [blog post](https://web.archive.org/web/20170625222109/https://iaindunning.com/blog/julia-unicode.html). A detailed metaprogramming guide can be found in the [manual](https://docs.julialang.org/en/v1/manual/metaprogramming/).

You can extend your solution by adding the functionality described below.

Bonus A only requires basics as outlined in the blog post. Bonus B requires significantly more knowledge of metaprogramming in Julia.

### Bonus A
Implement a string literal that acts as `ROT13` on the string:
```julia
R13"abcdefghijklmnopqrstuvwxyz" == "nopqrstuvwxyzabcdefghijklm"
```

### Bonus B
Implement string literals `R<i>`, `i = 0, ..., 26`, that shift the string for `i` values:
```julia
R0"Hello, World!" == "Hello, World!"
R4"Testing 1 2 3 testing" == "Xiwxmrk 1 2 3 xiwxmrk"
R13"abcdefghijklmnopqrstuvwxyz" == "nopqrstuvwxyzabcdefghijklm"
```
