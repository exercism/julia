# Hints

Unless you are very confident about your Regex skills, it may help to work out the syntax in an online playground such as [Regex101][regex101].

Remember to set the flavor to PCRE2.

Pre-defining each regular expression as a `const` can be helpful style (for clarity and performance).

## 1. Check Valid Command

- The anchor character for start of string is `^`.
- You only need a true/false from the regex search.

## 2. Remove Encrypted Emojis

- A simple [`replace()][replace].

## 3. Check Valid Phone Number

- Needs a longer, but quiite repetitive Regex.
- `n` consecutive occurences can be specified with `{n}` syntax.
- We only need a true/false for the match.

## 4. Get Website Link

- Remember to escape the dot with `\.`
- Capture the part before the dot in a [match][match].

## 5. Greet the User

- A `replace()` with named captures has the format `r"(?<name>...) " => s"\g<name>... "`
- Again, a `split()` could solve the task, but practicing a Regex is useful.


[startswith]: https://docs.julialang.org/en/v1/base/strings/#Base.startswith
[occursin]: https://docs.julialang.org/en/v1/base/strings/#Base.occursin
[match]: https://docs.julialang.org/en/v1/base/strings/#Base.match
[eachmatch]: https://docs.julialang.org/en/v1/base/strings/#Base.eachmatch
[replace]: https://docs.julialang.org/en/v1/base/strings/#Base.replace-Tuple{IO,%20AbstractString,%20Vararg{Pair}}
[regex101]: https://regex101.com/
