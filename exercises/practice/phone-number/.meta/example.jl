function clean(phone_number)
    # Main machinery is in the regex expression.
    NXX = "[2-9][\\d]{2}"
    country = "(?:\\+?1)?"
    area = "\\(?\\s*($NXX)\\s*\\)?"
    exchange = "($NXX)"
    subscriber = "([\\d]{4})"
    fillers = "\\s*(?:\\.|-)?\\s*"
    r = Regex("^\\s*$country$fillers$area$fillers$exchange$fillers$subscriber\\s*\$")

    result = match(r, phone_number)

    if result != nothing
        result = Base.string(result.captures...)
    end

    return result
end
