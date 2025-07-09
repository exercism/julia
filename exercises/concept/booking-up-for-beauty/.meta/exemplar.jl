using Dates

const dtfm_schedule = dateformat"m/d/y H:M:S"
schedule_appointment(appointment::String) = DateTime(appointment, dtfm_schedule)

has_passed(appointment::DateTime) = appointment < now()

is_afternoon_appointment(appointment::DateTime) = 12 ≤ hour(appointment) < 18

const dtfm_desc = dateformat"E, U d, Y at HH:MM"
describe(appointment::DateTime) = "You have an appointment on " * Dates.format(appointment, dtfm_desc)

anniversary_date() = Date(year(now()), 9, 15)
