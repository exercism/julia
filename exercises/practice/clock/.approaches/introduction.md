# Introduction

## General guidance

- Prefer to use `Dates.value(m)` rather than `m.value` because fields are generally considered private in Julia. Defining an API in terms of functions makes it much easier for other structs to implement your interface or for you to refactor your stuff. You can import the `value` function from Dates with `using Dates: value` to use it without a prefix.
- `lpad` is totally fine, but if you're already familiar with the `printf` language from C or elsewhere, you might like to take a look at the `Printf` stdlib

## Complexities to watch out for!

- If you're storing a field for both hours and minutes then
  the trickiest case is when minutes are less than and not a multiple of 60 (e.g. -61).
  Students often end up doing something quite convoluted to solve this.
- Students often use `%` or `rem` and a subtraction when `mod` is probably what they want
- Your humble correspondent thinks that this is best solved by converting the hours to minutes, as is done in the first approach below

## Technique: defining subtraction

You can define the subtraction in terms of unary negation of a `Minute` and addition, like this:

```julia
-(c::Clock, m::Minute) = c + -m
```

## Simplest approach: work in minutes.

OTDE's solution defines a struct with only one field, `min`, which records the number of minutes since midnight.

This approach is obvious once you've thought about it, but many experienced programmers submit solutions where they record minutes and hours as separate fields within `Clock` and this makes their constructor a lot more complex than it needs to be.

```julia
using Dates
using Dates: value

struct Clock
    min::Int
    Clock(min) = new(mod(min, 60 * 24))
end

Clock(hour, min) = Clock(hour * 60 + min)

Base.:(+)(c::Clock, min::Minute) = Clock(c.min + value(min))
Base.:(-)(c::Clock, min::Minute) = Clock(c.min - value(min))

Base.show(io::IO, c::Clock) = print(io, '"', lpad(c.min ÷ 60, 2, '0'), ':', lpad(mod(c.min, 60), 2, '0'), '"')
```

<details>
<summary>A more complete solution in the same style</summary>

A similar solution by cmcaine includes a docstring; defines `Dates.minute` and `Dates.hour` for their `Clock` type; and uses those methods and `Printf.@printf` in their `show` method.

```julia
import Base: show, +, -
import Dates: Minute, hour, minute, value

using Printf: @printf

"""
    Clock(hours, mins)
    Clock(mins_since_midnight)

An instance of time at minute resolution somewhere between midnight and one minute before midnight.
"""
struct Clock
    mins::Int32
    Clock(mins) = new(mod(mins, 60 * 24))
end

Clock(hours, mins) = Clock(hours * 60 + mins)

hour(c::Clock) = div(c.mins, 60)
minute(c::Clock) = mod(c.mins, 60)

+(c::Clock, m::Minute) = Clock(c.mins + value(m))
-(c::Clock, m::Minute) = c + -m

show(io::IO, c::Clock) = @printf(io, "\"%02d:%02d\"", hour(c), minute(c))
```

</details>

## Approach with `Bool` arithmetic

ScottPJones does some arithmetic with `Bool`s below. This works because `Bool`s are also integers (true == 1, false == 0).

```julia
using Dates: Minute, value

struct Clock
    h::UInt8
    m::UInt8
    Clock(h, m) = new(mod(h - (m < 0 && m % 60 != 0) + div(m, 60), 24), mod(m, 60))
end

Base.:+(x::Clock, y::Clock) = Clock(x.h + y.h + (x.m + x.m >= 60), x.m + y.m)

function Base.:+(x::Clock, y::Minute)
    h, m = divrem(value(y), 60)
    Clock(x.h + h, x.m + m)
end

Base.:-(x::Clock, y::Minute) = x + Minute(-value(y))

Base.show(io::IO, x::Clock) = print(io, '"', lpad(x.h, 2, '0'), ':', lpad(x.m, 2, '0'), '"')
```

## Approach using `@printf`

dbalman's solution, using three mods and using `@printf` rather than `lpad`:

```julia
import Dates: Minute, value
using Printf: @printf

struct Clock
  hour::UInt8
  minute::UInt8
  Clock(hour, minute) =
    new(mod(hour + (minute - mod(minute, 60)) ÷ 60, 24),
        mod(minute, 60))
end

Base.:+(clock::Clock, minutes::Minute) =
  Clock(clock.hour, clock.minute + value(minutes))

Base.:-(clock::Clock, minutes::Minute) =
  Clock(clock.hour, clock.minute - value(minutes))

Base.show(io::IO, clock::Clock) =
  @printf(io, "\"%02d:%02d\"", clock.hour, clock.minute)
```

## Approach with floor division

bovine3dom's solution which avoids the subtraction in dbalman's solution by using floor division:

```julia
import Dates
struct Clock
    hours::Int8
    minutes::Int8
    Clock(h,m) = new(rem(h + div(m,60,RoundDown),24,RoundDown),rem(m,60,RoundDown))
end

Base.:+(c::Clock,m::Dates.Minute) = Clock(c.hours, c.minutes + value(m))
Base.:-(c::Clock,m::Dates.Minute) = Clock(c.hours, c.minutes - value(m))
Base.:+(c::Clock,h::Dates.Hour) = Clock(c.hours + value(h), c.minutes)
Base.:-(c::Clock,h::Dates.Hour) = Clock(c.hours - value(h), c.minutes)

Base.show(io::IO, c::Clock) = print(io, '"', lpad(c.hours,2,'0'), ":", lpad(c.minutes,2,'0'), '"')
```
