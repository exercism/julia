# If the number has 3 as a factor, output 'Pling'.
# If the number has 5 as a factor, output 'Plang'.
# If the number has 7 as a factor, output 'Plong'.
# If the number does not have 3, 5, or 7 as a factor, just pass the number's digits straight through.

function raindrops(number::Int)
    drops = []
    number % 3 == 0 && push!(drops, "Pling")
    number % 5 == 0 && push!(drops, "Plang")
    number % 7 == 0 && push!(drops, "Plong")
    if size(drops, 1) == 0
      repr(number)
    else
      join(drops)
    end
end
