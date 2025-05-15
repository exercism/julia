# Introduction

A `String` in Julia is an ordered sequence of characters. As the manual points out: "Of course, the real trouble comes when one asks what a character is."

Much of this complexity will be covered in more detail in the `Chars` Concept, but briefly:

- All strings in Julia are Unicode.
- Strings which also happen to be ASCII (English letters A to Z in upper and lowercase, digits and a few punctuation characters) are _easy_ to work with.
- Most other world writing systems are _possible_ to work with, but need more care.

## String literals

In general strings are enclosed in double-quotes `" "`.
Single-quotes `' '` are only used for `Chars`.

It is also possible to use triple double-quotes `""" """`, which allows use of `"` inside the string without escaping.
More importantly, unwanted extra indentation is stripped from multiline strings.

```julia-repl
julia> """
       Multiline
       
       """
"Multiline\nString\n"
```

### Escaping characters

Like most languages from C onwards, Julia uses a backslash `\` for escaping:

1. To enter non-printing characters, such as the newline `\n` in the previous example.
2. To protect characters which would otherwise have a special meaning, such as `\$` (see below).

## Indexing

In principle, strings can be indexed exactly like vectors:

```julia-repl
julia> s[1], s[5]
('J', 'a')
```

This clearly works for an ASCII string like "Julia", but that ignores most of the world's languages.

Consider one of the characters in Beowulf, written in Old English about 15 centuries ago.

"Hrōðgār" is clearly 7 characters, but not all of them are ASCII.

```julia-repl
julia> king = "Hrōðgār"
"Hrōðgār"

julia> length(king)
7

julia> isascii(king)
false

# collect() converts to a Char vector:
julia> collect(king)
7-element Vector{Char}:
 'H': ASCII/Unicode U+0048 (category Lu: Letter, uppercase)
 'r': ASCII/Unicode U+0072 (category Ll: Letter, lowercase)
 'ō': Unicode U+014D (category Ll: Letter, lowercase)
 'ð': Unicode U+00F0 (category Ll: Letter, lowercase)
 'g': ASCII/Unicode U+0067 (category Ll: Letter, lowercase)
 'ā': Unicode U+0101 (category Ll: Letter, lowercase)
 'r': ASCII/Unicode U+0072 (category Ll: Letter, lowercase)
```

Indexing into a string like this starts well, but at some point breaks down:

```julia-repl
julia> king[3]
'ō': Unicode U+014D (category Ll: Letter, lowercase)

julia> king[4]
ERROR: StringIndexError: invalid index [4], valid nearby indices [3]=>'ō', [5]=>'ð'
```

The problem is that indexing like this counts _bytes_, which for non-ASCII strings do not have a 1:1 relationship to characters.
A Unicode/UTF-8 character may need up to 4 bytes to represent it, and the `Chars` Concept will explore this further.

## Building strings

### Concatenation

Many languages use `+` as the string concatenation operator, but not Julia.
At least the error message is helpful.

```julia-repl
julia> "s1 " + "s2"
ERROR: MethodError: no method matching +(::String, ::String)
The function `+` exists, but no method is defined for this combination of argument types.
String concatenation is performed with * 

julia> "s1 " * "s2"
"s1 s2"
```

The `string()` function will concatenate an arbitrary number of strings.

```julia-repl
julia> string("lots ", "of ", "bits")
"lots of bits"
```

The `join()` function will do the same, and will also take a vector of strings and concatenate them with a given separator (defaulting to `""`).

```julia-repl
julia> join(["lots", "of", "bits"], "_")
"lots_of_bits"
```

Note that strings are immutable, and concatenation involves copying.
Thus, repeated concatenations within a loop are inefficient and it is better to collect the fragments in a vector and join all of them them at the end.

### Repetition

Simple:

```julia-repl
julia> repeat("Abc", 5)
"AbcAbcAbcAbcAbc"
```

### Interpolation

Many languages have a way to insert calculated values into strings, though there is extraordinary disagreement on the best syntax to use.

In Julia, interpolated values are preceded by `$`.

```julia-repl
julia> myvar = 42
42

julia> "myvar evaluates to $myvar"
"myvar evaluates to 42"

julia> r = 5.3
5.3

julia> "A circle of radius $r has area $(π * r^2)"
"A circle of radius 5.3 has area 88.24733763933729"
```

Parentheses are required when omitting them would be ambiguous, but optional for a single identifier followed by whitespace.

To include a $ in the string, escape it as `\$`.

Note the limitation that interpolation does not currently allow formatting, such as the number of decimal places to display.

### `@sprintf()`

For finer control over string assembly, Julia copies the `sprintf` function from C (and several later languages: Wikipedia lists about 30).

In Julia, this is implemented as a `macro` within the `Printf` module, hence the `@` prefix.

```julia-repl
julia> using Printf

julia> r = 5.3
5.3

julia> @sprintf("A circle of radius %.1f has area %.2f", r, π * r^2)
"A circle of radius 5.3 has area 88.25"
```

## String functions

For simplicity, this section will concentrate on functions that return a new string and leave the input unchanged.
Many have an equivalent, named with a `!` suffix, that modify the input in place.

### Length

How long is a string?
Sometimes, it depends how you are counting.

The simple case is ASCII strings, with every character occupying 1 byte.

```julia-repl
julia> string_asc = "Julia"
"Julia"

julia> length(string_asc)
5

julia> sizeof(string_asc)
5
```

The `length()` function returns the number of _characters_, and the `sizeof()` function the number of _bytes_.

This distinction becomes important with other character sets:

```julia-repl
julia> king = "Hrōðgār"
"Hrōðgār"

julia> length(king)
7

julia> sizeof(king)
10
```

### Splitting

A common operation in programming is to take a long string and split it into pieces, based on a separator string of one or more characters.

Most generally, we use the `split()` function.
The separator defaults to (any) whitespace, but others can be specified.

```julia-repl
julia> split("my little string")
3-element Vector{SubString{String}}:
 "my"
 "little"
 "string"

julia> split("My_snake_case_string", "_")
4-element Vector{SubString{String}}:
 "My"
 "snake"
 "case"
 "string"
```

These examples split a string into smaller _strings_.
Splitting a string into _characters_ is a different operation.

### Find and replace

Does a string contain a specified substring?
Oddly, there are two functions to test this: `occursin()` and `contains()` differ only in the order of their arguments.

```julia-repl
julia> needle = "Julia"
"Julia"

julia> haystack = "Python, Julia and R"
"Python, Julia and R"

julia> occursin(needle, haystack)
true

julia> contains(haystack, needle)
true
```

To be more specific about position:

```julia-repl
julia> startswith(haystack, "Python")
true

julia> endswith(haystack, "Python")
false
```

To get the start:end indices of a substring, we have several functions:

- `findfirst()`
- `findlast()`
- `findprev()`
- `findnext()`

```julia-repl
julia> findfirst(needle, haystack)
9:13
```

To replace substrings, list the changes using `x => y` syntax.

```julia-repl
julia> replace("abc", "a"=>"b", "b"=>"c", "c"=>"a")
"bca"
```

Since Julia 1.7, the `replace` function can take an arbritrary number of changes, with a guarantee that no character will be changed more than once during the replace.

The `x => y` syntax is called a `pair`, an important type in Julia which is covered in more details in the `Dicts and Pairs` Concept.

### Whitespace

We often need to remove leading and/or trailing whitespace from a string.

Functions for this are `lstrip()` (left), `rstrip()` (right), `strip()` (both).

```julia-repl
julia> strip("\n\t  useful_bit\n\n")
"useful_bit"
```

### Change case

These functions have fairly self-explanatory names:

```julia-repl
julia> s = repeat("aBcD ", 5)
"aBcD aBcD aBcD aBcD aBcD "

julia> uppercase(s)
"ABCD ABCD ABCD ABCD ABCD "

julia> lowercase(s)
"abcd abcd abcd abcd abcd "

julia> titlecase(s)  # Initial letter of each word uppercase
"Abcd Abcd Abcd Abcd Abcd "
```
