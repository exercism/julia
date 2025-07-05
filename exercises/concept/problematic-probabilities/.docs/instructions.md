# Instructions

A research organization has noticed that some of its junior researchers have been using less-than-optimal methods in their analysis.
One of these methods is to immediately convert discrete probabilites into floats (i.e. real numbers) before doing further calculations.

Senior researchers prefer to use rational numbers in the calculations, which may provide higher precision, and would like to know if the poor practices of the junior researchers have affected the studies' outcomes.

There were two types of studies done:
- Many tests were run, each returning a discrete probability for success, and then the mean of these probabilities was calculated.
- Many independent events were tested, and the total probability for all events to occur was calculated by multiplying them together.

The senior researchers are asking you to write functions which can help them determine if there are rounding errors in the analyses from using floats, and asking you provide a precise rational number for the outcome if there are errors.

## 1. Give the ratio of successes to trials

The `rationalize(successes, trials)` function takes two arrays, `successes` and `trials`.
For an index `i`, `successes[i]` corresponds to the number of successes which occurred in `trials[i]` number of trials.
The function returns an array of rational numbers of the successes over the number of trials, in the same order as the input arrays.

```julia-repl
julia> rationalize([1, 2, 3], [4, 5, 6])
3-element Vector{Rational{Int64}}:
 1//4
 2//5
 1//2
```

## 2. Find the real probabilities associated with successes to trials

Similarly, the `probabilities(successes, trials)` function takes two arrays, `successes` and `trials`.
It returns an array of floats of the successes over the number of trials, in the same order as the input arrays.

```julia-repl
julia> probabilities(([1, 2, 3], [4, 5, 6]))
3-element Vector{Float64}:
 0.25
 0.4
 0.5
```

## 3. Check the mean of the probabilities

The `checkmean(successes, trials)` takes the two arrays, `successes` and `trials`.
It checks the mean of the real probabilities against the mean of the rational probabilities.
- If the two probabilities are equal, `checkmean` returns `true`
- If the two probabilites are different, `checkmean` returns the rational probability.

```julia-repl
julia> successes, trials = [9, 4, 7, 8, 6], [22, 22, 11, 17, 12];
julia> checkmean(successes, trials)
true

julia> successes, trials = [6, 5, 9, 8, 9], [21, 19, 13, 25, 22];
julia> checkmean(sucesses, trials)
1873629//4754750
```

## 4. Check the independent probability

The `checkprob(successes, trials)` takes the two arrays, `successes` and `trials`.
It checks the total probability of the float probabilities against the total probability of the rational probabilities.
- If the two probabilities are equal, `checkprob` returns `true`
- If the two probabilites are different, `checkprob` returns the rational probability.

```julia-repl
julia> successes, trials = [2, 9, 4, 4, 5], [15, 11, 17, 19, 15];
julia> checkprob(successes, trials)
true

julia> successes, trials = [9, 8, 5, 4, 3], [22, 14, 19, 25, 18];
julia> checkprob(sucesses, trials)
12//7315
```
