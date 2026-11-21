function slices(series, slicelength)
    1 <= slicelength <= length(series) || error("Invalid slice length")

    return [series[i:(i+slicelength-1)] for i in 1:(length(series)-slicelength+1)]
end
