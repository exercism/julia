using Combinatorics

# A dependency-free alternative to Combinatorics.permutations:
# const perms = [p for p in Iterators.product(ntuple(_ -> 1:5, 5)...) if allunique(p)]

const nations = ["Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese"]
const colors = ["Red", "Green", "Ivory", "Yellow", "Blue"]
const pets = ["Dog", "Snails", "Fox", "Horse", "Zebra"]
const drinks = ["Coffee", "Milk", "Orange", "Tea", "Water"]
const hobbies = ["Dancing", "Reading", "Painting", "Football", "Chess"]

# inverse lookup: property name => its code (1 to 5) within its category
const revlookup = Dict(
    name => num
    for category in (nations, colors, pets, drinks, hobbies)
    for (num, name) in enumerate(category)
)

const perms = collect(permutations(1:5))

# (waterdrinker, zebraowner), filled in by the first call to solve()
const solution = Ref{Union{Nothing,Tuple{String,String}}}(nothing)

drinkswater() = something(solution[], solve())[1]

ownszebra() = something(solution[], solve())[2]

# house number of a property, given a permutation of codes for its category
house(property, perm) = findfirst(==(revlookup[property]), perm)

function solve()
    result = []

    # 10 The Norwegian lives in the first house
    nation_list = [nation for nation in perms if house("Norwegian", nation) == 1]
    for nation in nation_list
        # 2 The Englishman lives in the red house
        # 6 The green house is immediately to the right of the ivory house
        # 15 The Norwegian lives next door to the blue house
        color_list = [color for color in perms if
                      house("Englishman", nation) == house("Red", color) &&
                      house("Green", color) == house("Ivory", color) + 1 &&
                      abs(house("Norwegian", nation) - house("Blue", color)) == 1]
        for color in color_list
            # 4 The person in the green house drinks coffee
            # 5 The Ukrainian drinks tea
            # 9 The person in the middle house drinks milk
            drink_list = [drink for drink in perms if
                          house("Green", color) == house("Coffee", drink) &&
                          house("Ukrainian", nation) == house("Tea", drink) &&
                          house("Milk", drink) == 3]
            for drink in drink_list
                # 3 The Spaniard owns the dog
                animal_list = [animal for animal in perms if
                               house("Spaniard", nation) == house("Dog", animal)]
                for animal in animal_list
                    # 7 The snail owner likes to go dancing
                    # 8 The person in the yellow house is a painter
                    # 11 The person who enjoys reading lives in the house next to the person with the fox
                    # 12 The painter's house is next to the person with the horse
                    # 13 The person who plays football drinks orange juice
                    # 14 The Japanese person plays chess
                    hobby_list = [hobby for hobby in perms if
                                  house("Snails", animal) == house("Dancing", hobby) &&
                                  house("Yellow", color) == house("Painting", hobby) &&
                                  abs(house("Reading", hobby) - house("Fox", animal)) == 1 &&
                                  abs(house("Painting", hobby) - house("Horse", animal)) == 1 &&
                                  house("Football", hobby) == house("Orange", drink) &&
                                  house("Japanese", nation) == house("Chess", hobby)]
                    for hobby in hobby_list
                        push!(result, (nation, color, drink, animal, hobby))
                    end
                end
            end
        end
    end

    @assert length(result) == 1

    nation, _, drink, animal, _ = only(result)
    waterdrinker = nations[nation[house("Water", drink)]]
    zebraowner = nations[nation[house("Zebra", animal)]]
    solution[] = (waterdrinker, zebraowner)
end
