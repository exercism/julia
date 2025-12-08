# Instructions append
~~~~exercism/note

You may (or may not!) want to call the function `permutations(a, t)` from [Combinatorics.jl][combinatorics] in your solution.

[combinatorics]: https://juliamath.github.io/Combinatorics.jl/stable/api/#Combinatorics.permutations-Tuple{Any,%20Integer}
~~~~

- If working either in the online editor or locally with `Combinatorics.jl` installed in your environment, `permutations(a, t)` is already in the namespace, but you would normally need to add one of: `using Combinatorics` or `using Combinatorics: permutations` to your solution file.
- If working locally, without `Combinatorics.jl` installed in your environment, you can uncomment the relevant code in `permutations.jl` and add `include("permutations.jl")` at the top of your solution file to access a version of `permutations(a, t)`. You will also need to comment out or remove the line `using Combinatorics: permutations` in `runtests.jl`.

~~~~exercism/caution

If you use Combinatorics locally, `permutations(a, t)` in v1.0.3 is likely too slow to pass the large tests. 
Use either v1.0.2, or a release after v1.0.3.

~~~~
