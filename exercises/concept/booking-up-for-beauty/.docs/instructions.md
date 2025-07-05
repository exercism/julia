# Instructions

In this exercise you'll be working on an appointment scheduler for a beauty salon in New York that opened on September 15th in 2012.

You have five tasks, which will all involve appointment dates.
Times are in 24-hour clock format (no AM/PM).

## 1. Parse all-number appointment date

Implement the `schedule_appointment()` function to parse a textual representation of an appointment date into the corresponding `DateTime` format.

Note that the input is in U.S.-style month/day/year order.

```julia-repl
julia> schedule_appointment("07/25/2023 13:45:00")
2023-07-25T13:45:00
```

## 2. Check if an appointment has already passed

Implement the `has_passed()` function that takes an appointment date and checks if the appointment was somewhere in the past:

```julia-repl
julia> has_passed(DateTime(1999, 12, 31, 9, 0, 0))
true
```

## 3. Check if appointment is in the afternoon

Implement the `is_afternoon_appointment()` function that takes an appointment date and checks if the appointment is in the afternoon (>= 12:00 and < 18:00):

```julia-repl
julia> is_afternoon_appointment(DateTime(2023, 3, 29, 15, 0, 0))
true
```

## 4. Describe the time and date of the appointment

Implement the `description()` function that takes an appointment date and returns a description of that date and time:

```julia-repl
julia> describe(DateTime(2023, 3, 29, 15, 0, 0))
"You have an appointment on Wednesday, March 29, 2023 at 15:00"
```

## 5. Return the anniversary date

Implement the `anniversary_date()` function that returns this year's anniversary date, which is September 15th:

```julia-repl
julia> anniversary_date()  # run during 2025
2025-09-15
```
