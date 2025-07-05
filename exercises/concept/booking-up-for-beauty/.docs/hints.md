# Hints

## 1. Parse all-number appointment date

- The constructor will need an appropriate [DateFormat][dateformat].

## 2. Check if an appointment has already passed

- Comparison to the current DateTime is syntactically similar to any numerical comparison.

## 3. Check if appointment is in the afternoon

- Think about what part of the DateTime is useful: _not_ the date, and do the minutes matter?
- Read the instructions to check bounds inclusion/exclusion in the time comparison (mathematically, this is a half-open interval).

## 4. Describe the time and date of the appointment

- The `Dates.format()` method is designed for this.
- Include the `Dates.` part for safety (_apologies, this may be a bug in Julia_).
- Again, you need a [DateFormat][dateformat].

## 5. Return the anniversary date

- What is the current year?
- Build a `Date` for September 15 this year.

[dateformat]: https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.DateFormat
