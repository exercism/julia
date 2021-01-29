function trinary_to_decimal(str::AbstractString)
    typeof(match(r"^[0-2]+$", str)) == Nothing && return 0
    mapreduce(i->(i[2]-'0')*3^i[1], +, zip(0:length(str), reverse(str)))
end
