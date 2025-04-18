const base_speed = 221

function success_rate(speed)
    if speed == 0
        return(0.0)
    end

    if speed <= 4
        return(1.0)
    end

    if speed <= 8
        return(0.9)
    end

    if speed == 9
        return(0.8)
    end

    0.77
end

production_rate_per_hour(speed) = base_speed * speed * success_rate(speed)

working_items_per_minute(speed) = 
    Int(floor(production_rate_per_hour(speed) / 60))

# Experienced programmers may prefer the version below
# However, pipes are only introduced later in the syllabus

# working_items_per_minute(speed) = 
#     production_rate_per_hour(speed) / 60 |> floor |> Int
