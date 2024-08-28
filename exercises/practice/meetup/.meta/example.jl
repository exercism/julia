using Dates

const week_specifiers = Dict("first" => 1, "second" => 2, "third" => 3, "fourth" => 4, "fifth" => 5)

function meetup(year, month, week, dayofweek)
    currmonth = Date(year, month)
    days = [Date(year, month, d) for d in 1:Dates.daysinmonth(currmonth)]
    valid_dates = [d for d in days if Dates.dayname(d) == dayofweek]

    if week ∈ keys(week_specifiers) && length(valid_dates) ≥ week_specifiers[week]
        return valid_dates[week_specifiers[week]]
    end

    if week == "last"
        return valid_dates[end]
    end

    if week == "teenth"
        teenth = [d for d in valid_dates if 13 <= Dates.day(d) <= 19]
        @assert length(teenth) == 1
        return teenth[1]
    end

    throw(DomainError(week, "That day does not exist"))
end
