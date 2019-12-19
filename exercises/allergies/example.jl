all = [
    "eggs",
    "peanuts",
    "shellfish",
    "strawberries",
    "tomatoes",
    "chocolate",
    "pollen",
    "cats",
]

function allergic_to(score, allergen)
    return (score & (1 << (findfirst(x -> x==allergen, all) - 1)) ) != 0
end

function allergy_list(score)
    return filter(allergen -> allergic_to(score, allergen), all)
end
