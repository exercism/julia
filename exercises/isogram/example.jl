function is_isogram(s::AbstractString)
    s = lowercase(s)
    chars = Char[]

    for c in s
        isletter(c) || continue
        c ∉ chars ? push!(chars, c) : return false
    end

    return true
end
