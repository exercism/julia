# Instructions

In this exercise, you are going to help high school sweethearts profess their love on social media by generating a unicode heart with their initials:

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

## 3. Format the first letter as an initial

Implement the `initial` method.
It should take a name and return its first letter, uppercase, followed by a dot.
Make sure to reuse `firstletter` that you defined in the previous step.

```julia-repl
initial("Robert")
"R."
```

## 4. Put the initials inside of the heart

Implement the `couple` method.
It should take two names and return the initials with emoji hearts around.
Make sure to reuse `initial` that you defined in the previous step.

```julia-repl
couple("Blake Miller", "Riley Lewis")
"❤ B.  +  R. ❤"
```
