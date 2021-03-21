"""
    canibuy(vehicle, price, monthly_budget)

Return a message describing if you can afford the monthly payments on a given vehicle.
"""
function canibuy(vehicle, price, monthly_budget)
    if price / 60 < monthly_budget
        "Yes! I'm getting a $vehicle."
    elseif price / 60 > monthly_budget + 10
        "Damn! No $vehicle for me."
    else
        "I'll have to be frugal if I want a $vehicle."
    end
end

"""
    licence(vehicle, kind)

Return a message that describes if `vehicle` requires a licence to operate based on its `kind`.
"""
function licence(vehicle, kind)
    s = kind == "car" ? "a" : "no"
    "The $vehicle requires $s licence to operate."
end

"""
    fee(msrp, age, kind)

Return the registration fee for a given vehicle.
"""
function fee(msrp, age, kind)
    kind == "bike" && return 0
    age >= 10 && return 25

    value = max(msrp, 25000)
    percent = 1 - age / 10
    
    return value * percent / 100
end
