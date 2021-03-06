"""
    is_leap_year(year)

Return if `year` is a leap year in the gregorian calendar.
"""
isleapyear(y) = (y % 4 == 0) && ((y % 100 != 0) || (y % 400 == 0))
