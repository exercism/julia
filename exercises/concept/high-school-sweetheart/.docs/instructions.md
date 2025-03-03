# Instructions

In this exercise, you are going to help high school sweethearts profess their love on social media by generating a unicode heart with their initial:

```
❤ J.  +  M. ❤
```

## 1. Clean up the name

Implement the `cleanupname` method.
It should take a name and remove all `-` characters from it and replace them with a space.
It should also remove any whitespace from the beginning and end of the name.

```julia-repl
julia> cleanupname("Jane-Ann")
"Jane Ann"
```

## 2. Get the name's first letter

Implement the `firstletter` method.
It should take a name and return its first letter as a string.
Make sure to reuse `cleanupname` that you defined in the previous step and compose it with other functions.

```julia-repl
julia> firstletter("Jane")
"J"
```
