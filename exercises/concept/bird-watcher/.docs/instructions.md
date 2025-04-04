# Instructions

You're an avid bird watcher that keeps track of how many birds have visited your garden in the last seven days.

You have six tasks, all dealing with the numbers of birds that visited your garden.

## 1. Check how many birds visited today

Implement the `today()` function to return how many birds visited your garden today. 
The bird counts are ordered by day, with the first element being the count of the oldest day, and the last element being today's count.

```julia-repl
julia> birds_per_day = [2, 5, 0, 7, 4, 1]
julia> today(birds_per_day)
1
```

## 2. Increment today's count

Implement the `increment_todays_count()` function to increment today's count:

```julia-repl
julia> birds_per_day = [2, 5, 0, 7, 4, 1]
julia> increment_todays_count(birds_per_day)
[2, 5, 0, 7, 4, 2]
```

## 3. Check if there was a day with no visiting birds

Implement the `has_day_without_birds()` function that returns `true` if there was a day at which zero birds visited the garden; otherwise, return `false`:

```julia-repl
julia> birds_per_day = [2, 5, 0, 7, 4, 1]
julia> has_day_without_birds(birds_per_day)
true
```

## 4. Calculate the number of visiting birds for the first number of days

Implement the `count_for_first_days()` function that returns the number of birds that have visited your garden from the start of the week, but limit the count to the specified number of days from the start of the week.

```julia-repl
julia> birds_per_day = [2, 5, 0, 7, 4, 1]
julia> count_for_first_days(birds_per_day, 4)
14
```

## 5. Calculate the number of busy days

Some days are busier that others. 
A busy day is one where five or more birds have visited your garden.
Implement the `busy_days()` function to return the number of busy days:

```julia-repl
julia> birds_per_day = [2, 5, 0, 7, 4, 1]
julia> busy_days(birds_per_day)
2
```

## 6. Calculate averages by day of the week

You decide to extend your records by keeping counts for multiple weeks.
In each case, the counts are arranged by day of the week, from Monday as the first entry to Sunday as the last.

Implement the `average_per_day()` function that returns the average for 2 weeks.

```julia-repl
julia> week1 = [7, 2, 9, 1, 3, 0, 10]
julia> week2 = [2, 6, 4, 1, 3, 8, 9]
julia> average_per_day(week1, week2)
[4.5, 4.0, 6.5, 1.0, 4.0, 3.0, 9.5]
```

