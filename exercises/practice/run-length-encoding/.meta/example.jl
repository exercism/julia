function encode(s)
    (length(s) == 0) && (return s)

    count = 0
    for char in s
        (char == s[1]) ? (count += 1) : break
    end
    count_str = (count == 1) ? "" : string(count)
    return string(count_str, s[1], encode(s[count + 1 : end]))
end



function decode(s)
    function expand(count_str, char)
        count = (count_str == "") ? 1 : parse(Int, count_str)
        return char ^ count
    end

    result = ""
    return string((expand(rm.captures...) for rm in eachmatch(r"(\d*)(\D)", s))...)
end
