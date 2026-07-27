line_up(name, number) = 
    "$name, you are the $number$(ending(number)) customer we serve today. Thank you!"

function ending(number)
    number % 100 ∈ (11, 12, 13) && return "th"
    last_digit = number % 10
    last_digit ∈ (1, 2, 3) && return ("st", "nd", "rd")[last_digit]
    "th"
end
