using Dates

delivery_date(start, description) = "$(delivery_date_time(start, description))"

function delivery_date_time(start, description)
    start_dt = DateTime(start)

    description == "NOW" && return start_dt + Hour(2)

    if description == "ASAP"
        start_day = Date(start_dt)
        return Time(start_dt) < Time(13, 0, 0) ? 
            DateTime(start_day, Time(17, 0, 0)) :
            DateTime(start_day + Day(1), Time(13, 0, 0))
    end

    if description == "EOW"
        day_of_week = dayofweek(start_dt)
        return day_of_week ≤ 3 ?
            DateTime(Date(start_dt + Day(5 - day_of_week)), Time(17, 0, 0)) :
            DateTime(Date(start_dt + Day(7 - day_of_week)), Time(20, 0, 0))
    end
    
    if endswith(description, "M")
        m = parse(Int, chop(description))
        y = month(start_dt) ≥ m ? year(start_dt) + 1 : year(start_dt)
        target = DateTime(y, m, 1, 8, 0, 0)

        return dayofweek(target) ≤ 5 ? target : target + Day(8 - dayofweek(target))
    end

    if startswith(description, "Q")
        q = parse(Int, chop(description, head=1, tail=0))
        current = (month(start_dt) + 2) ÷ 3
        m = (3q + 1) % 12
        rollover = (current > q || q == 4) ? 1 : 0

        due_date = DateTime(year(start_dt) + rollover, m, 1, 8, 0, 0) - Day(1)
        day_of_week = dayofweek(due_date)
        day_of_week ≤ 5 ? due_date : due_date - Day(day_of_week - 5)
    end
end
