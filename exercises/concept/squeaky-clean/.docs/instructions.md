# Instructions

In this exercise you will implement a partial set of utility routines to help a developer clean up identifier names.

In the 6 tasks you will gradually build up the functions `transform` to convert single characters and `clean` to convert strings.

A valid identifier comprises zero or more letters, underscores, hyphens, question marks and emojis.

If an empty string is passed to the `clean` function, an empty string should be returned.

## 1. Replace any hyphens encountered with underscores

Implement the `transform` function to replace any hyphens with underscores.

```julia
julia> transform('-')
"_"
```

## 2. Remove all whitespace

Remove all whitespace characters.
This will include leading and trailing whitespace.

```julia
julia> transform(' ')
""
```

## 3. Convert camelCase to kebab-case

Modify the `transform` function to convert camelCase to kebab-case

```julia
julia> transform('D')
"-d"
```

## 4. Omit characters that are digits

Modify the `transform` function to omit any characters that are numeric.

```julia
julia> transform('7')
""
```

## 5. Replace Greek lower case letters with question marks

Modify the `transform` function to replace any Greek letters in the range 'α' to 'ω'.

```julia
julia> transform('β')
"?"
```

## 6. Combine these operations to operate on a string

Implement the `clean` function to apply these operations to an entire string.

Characters which fall outside the rules should pass through unchanged.

```julia
julia> clean("  a2b Cd-ω😀  ")
"ab-cd_?😀"
```
