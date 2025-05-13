# About

A `String` in Julia is an ordered sequence of characters. As the [manual][strings] points out: "Of course, the real trouble comes when one asks what a character is."

Much of this complexity will be covered in more detail in the [`Chars`][chars] Concept, but briefly:

- All strings in Julia are [Unicode][unicode].
- Strings which also happen to be [ASCII][ascii] (English letters A to Z in upper and lowercase, digits and a few punctuation characters) are _easy_ to work with.
- Most other world writing systems are _possible_ to work with, but need more care.

## String literals

In general strings are enclosed in double-quotes `" "`.
Single-quotes `' '` are only used for `Chars`.

It is also possible to use triple double-quotes `""" """`, which allows use of `"` inside the string without escaping.
More importantly, unwanted extra indentation is stripped from multiline strings.

```julia-repl
julia> """
       Multiline
       String
       """
"Multiline\nString\n"
```

### Escaping characters

Like most languages from C onwards, Julia uses a backslash `\` for escaping:

1. To enter non-printing characters, such as the newline `\n` in the previous example.
2. To protect characters which would otherwise have a special meaning, such as `\$` (see below).

## Iteration

A string is an iterable collection, so a `for ... in` loop will work without any need to convert to a vector of characters.

```julia-repl
julia> s = "Julia"
"Julia"

# admittedly, this is a silly example
julia> for c in s; print(c, "; "); end
J; u; l; i; a; 
```

Iterating like this has the advantage that Julia will handle character boundaries correctly, even for non-ASCII strings.
The significance of this will become clearer in the next section.

## Indexing

In principle, strings can be indexed exactly like vectors:

```julia-repl
julia> s[1], s[5]
('J', 'a')
```

This clearly works for an ASCII string like "Julia", but that ignores most of the world's languages.

Consider one of the characters in [Beowulf][beowulf], written in Old English about 15 centuries ago.

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
A Unicode/UTF-8 character may need up to 4 bytes to represent it, and the [`Chars`][chars] Concept will explore this further.

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

Workarounds include:

- Wrap the calculation in a [`round()`][round] function.
- Outside the Exercism test runner, the [PyFormattedStrings][PyFormattedStrings] package emulates Python f-strings.
- The `@sprintf()` macro is described below.

### `@sprintf()`

For finer control over string assembly, Julia copies the `sprintf` function from C (and several later languages: Wikipedia [lists][printf-ports] about 30).

In Julia, this is implemented as a [`macro`][macro] within the `Printf` module, hence the `@` prefix.

```julia-repl
julia> using Printf

julia> r = 5.3
5.3

julia> @sprintf("A circle of radius %.1f has area %.2f", r, π * r^2)
"A circle of radius 5.3 has area 88.25"
```

## String functions

For simplicity, this section will concentrate on functions that return a new string and leave the input unchanged.
Many have an an equivalent, named with a `!` suffix, that modify the input in place.

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

Most generally, we use the [`split()`][split] function.
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

```julia-repl
julia> collect("input string")
12-element Vector{Char}:
 'i': ASCII/Unicode U+0069 (category Ll: Letter, lowercase)
 'n': ASCII/Unicode U+006E (category Ll: Letter, lowercase)
 'p': ASCII/Unicode U+0070 (category Ll: Letter, lowercase)
 'u': ASCII/Unicode U+0075 (category Ll: Letter, lowercase)
 't': ASCII/Unicode U+0074 (category Ll: Letter, lowercase)
 ' ': ASCII/Unicode U+0020 (category Zs: Separator, space)
 's': ASCII/Unicode U+0073 (category Ll: Letter, lowercase)
 't': ASCII/Unicode U+0074 (category Ll: Letter, lowercase)
 'r': ASCII/Unicode U+0072 (category Ll: Letter, lowercase)
 'i': ASCII/Unicode U+0069 (category Ll: Letter, lowercase)
 'n': ASCII/Unicode U+006E (category Ll: Letter, lowercase)
 'g': ASCII/Unicode U+0067 (category Ll: Letter, lowercase)
```

### Find and replace

Does a string contain a specified substring?
Oddly, there are two functions to test this: [`occursin()`][occursin] and [`contains()`][contains] differ only in the order of their arguments.

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

- [`findfirst()`][findfirst]
- [`findlast()`][findlast]
- [`findprev()`][findprev]
- [`findnext()`][findnext]

```julia-repl
julia> findfirst(needle, haystack)
9:13
```

To replace substrings, list the changes using `x => y` syntax.

```julia-repl
julia> replace("abc", "a"=>"b", "b"=>"c", "c"=>"a")
"bca"
```

Since Julia 1.7, the [`replace`][replace] function can take an arbritrary number of changes, with a guarantee that no character will be changed more than once during the replace.

The `x => y` syntax is called a `pair`, an important type in Julia which is covered in more details in the [`Dicts and Pairs`][dicts-pairs] Concept.

***Note***: For simplicity, all the examples above use string literals.
Many of the functions are more general, and will also work with Regular Expressions.
We will return to this in a later Concept.

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

### Parsing

Interconverting numbers and their string representation is often useful.

Number-to-string is simple, though a base other than the default 10 needs an extra parameter:

```julia-repl
julia> string(42)
"42"

julia> string(42, base=16)
"2a"

julia> string(42, base=2)
"101010"
```

Parsing a string to get a numeric value is slightly more complicated, with more potential for error.
Specifying the target numeric type is obligatory, specifying the base is optional and defaults to 10.

```julia-repl
julia> parse(Int, "42")
42

julia> parse(Float64, "42")
42.0

julia> parse(Int, "42?")
ERROR: ArgumentError: invalid base 10 digit '?' in "42?"

julia> parse(Int, "42 ")  # whitespace may be tolerated
42
```

## Special strings

Sometimes it is useful to suppress the usual interpolation and excaping within strings.
For this, preface the opening quote with `raw`.

```julia-repl
julia> x = 10
10

julia> "x = $x if we use \$ for interpolation"
"x = 10 if we use \$ for interpolation"

julia> raw"x = $x if we use \$ for interpolation"
"x = \$x if we use \\\$ for interpolation"
```

Regular Expressions have their own complicated syntax, and Julia provides two helpful string types: `r" "` for the Regex and `s" "` for working with captured fragments.

Various other special strings are less common in Exercism-style programming, though widely used in creating libraries.

- Semantic version strings `v"x.y.z"` handle the major.minor.patch numbering for software releases.
- Byte array literals `b" "` bypass Unicode character boundaries and operate at byte level.


[strings]: https://docs.julialang.org/en/v1/manual/strings/
[unicode]: https://en.wikipedia.org/wiki/Unicode
[ascii]: https://en.wikipedia.org/wiki/ASCII
[beowulf]: https://en.wikipedia.org/wiki/Beowulf
[PyFormattedStrings]: https://juliahub.com/ui/Packages/General/PyFormattedStrings/0.1.10

[strip]: https://docs.julialang.org/en/v1/base/strings/#Base.strip
[split]: https://docs.julialang.org/en/v1/base/strings/#Base.split
[replace]: https://docs.julialang.org/en/v1/base/collections/#Base.replace-Tuple{Any,%20Vararg{Pair}}
[interpolation]: https://docs.julialang.org/en/v1/manual/strings/#string-interpolation
[sprintf]: https://docs.julialang.org/en/v1/stdlib/Printf/#Printf.@sprintf
[lowercase]: https://docs.julialang.org/en/v1/base/strings/#Base.Unicode.lowercase
[chars]: https://exercism.org/tracks/julia/concepts/chars
[findfirst]: https://docs.julialang.org/en/v1/base/strings/#Base.findfirst-Tuple%7BAbstractString,%20AbstractString%7D
[findlast]: https://docs.julialang.org/en/v1/base/strings/#Base.findlast-Tuple{AbstractString,%20AbstractString}
[findprev]: https://docs.julialang.org/en/v1/base/strings/#Base.findprev-Tuple{AbstractString,%20AbstractString,%20Integer}
[findnext]: https://docs.julialang.org/en/v1/base/strings/#Base.findnext-Tuple{AbstractString,%20AbstractString,%20Integer}
[replace]: https://docs.julialang.org/en/v1/base/strings/#Base.replace-Tuple%7BIO,%20AbstractString,%20Vararg%7BPair%7D%7D
[dicts-pairs]: https://exercism.org/tracks/julia/concepts/dicts-and-pairs
[round]: https://docs.julialang.org/en/v1/base/math/#Base.round
[macro]:https://docs.julialang.org/en/v1/manual/metaprogramming/#man-macros
