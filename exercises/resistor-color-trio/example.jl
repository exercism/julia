function label(colors::AbstractArray)

    # Set the color-number converter list
    colorKey = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

    # Initialize the array that hold the converted numbers
    convertedColors = collect(1:3)

    # For every color, put the converted number in the convertedColors array
    for colorIndex in 1:3
        convertedColors[colorIndex] = (findfirst(x -> x == colors[colorIndex], colorKey) - 1)
    end

    # If the second digit ends with zero, end the first two digits at the first digit, and increment the power of ten
    # else, keep the two digits and convert the third number into a power of 10
    if convertedColors[2] == 0
        firstTwoDigits = convertedColors[1]
        convertedColors[3] += 1
        powerOfTen = 10^convertedColors[3]
    else
        firstTwoDigits = 10*convertedColors[1] + convertedColors[2]
        powerOfTen = 10^convertedColors[3]
    end

    # If the resistance is an integral multiple of 1000 ohms, write the answer in terms of kiloohms
    # Else, write the answer in terms of ohms
    if powerOfTen >= 1000
        powerOfTen = 10^(convertedColors[3]-3)
        suffix = "kiloohms"
        firstTwoDigits *= powerOfTen
    else
        firstTwoDigits *= powerOfTen
        suffix = "ohms"
    end

    # print the final anwer with the appropriate suffix
    return ("$firstTwoDigits" * " " * "$suffix")

end