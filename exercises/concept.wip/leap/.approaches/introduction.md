# Introduction

## General remarks

- Use the remainder operator `%` to find if a number is evenly divisible by another
- Whenever you have an expression like `if condition; return true; else; return false`, you can rewrite it as `return condition`
- Prefer `&&` and `||` over `&` and `|` to benefit from [short-circuiting](https://docs.julialang.org/en/v1/manual/control-flow/#Short-Circuit-Evaluation). Julia will not evaluate the whole expression but only the expressions that are necessary to determine the result of the entire chain
- You might be interested to see the Julia standard library's solution: `using Dates; @edit isleapyear(4)`

## Approach: Short-circuiting

```julia
function is_leap_year(year)
    year % 400 == 0 || year % 4 == 0 && year % 100 != 0
end
```

If you're struggling to follow how this works, or trying to solve a similar problem, consider writing a truth table and seeing if you can work out what the simplest predicates are and how they can be combined with `&&` and `||` to give the full answer.

<details>
<summary>Example truth table</summary>

```
Let:

p = year % 4 == 0
q = year % 100 == 0
r = year % 400 == 0

o = is the desired output

p q r | o
0 0 0 | 0
1 0 0 | 1
...
1 1 1 | 1

```

The idea is that you 1) work out what predicates you need and 2) notice that you can construct the output with p && !q || r.
</details>
