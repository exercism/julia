using Dates

schedule_appointment(appointment::String) = DateTime(appointment, dateformat"m/d/y H:M:S")

has_passed(appointment::DateTime) = appointment < now()

is_afternoon_appointment(appointment::DateTime) = 12 ≤ hour(appointment) < 18

describe(appointment::DateTime) = 
    "You have an appointment on $(Dates.format(appointment, dateformat"E, U d, Y at HH:MM"))"

anniversary_date() = Date(year(now()), 9, 15)
