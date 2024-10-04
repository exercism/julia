# About

This is a _big_ subject!
It is possible to write a long book about it, and several people have done so (search Amazon for "unicode book" to see some examples).

## A very brief history

Handling characters in computers was much simpler in earlier decades, when programmers assumed that English is the only important language.
So: 26 letters, upper and lower case, 10 digits, several punctuation marks, plus a code (0x07) to ring a bell, and it all fitted into 7 bits: the [ASCII][ascii] character set.

Naturally, people started asking what about à, ä and Ł, then other people started asking about ऄ, ஹ and ญ, and young people wanted emojis 😱.
What to do?

To cut a long story short, many smart and patient people had to serve on committees for years, working out the details of the [Unicode][unicode] character set, and of encodings such as [UTF-8][utf-8], and lots of software needed a _very_ complicated rewrite.
Also, lots of new bugs were introduced.

To prevent _everything_ breaking, the Unicode/UTF-8 design ensures that the first 127 codes are identical to ASCII _(even the bell)_.

## Characters in Julia

Languages designed after about 2005 have the huge advantage that a reasonably stable Unicode standard already existed.

Julia (first released 2012) was able to assume that everything would be Unicode: characters, strings, variable and function names, mathematical operators...

To quote the [manual][strings], "Julia makes dealing with plain ASCII text simple and efficient, and handling Unicode is as simple and efficient as possible."
Note the "as possible", it is an important part of the statement.

Character literals are written in single-quotes, and are distinct from strings written in double quotes.

This is obvious to people from the C/C++ world, but potentially confusing to Python and Javascript programmers.

```julia-repl
julia> a = 'a'  # Roman alphabet
'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)

julia> typeof(a)
Char

julia> jha = 'झ'  # Devanagari alphabet
'झ': Unicode U+091D (category Lo: Letter, other)

julia> typeof(jha)
Char
```

We can see from the examples that the type is `Char`, and Julia has further information about the category of character.

Looking closer, it appears that these characters can be represented by 4 hexadecimal digits.
The full character set needs up to 6 hex digits.

These numbers are called "code points", and currently range from U+0000 to U+10FFFF.
 
Converting between `Char` and `Int` is simple:

```julia
julia> Int('a')
97

julia> Char(97)
'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)
```

The compiler allows _some_ forms of integer arithmetic on `Char`s:

```julia-repl
julia> 'b' - 'a'  # interval, in alphabetic order
1

julia> 'b' + 'a'
ERROR: MethodError: no method matching +(::Char, ::Char)

julia> 'a' + 5
'f': ASCII/Unicode U+0066 (category Ll: Letter, lowercase)

julia> 'f' + ('A' - 'a')  # same as `uppercase('f')`
'F': ASCII/Unicode U+0046 (category Lu: Letter, uppercase)
```

## Storage

Everything so far in the document seems relatively simple, so is there really not much to worry about?

Unfortunately, this is too optimistic!

One complication comes from the need for "up to" 6 hex digits per code point.
This means that different characters need different amounts of space in memory when UTF-8 encoded.

Also, not everything that can be displayed on screen has its own unique code point.
Some visually-distinct characters are considered to be derived from others, so Unicode treats them as a parent character plus a modifier.

This issue will become relevant in the Strings concept, when we look at indexing and its challenges.


[ascii]: https://en.wikipedia.org/wiki/ASCII
[unicode]: https://home.unicode.org/
[utf-8]: https://en.wikipedia.org/wiki/UTF-8
[chars]: https://docs.julialang.org/en/v1/manual/strings/#man-characters
[strings]: https://docs.julialang.org/en/v1/manual/strings/
