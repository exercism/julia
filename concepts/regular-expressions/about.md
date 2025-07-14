# About

Regular expressions are a highly versatile way to _pattern match_ strings, using a Domain Specific Language (DSL) designed for the purpose.

Like several other programming languages, Julia makes no attempt to implement its own Regex library.
Instead, it wraps the popular [PCRE2][PCRE] library, thus providing a Regex syntax identical to (for example) Gleam, and very similar to Javascript.

~~~~exercism/note
This Julia syllabus assumes that you are already familiar with basic Regex syntax.
We will concentrate solely on [Julia-specific features][regex].

Some resources to refresh your regular expression knowledge are listed below.
~~~~

- [Regex101][regex101]
- [RegExr][regexr]
- [RexEgg][rexegg]
- [RegexOne][regexone]
- [Regular Expressions Info][regex-info]


A regular expression in Julia is simply a string prefaced by `r` before the opening `"`.
All the basic functionality is part of the standard library, with no barriers to using a Regex anywhere in code.

In fact, many of the functions already discussed in the [`Strings`][strings] Concept are designed for Regex searches as standard.

```julia-repl
julia> re = r"test$"
r"test$"

julia> typeof(re)
Regex

# Does a string end with "test"?
julia> occursin(re, "this is a test")
true

julia> occursin(re, "these are tests")
false
```

## Captures

Commonly, we want to know _what_ matches. This is achieved by including capture groups in parentheses within the regex, then using the `match()` function.

```julia-repl
julia> m = match(r"(\d+g) .* (\d+ml)", "dissolve 25g sugar in 200ml water")
RegexMatch("25g sugar in 200ml", 1="25g", 2="200ml")

julia> m.captures
2-element Vector{Union{Nothing, SubString{String}}}:
 "25g"
 "200ml"

# how many matches?
julia> length(m.captures)
2

# what matched?
julia> m[1], m[2]
("25g", "200ml")

# Starting positions of the matches (character index)
julia> m.offsets
2-element Vector{Int64}:
 10
 23
```

Of course, matches can fail.
The result will then be the special value `Nothing` instead of a `RegexMatch`, so be ready to test for this.

```julia-repl
# failed match
m = match(r"(not here)", "dissolve 25g sugar in 200ml water")

julia> typeof(m)
Nothing

julia> isnothing(m)
true
```

Though `match` defaults to starting at the begining of the string, we can also specify an offset `n` to ignore the first `n` characters.

```julia-repl
# capture first match
julia> m = match(r"(\wat)", "cat, sat, mat")
RegexMatch("cat", 1="cat")

# ignore first 5 characters, then match
julia> m = match(r"(\wat)", "cat, sat, mat", 5)
RegexMatch("sat", 1="sat")
```

## Replace

One common reason to use a Regex is to replace the match with a different string.

The `replace()` function was discussed in the [`Strings`][strings] Concept, using string literals to search on.
The same function can exploit the full power of Regex matching.

```julia-repl
julia> replace("some string", r"[aeiou]" => "*")
"s*m* str*ng"

julia> replace("first second", r"(\w+) (?<agroup>\w+)" => s"\g<agroup> \1")
"second first"
```

The second example above shows how both numbered and named capture groups can be used in the replacement.

See the [manual][regex] for more details: this is a topic which constantly forces most programmers back to the documentation!



[regex]: https://docs.julialang.org/en/v1/manual/strings/#man-regex-literals
[PCRE]: https://www.pcre.org/current/doc/html/pcre2syntax.html
[strings]: https://exercism.org/tracks/julia/concepts/strings

[regex101]: https://regex101.com/
[regexr]: https://regexr.com/
[regex-info]: https://www.regular-expressions.info/
[rexegg]: https://www.rexegg.com/
[regexone]: https://regexone.com/
