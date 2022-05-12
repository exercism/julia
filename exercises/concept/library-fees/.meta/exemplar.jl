using Dates

"""
    before_noon(dt)

Return true if the given DateTime is in the forenoon.
"""
before_noon(dt) = Time(dt) < Time(Hour(12))

"""
    return_date(checkout_dt)

Return the return date for a given checkout DateTime.
"""
function return_date(checkout_dt)
    # Make use of booleans being numbers.
    # before_noon(checkout_dt) will be treated as 0 if it's false and as 1 if it's true.
    Date(checkout_dt + Day(28) + Day(!before_noon(checkout_dt)))
end

"""
    days_late(return_dt, actual_return_dt)

Return the number of days that the book was return too late.
"""
function days_late(return_dt, actual_return_dt)
    # If the book was returned before the return date, return 0 days
    actual_return_dt < return_dt && return Day(0)

    ms_to_d = 1000 * 60 * 60 * 24
    Δdt = actual_return_dt - return_dt
    Day(Δdt - (Δdt % ms_to_d))
end

"""
    fee_discount(return_dt)

Return true if the Monday & Tuesday discount should be applied on the day of the given DateTime.
"""
fee_discount(return_dt) = Dates.ismonday(return_dt) || Dates.istuesday(return_dt)

"""
    late_fee(checkout_time, actual_return_time, daily_fee)

Return the total late fee.
"""
function late_fee(checkout_time, actual_return_time, daily_fee)
    return_dt = DateTime(return_date(DateTime(checkout_time)))
    actual_return_dt = DateTime(actual_return_time)

    delay = days_late(return_dt, actual_return_dt)

    floor(daily_fee * Dates.value(delay) * (1 - 0.5 * fee_discount(actual_return_dt)))
end
