# Hints

## General

- Input for `delivery_date()` is two `String` arguments, and the output is a `String`.
- All date strings are in [ISO 8601][iso] format, Julia's default string representation.
- Useful documentation for the `Dates` module includes:
  - The Exercism [Learning Track][dates-times].
  - The [Julia manual][Dates].
  - The [Wikibook][Wikibook].
- At a minimum, you will need familiarity with [DateTime][datetime] constructors and adding or subtracting [Periods][period].
- Useful functions include [`dayofweek()`][dayofweek] and (optionally) [`lastdayofmonth()`][lastdayofmonth].
- To extract integers from strings, the [`parse()`][parse] function will be important.


[dates-times]: https://exercism.org/tracks/julia/concepts/dates-times
[iso]: https://en.wikipedia.org/wiki/ISO_8601
[Dates]: https://docs.julialang.org/en/v1/stdlib/Dates/
[Wikibook]: https://en.wikibooks.org/wiki/Introducing_Julia/Working_with_dates_and_times
[period]: https://docs.julialang.org/en/v1/stdlib/Dates/#Period-Types
[query-func]: https://docs.julialang.org/en/v1/stdlib/Dates/#Query-Functions
[dayofweek]: https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.dayofweek
[lastdayofmonth]: https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.lastdayofmonth
[datetime]: https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.DateTime-NTuple{7,%20Int64}
[parse]: https://docs.julialang.org/en/v1/base/numbers/#Base.parse
