# Instructions append
~~~~exercism/note

You may (or may not!) want to call the function `permutations(a, t)` from [Combinatorics.jl][combinatorics] in your solution.

[combinatorics]: https://juliamath.github.io/Combinatorics.jl/stable/api/#Combinatorics.permutations-Tuple{Any,%20Integer}
~~~~

- If working in the online editor, you can call `permutations(a ,t)` freely as it is already in the namespace. You can see the source code in the tab labeled `permutations.jl`.
- If working locally, add `include("permutations.jl")` to the top of your solution file to access a version of `permutations(a, t)` located there. 

~~~~exercism/caution

If you use Combinatorics.jl v1.0.3 locally, `permutations(a, t)` is very slow on the large tests.
Use either the provided file `permutations.jl`, Combinatorics.jl v1.0.2, or, should it exist, a release after v1.0.3.

~~~~
