# Spiral Matrix

Given the size, return a square matrix of numbers in spiral order.

The matrix should be filled with natural numbers, starting from 1
in the top-left corner, increasing in an inward, clockwise spiral order,
like these examples:

###### Spiral matrix of size 3

```text
1 2 3
8 9 4
7 6 5
```

###### Spiral matrix of size 4

```text
 1  2  3 4
12 13 14 5
11 16 15 6
10  9  8 7
```
## Source

Reddit r/dailyprogrammer challenge #320 [Easy] Spiral Ascension. [https://www.reddit.com/r/dailyprogrammer/comments/6i60lr/20170619_challenge_320_easy_spiral_ascension/](https://www.reddit.com/r/dailyprogrammer/comments/6i60lr/20170619_challenge_320_easy_spiral_ascension/)


## Version compatibility
Julia 1.0 and 0.7 are the only supported Julia versions on Exercism.
For the most part, the test suites and solutions should be compatible to 0.6, but you will have to change `using Test` back to `using Base.Test` in the `runtests.jl` file.
Note that 0.7 and 1.0 are almost identical, except for deprecation warnings, which have all been removed in 1.0.

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
