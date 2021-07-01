# Instructions

Your librarian friend has asked you to extend her library software to automatically calculate late fees.
Her current system stores the exact date and time of a book checkout as an [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) datetime string.
She runs a local library in a small town in Ghana, which uses the GMT timezone (UTC +0), doesn't use daylight saving time, and doesn't need to worry about other timezones.

## 1. Determine if a book was checked out before noon

If a book was checked out before noon, the reader has 28 days to return it.
If it was checked out at or after noon, it's 29 days.

Implement the `before_noon` function.
It should take a `DateTime` and return a boolean.

```julia
julia> before_noon(DateTime("2021-01-12T08:23:03"))
true
```

## 2. Calculate the return datetime

Based on the checkout datetime, calculate the return date.

Implement the `return_date` function.
It should take a `DateTime` and return a `Date`, either 28 or 29 days later.

```julia
julia> return_date(DateTime("2020-11-28T15:55:33"))
2020-12-27
```

## 3. Determine how late the return of the book was

The library has a flat rate for late returns.
To be able to calculate the fee, we need to know how many days after the return date the book was actually returned.

Implement the `days_late` function.
It should take two `DateTime`s, the checkout datetime and the datetime when the book was returned.
If the planned return datetime is on an earlier or the same day as the actual return datetime, the function should return 0 days.
Otherwise, the function should return the difference between those two datetimes in days.
If the difference between those two datetimes is not an exact number of days, e.g. 3.5 days, round down to the nearest number of full days.

```julia
julia> days_late(DateTime("2020-12-27T15:55:33"), DateTime("2021-01-03T09:23:36"))
6 days
```

## 4. Determine if the book was returned on a monday or tuesday

The library has a special offer for returning books on Mondays and Tuesdays.

Implement the `fee_discount` function.
It should take a `DateTime` and return a boolean.

```julia
julia> fee_discount(DateTime("2021-01-03T13:30:45"))
false
```

## 5. Calculate the late fee

Implement the `late_fee` function.
It should take three arguments: two ISO8601 datetime strings, checkout datetime and actual return datetime, and the late fee for one day.
It should return the total late fee according to how late the actual return of the book was.

Include the special Monday & Tuesday offer. If you return the book on Monday or Tuesday, your late fee is 50% off, rounded down to the nearest natural number.

```elixir
# Sunday, 7 days late
julia> late_fee("2020-11-28T15:55:33", "2021-01-03T13:30:45", 100)
700.0

# one day later, Monday, 8 days late
julia> late_fee("2020-11-28T15:55:33", "2021-01-04T09:02:11", 100)
400.0
```
