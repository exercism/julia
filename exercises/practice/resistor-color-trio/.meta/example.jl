function label(colors)
    @assert length(colors) ≥ 3
    mapping = Dict(zip(["black","brown","red","orange","yellow","green","blue","violet","grey","white"], 0:9))
    prefix = [" "," kilo"," mega"," giga"]
    num = 10mapping[colors[1]] + mapping[colors[2]]
    num = mapping[colors[3]] % 3 == 2 ? num / 10 : num * 10^(mapping[colors[3]] % 3)
    "$(isinteger(num) ? Int(num) : num)" * prefix[(mapping[colors[3]] + 1)÷3 + 1] * "ohms"
end
