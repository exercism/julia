# Leap on every year that is evenly divisible by 4
# except every year that is evenly divisible by 100
# unless the year is also evenly divisible by 400
is_leap_year(year::Int) = (year % 100 != 0 && year % 4 == 0) || (year % 400 == 0)

