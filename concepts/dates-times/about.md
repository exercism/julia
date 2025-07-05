# About

_"Dates and times are something we teach to young children. How hard can it be?"_

Many programmers have made that mistake, and the subsequent experience tends to have a bad effect on their health and happiness. 

Anyone doing non-trivial programming with dates and times should at least be prepared to understand and mitigate potential problems.

This document will attempt to give an overview of how Julia handles dates and times, but consulting the [manual][Dates] will be necessary for further details.
There is also a [Wikibook][Wikibook] which some readers may find clearer in its explanations, and it includes a helpful [diagram][type-hierarchy] of the type hierarchy.

## The `Dates` module

Most of the basic functionality is in `Dates`, a module which is included in a default installation but is not part of the standard library.

To use the module, there are two options:

1. Add `import Dates`, then preface all function calls with `Dates.`
2. Add `using Dates`, which brings the entire module into the current namespace (_except for a few problem names_).

```julia-repl
# option 1
julia> import Dates

julia> Dates.now()
2025-06-21T16:02:39.080

julia> now()  # wrong: need to include `Dates.` after an import
ERROR: UndefVarError: `now` not defined in `Main`


# option 2
julia> using Dates

julia> now()  # functions are now in the namespace
2025-06-21T16:03:04.161
```

The `Dates` module is big and complicated, but it supplies four main types of functionality:

- `Dates.Date`, which includes day-month-year but no time of day.
- `Dates.Time`, which includes time of day, to nanosecond resolution, but no date.
- `Dates.DateTime`, which combines date and time to millisecond resolution.
- `Dates.Period`, which handles time/date intervals.

Please note that a `DateTime` generally does _not_ include time zone information (Python would call this a "naive" datetime).
One exception is `now()`, which gets local time from your system clock, and can convert this to UTC if required.

Other time zone calculations need the `TimeZones.jl` package, which is not part of a default installation.
As of June 2025, this is not available within Exercism, but may be added in future.

Perhaps the most frequent needs are:

- Parse some appropriate input format to construct a `Dates` type.
- Get the required numerical or string format from a `Dates` type.
- Apply an offset to a `Date`, `Time` or `DateTime` value.
- Calculate the interval between two such values.
- Get the current date (with `today()`) and/or time (with `now()`).

To reduce visual distraction, most of the example code in the rest of this document assumes `using Dates`, and avoids including the module name `Dates.` in function calls.

### Date and time formats

There are many ways to write dates and times, which tend to be culturally-specific.
All-number dates such as "7/6/23" are ambiguous, confusing, and have led to many expensive mistakes in multinational organizations (_the author says this from bitter personal experience_).

The international standard is defined in [`ISO 8601`][ISO8601], with two main advantages:

- Parsing is quick and unambiguous.
- Sorting is easy, as the datetime can be treated as normal text and sorted alphabetically.

We saw in a previous example that `Date.now()` returned `2025-06-21T16:03:04.161`.

This is built up from various parts:

- `YYYY-MM-DD` for the date part.
- `hh:mm:ss` for the time part.
- Optionally, milliseconds (or an even smaller unit) after the decimal point.

Other string formats will be discussed in a later section.

## Dates

`Dates.Date` is a relatively simple date-only type, with no understanding of times or timezones.

```julia-repl
# constructor with year, month, day arguments
julia> date1 = Date(2025, 06, 23)
2025-06-23

# constructor with ISO 8601 string
julia> date2 = Date("2025-06-23")
2025-06-23

julia> date1 == date2
true

julia> typeof(date1)
Date
```

There are accessor functions for individual parts of the date, and these come in pairs distinguished by case.

```julia-repl
# lowercase returns an integer
julia> month(date1)
6

julia> typeof(month(date1))
Int64

# Propercase returns a Period type
julia> Month(date1)
6 months

julia> typeof(Month(date1))
Month

# various compound methods are also available, returning a tuple
julia> monthday(date1)
(6, 23)
```

### Query functions

There are a variety of [query functions][query-func] with some understanding of the calendar.
The next example shows just a few.

```julia-repl
julia> date1
2025-06-23

julia> dayofweek(date1) # 1 = Monday, 7 = Sunday
1

julia> dayname(date1)
"Monday"

julia> daysinmonth(date1)
30

julia> isleapyear(date1)
false

julia> lastdayofmonth(date1)
2025-06-30
```

## Times

`Dates.Time` is the basic time-only type.
It has no understanding of dates: times automatically roll over to `Time(0, 0, 0)` at midnight.

The full constructor format is `Time(hour, min, sec, millisec, microsec)` or the ISO 8601 equivalent.

All the parameters are optional and will default to `0`.

```julia-repl
julia> Time(14, 57, 25, 142)
14:57:25.142

julia> Time("14:57:25.142")
14:57:25.142
```

As with `Date`, individual parts are available with accessor functions:

```julia-repl
julia> minute(t) # => integer
57

julia> Minute(t) # => Period
57 minutes
```

## DateTimes

`Dates.DateTime` combines most of the features of the `Date` and `Time` Types.

It is the most versatile of these three classes, though time resolution is limited to milliseconds (`Time` can resolve to nanoseconds).

```julia-repl
julia> dt1 = DateTime(2025, 6, 23, 14, 57, 25, 142)
2025-06-23T14:57:25.142

# date1 and t were defined in previous examples
julia> dt2 = DateTime(date1, t)
2025-06-23T14:57:25.142
```

The year, month and day parameters default to `1`, time parameters all default to `0`.

Keeping all these parameters straight can be a challenge, so the ISO format may be preferable.

Alternatively, a `DateTime` can be constructed from a `Date` and a `Time`, as in the above example.

## Periods

Each of the date/time components has its own [`Period`][period] type, from `Year` down to `Nanosecond`, representing an interval of time.
These are particularly useful for arithmetic.

```julia-repl
julia> dt1
2025-06-23T14:57:25.142

julia> Year(21)
21 years

julia> Second(61)
61 seconds

julia> dt1 + Year(21) - Second(61)
2046-06-23T14:56:24.142

julia> Date(2025, 07, 03) - Date(2025, 04, 25)
69 days
```

There is also a [`CompoundPeriod`][compound-period] type, which can combine multiple `Period` types.
Oddly, this currently needs the module name to avoid a namespace error (_which feels like a bug_).

```julia-repl
julia> dt1
2025-06-23T14:57:25.142

julia> offset = Dates.CompoundPeriod(Year(21), Second(-61))
21 years, -61 seconds

julia> dt1 + offset
2046-06-23T14:56:24.142
```

When subtracting dates/times, the period will be given in days (for dates) or nanoseconds (for times).
It may be helpful to [`canonicalize`][canonicalize] these to a `CompoundPeriod`.

```julia-repl
julia> diff = Time(23, 14, 00) - Time(1, 23, 52)
78608000000000 nanoseconds

julia> canonicalize(diff)
21 hours, 50 minutes, 8 seconds

julia> typeof(canonicalize(diff))
Dates.CompoundPeriod
```

When working with `Period` types, Julia tries to be smart about calendar irregularities such as month length, rounding as necessary.

```julia-repl
# February has fewer days than January
julia> Date(2025, 1, 31) + Month(1) 
2025-02-28
```

## [Rounding][rounding]

The functions `floor`, `ceil` and `round` should be familiar from integer/floating-point numbers, but also work with dates and times.
Specify the `Period` to round to, as the second argument.

```julia-repl
julia> dt1
2025-06-23T14:57:25.142

julia> floor(dt1, Minute(15))
2025-06-23T14:45:00

julia> ceil(dt1, Minute(30))
2025-06-23T15:00:00

julia> ceil(dt1, Month(1))
2025-07-01T00:00:00
```

## String representations

We previously mentioned the ISO 8601 standard, which is Julia's default date/time representation when formatting or parsing strings.

Obviously, many other formats are in frequent use, often in culturally-specific ways.
To handle these, Julia has the `DateFormat` type, which can be constructed from a format string of arbitrary complexity.

```julia-repl
# dateformat"" string syntax
julia> dtfmt = dateformat"d/m/y"
dateformat"d/m/y"

julia> typeof(dtfmt)
DateFormat{Symbol("d/m/y"), Tuple{Dates.DatePart{'d'}, Dates.Delim{Char, 1}, Dates.DatePart{'m'}, Dates.Delim{Char, 1}, Dates.DatePart{'y'}}}

# DateFormat constructor
julia> DateFormat("d/m/y")
dateformat"d/m/y"
```

The above example is very simple, just a date in the day/month/year format common in Europe.
Two variants on the syntax are shown, but the result is identical.

A `DateFormat` can then be used in parsing any suitable string:

```julia-repl
julia> DateTime("14/7/2023", dtfmt)
2023-07-14T00:00:00
```

Creating a `DateFormat` involves significant overhead, so doing this step just once (as here with `dtfmt`) is helpful for perfomance when looping over many date/time strings.

Formats can be much more complex than this, so see the [manual][dateformat] for details.

Anyone familiar with other languages may notice a family resemblance to the decades-old `strptime` and `strftime` functions.
The Julia version borrows from this legacy, but aims to be more concise and flexible.

The same `DateFormat` can also be used to output a date/time as any desired string format, using the [`Dates.format()`][format] function.

Unfortunately, there seems to be a namespace conflict with `format` (at least as of Julia 1.11.5), so it is best to include the `Dates.` prefix even after `using Dates`.

```julia-repl
julia> dt1
2025-06-23T14:57:25.142

julia> Dates.format(dt1, dateformat"e, u d")
"Mon, Jun 23"
```

Text representation defaults to English.
Other languages can be added, though support for this is currently sub-optimal.


[ISO8601]: https://en.wikipedia.org/wiki/ISO_8601
[Dates]: https://docs.julialang.org/en/v1/stdlib/Dates/
[Wikibook]: https://en.wikibooks.org/wiki/Introducing_Julia/Working_with_dates_and_times
[type-hierarchy]: https://en.wikibooks.org/wiki/Introducing_Julia/Working_with_dates_and_times#/media/File:Julia-time-type-hierarchy.svg
[period]: https://docs.julialang.org/en/v1/stdlib/Dates/#Period-Types
[canonicalize]: https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.canonicalize
[query-func]: https://docs.julialang.org/en/v1/stdlib/Dates/#Query-Functions
[compound-period]: https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.CompoundPeriod
[dateformat]: https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.DateFormat
[format]: https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.format-Tuple{TimeType,%20AbstractString}
[rounding]: https://docs.julialang.org/en/v1/stdlib/Dates/#Rounding
