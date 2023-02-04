# Introduction

Conditional evaluation is one of the handful of ways that Julia offers to _control the flow_ of your program.

There are three primary conditional expressions that are used in Julia:

- `if`-expressions
- The ternary operator
- Short-circuit evaluation

Suppose you need a program to execute a cetain set of statements, given that the boolean expression is satisfied, then structure the code according to the syntax that Julia provides.

Below are examples of the syntax for conditional evaluation in Julia. 

## Examples

```julia
# Assign x to 3
julia> x = 3
3

# if syntax
julia> if x > 0
            true
        else
            false
        end
true

# ternary syntax
julia> x > 0 ? true : false
true

# short-circuit syntax
julia> x > 0 || false
true
```

The above code is just to introduce you to the respective syntaxes are defined in Julia. We will treat each of them in detail in their respective section in the Julia track.