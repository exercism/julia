function label(colors::AbstractArray)

    # Set the color-number converter list
    color_key = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

    # Initialize the array that hold the converted numbers
    converted_colors = collect(1:3)

    # For every color, put the converted number in the converted_colors array
    for color_index in 1:3
        converted_colors[color_index] = (findfirst(x -> x == colors[color_index], color_key) - 1)
    end

    # If the second digit ends with zero, end the first two digits at the first digit, and increment the power of ten
    # else, keep the two digits and convert the third number into a power of 10
    if converted_colors[2] == 0
        first_two_digits = converted_colors[1]
        converted_colors[3] += 1
        power_of_ten = 10^converted_colors[3]
    else
        first_two_digits = 10*converted_colors[1] + converted_colors[2]
        power_of_ten = 10^converted_colors[3]
    end

    # If the resistance is an integral multiple of 1000 ohms, write the answer in terms of kiloohms
    # Else, write the answer in terms of ohms
    if power_of_ten >= 1000
        power_of_ten = 10^(converted_colors[3]-3)
        suffix = "kiloohms"
        first_two_digits *= power_of_ten
    else
        first_two_digits *= power_of_ten
        suffix = "ohms"
    end

    # print the final answer with the appropriate suffix
    return ("$first_two_digits" * " " * "$suffix")

end
