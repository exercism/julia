# Introduction

## Specification

The specification of this exercise has changed several times, slightly changing what counts as a word.

All of the solutions on this page are essentially correct (and depending on your point of view you may think them more correct than the specification!), but they were written for varying versions of the specification and will count some words that the current specification excludes.

If you'd like to challenge your bug-hunting skills, perhaps read through the solutions and the specification and see if you can find the mismatches!

<details>
<summary>Answers</summary>

At the time of writing, "Approach: Find each word with regex" matches the specification exactly, but other solutions match some words excluded by the specification.

- Words containing a mix of numbers and letters (e.g. "x220")
- Double contractions: words containing more than one apostrophe (e.g. "y'ain't", "wouldn't've")
- Words containing non-ascii letters or numerals (e.g. "café")
    - This one is a bit subtle for solutions using regex because unlike regex in most other languages, the character classes in Julia's regexes (e.g. `\w`) are inclusive of non-ascii characters.
      You can read more about this behaviour by searching for `PCRE_UCP` in the [PCRE library's documentation](https://www.pcre.org/original/doc/html/pcreunicode.html).

</details>

## Suggested docstring

The details of what is and is not a word are a bit complicated and subjective.
It is good practice to include a docstring in this kind of situation to document what your function is supposed to be doing.

Here's an example docstring, whether it is appropriate for your solution will depend on exactly what your solution treats as a word.

````julia
"""
    wordcount(input)

Find the frequency of each word in the input.
Words can contain letters, numbers and apostrophes (for contractions like "don't").

Words will be normalised by converting them to lowercase.

## Example

```jldoctest
julia> wordcount("Joe can't tell between 'large' and large.")
Dict{String,Int64} with 6 entries:
  "tell"    => 1
  "can't"   => 1
  "large"   => 2
  "joe"     => 1
  "between" => 1
  "and"     => 1

julia> wordcount("Co-operative")
Dict{String,Int64} with 6 entries:
  "co"    => 1
  "operative"   => 1
```
"""
````

## Regex

Many solutions on this page use "regex".
Regex is a widely used language for describing patterns in strings.
If you'd like to learn it, check out [regexone](https://regexone.com/).

In Julia, `r"foo"` constructs a `Regex` object using the `@r_str` macro.
It is similar to writing `Regex(raw"foo")`, but with the benefit that the regex object will be constructed just once (at compile time) rather than on each call to e.g. `wordcount`.

## Approach: Find each word with regex

This is a straightforward algorithm and it is easy to prove that it follows the specification exactly.
Implementations that split by whitespace and punctuation (see below) tend to count words that the specification does not ask for, e.g. "x1".
You can view that as a good thing or a bad thing!
For what it is worth, traditional word counting code like `wc` treat a mix of letters and digits as a word.

```julia
function wordcount(input)
    counts = Dict{String, Int}()
    # Unicode version matching any letters or numbers: r"\pL+'\pL+|\pL+|\pN+"
    for m in eachmatch(r"[A-Za-z]+'[A-Za-z]+|[A-Za-z]+|[0-9]+", input)
        word = lowercase(m.match)
        counts[word] = get(counts, word, 0) + 1
    end
    return counts
end
```

Same as above, but we lowercase `input` all in one go, so we can have a `Dict` of `SubString`s, which might be slightly faster or more appropriate for some situations.

```julia
function wordcount(input)
    counts = Dict{SubString{typeof(input)}, Int}()
    # Unicode version matching any letters or numbers: r"\pL+'\pL+|\pL+|\pN+"
    for m in eachmatch(r"[A-Za-z]+'[A-Za-z]+|[A-Za-z]+|[0-9]+", lowercase(input))
        word = m.match
        counts[word] = get(counts, word, 0) + 1
    end
    return counts
end
```

~~~~exercism/advanced

A dict of substrings like this could be a performance problem sometimes. Can you work out why?

<details>
<summary>Answer</summary>

A `SubString` is a view into another string, which means that the original string cannot be garbage collected while the `SubString` is still in use. In the solution above, we make a lowercase copy of the input string which Julia will then have to keep in memory until the last `SubString` derived from it becomes unreachable.

If we called `wordcount(document)` on several large documents then this would usually lead to a lot more memory use than a `Dict{String, Int}` would have used.
If the total volume of text is large enough, this could make a big difference to the performance of your program.

This pattern is worth remembering whenever you're using or thinking of using `SubString`s or `view`s.

</details>

~~~~

It's possible to create the dictionary more efficiently with the `countmap` function from `StatsBase`. With `countmap`, you can code-golf the above into:

```julia
using StatsBase: countmap

wordcount(str) = countmap(m.match for m in eachmatch(r"[A-Za-z]+'[A-Za-z]+|[A-Za-z]+|[0-9]+", lowercase(str)))
```

`countmap` cheekily uses some implementation details of `Dict` to perform `counts[w] = get(counts, w, 0) + 1` faster than we can (specifically, `countmap` will hash `w` only once).

## Approach: Split, then strip quotation

If we split the input on any character that can't be a word, then we might think that we will only be left with words and words that are surrounded by apostrophes.
This solution follows that approach.

```julia
function wordcount(input)
    words = split(input, r"[^\w']+")
    counts = Dict{String, Int}()
    for word in words
        # Removing leading and closing apostrophes (might be quotation)
        word = lowercase(strip(word, '''))
        if !isempty(word)
            counts[word] = get(counts, word, 0) + 1
        end
    end
    return counts
end
```

This solution uses a regex, but you could equally do something like:

```julia
split(input, c -> !(isletter(c) || isdigit(c) || c == '''); keepempty=false)
```

`keepempty` tells `split` not to include empty strings in its output, which is helpful because the filter function tests a single character at a time, whereas the regex version can match many characters at once.
This matters if the input can contain long runs of non-word characters.

## Approach: Finding boundaries manually

This method iterates through the string one character at a time looking for word boundaries.

This solution is a lot more complicated and a little quicker than the other approaches.

```julia
function wordcount(str)
    counts = Dict{typeof(str)}, Int}()
    iswordchar(c) = 'a' ≤ c ≤ 'z' || 'A' ≤ c ≤ 'Z' || isdigit(c)
    # To support more non-ascii words, you could use this instead:
    # iswordchar(c) = isletter(c) || isnumeric(c)

    in_word = false
    prev = 0
    lastind = lastindex(str)
    for i in eachindex(str)
        c = str[i]
        # if `c` is a word character and we're not already in a word,
        # then this character marks the start of a new word. If we are
        # in a word, continue iterating.
        if iswordchar(c)
            if !in_word
                in_word = true
                prev = i
            end
        # If `c` is not a word character, but we are in a word, then the
        # previous character might mark the end of a word.
        elseif in_word
            # If `c` is an apostrophe then check if it marks a contraction
            if c == ''' && i ≠ lastind && iswordchar(str[nextind(str, i)])
                continue
            # Otherwise, record the word
            else
                in_word = false
                word = lowercase(SubString(str, prev:prevind(str, i)))
                counts[word] = get(counts, word, 0) + 1
            end
        end
    end
    # If the last character was a word char, then its word will not have been
    # counted. So we count it here.
    if in_word
        word = lowercase(SubString(str, prev:lastind))
        counts[word] = get(counts, word, 0) + 1
    end

    return counts
end
```

We use `eachindex`, `nextind` and `prevind` because strings in Julia are not guaranteed to have numerically consecutive indexes.
Here's an example:

```julia-repl
# The index after 1 is not always 2:
julia> nextind("Ünited Stätes Toughens Image With Umlauts", 1)
3
```

This happens because the default String type encodes strings as UTF-8 and indexes by byte, not by character.

This solution uses `SubString` to make only one copy of each part of the string that it converts to lowercase.

## Approach: Removing non-contraction apostrophes

This solution uses some clever matching to find apostrophes that aren't contractions, then splits.
It's important to match word boundaries because otherwise the code doesn't handle apostrophes at the start or end of the string correctly.
Inspired by mentoring [rezaeir's solution](https://exercism.org/tracks/julia/exercises/word-count/solutions/rezaeir).

If you don't know what a "word-boundary" is in regex,
[this stack overflow post might help](https://stackoverflow.com/questions/4541573/what-are-non-word-boundary-in-regex-b-compared-to-word-boundary)
(Note, though that character classes in Julia regexes include unicode characters by default. e.g. `\w` matches `[\pL\pN_]`: all characters that are letters or numbers, and underscore.
You can read more about this behaviour by searching for `PCRE_UCP` in the [PCRE library's documentation](https://www.pcre.org/original/doc/html/pcreunicode.html)).

```julia
function wordcount(sentence)
    # ' can be used inside a contracted word or for
    # quotation. We want to remove all ' that are not
    # used in words.
    #
    # Remove all ' that have a non-word-boundary on
    # at least one side.
    sentence = replace(sentence, r"'\B|\B'" => "")

    # Split into lowercase words:
    words = split(lowercase(sentence), r"[^\w']+", keepempty=false)

    counts = Dict{eltype(words), Int}()
    for word in words
        counts[word] = get(counts, word, 0) + 1
    end

    return counts
end
```
