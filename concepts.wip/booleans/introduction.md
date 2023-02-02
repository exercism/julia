# Introduction

True or false values are represented by the `Bool` type.
It contains only two values: `true` and `false`.

In Julia, it is a built-in _data_ _type_.

> In programming languages with a built-in Boolean data type, such as Pascal and Java[^1], the comparison operators such as `>` and `!=` are usually defined to return a Boolean value[^2].

[^1]: This also includes Julia, among other programming languages.
[^2]: [Programming generalities](https://en.wikipedia.org/wiki/Boolean_data_type#Generalities).

```julia
julia> true
true

julia> false
false

# We can check for types in Julia,
# with the `typeof` function.
julia> typeof(true)
Bool

julia> typeof(false)
Bool
```
