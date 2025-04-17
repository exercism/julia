# Hints

All these tasks require the log line to be split into separate parts.

- Check the [`split()`][split] function for options.

## 1. Get message from a log line

- The `split()` function returns a vector of strings.
- You need to get the appropriate element in this vector.
- Leading and trailing whitespace can be removed with [`strip()`][strip].

## 2. Get log level from a log line

- The [`lowercase()`][lowercase] function is useful here.
- An ASCII string can be indexed with a range.
- The `end` index refers to the last element in a vector.
- Alternatively, the task can be solved by using [`replace()`][replace] to remove unwanted characters.

## 3. Reformat a log line

- String [interpolation][interpolation] is perhaps the simplest approach here.
- Alternatively, some people (with experience of other languages) may prefer [`@sprintf()`][sprintf].

[strip]: https://docs.julialang.org/en/v1/base/strings/#Base.strip
[split]: https://docs.julialang.org/en/v1/base/strings/#Base.split
[replace]: https://docs.julialang.org/en/v1/base/collections/#Base.replace-Tuple{Any,%20Vararg{Pair}}
[interpolation]: https://docs.julialang.org/en/v1/manual/strings/#string-interpolation
[sprintf]: https://docs.julialang.org/en/v1/stdlib/Printf/#Printf.@sprintf
[lowercase]: https://docs.julialang.org/en/v1/base/strings/#Base.Unicode.lowercase
