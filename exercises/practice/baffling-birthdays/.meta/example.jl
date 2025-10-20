using Dates

function shared_birthday(birthdates)
    birthdays = [(day(date), month(date)) for date in Date.(birthdates)]
    length(birthdays) > length(unique(birthdays))
end

function random_birthdate()
    randyear = rand(1900:(year(now())))
    no_leaps = isleapyear(randyear) ? randyear - 1 : randyear
    Date(no_leaps, 1, 1) + Day(rand(0:364))
end

random_birthdates(groupsize) = [random_birthdate() for _ in 1:groupsize]

function estimate_probability_of_shared_birthday(groupsize)
    reps = 10_000
    are_shared = [shared_birthday(random_birthdates(groupsize)) for _ in 1:reps]
    (are_shared |> sum |> float) / reps
end
