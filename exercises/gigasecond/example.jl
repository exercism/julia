using Dates

add_gigasecond(date::DateTime) = date + Dates.Second(10^9)
