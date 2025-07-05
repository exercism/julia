function clean_ingredients(dish_name, dish_ingredients)
    (dish_name, Set(dish_ingredients))
end

function check_drinks(drink_name, drink_ingredients)
    drink_name * (isdisjoint(drink_ingredients, ALCOHOLS) ? " Mocktail" : " Cocktail")
end

function categorize_dish(dish_name, dish_ingredients)
    for category in ("VEGAN"=>VEGAN, "VEGETARIAN"=>VEGETARIAN, "PALEO"=>PALEO, "KETO"=>KETO, "OMNIVORE"=>OMNIVORE)
        dish_ingredients ⊆ category.second && return dish_name * ": " * category.first
    end
end

function tag_special_ingredients((dish_name, dish_ingredients))
    (dish_name, SPECIAL_INGREDIENTS ∩ dish_ingredients)
end

function compile_ingredients(dishes)
    union(dishes...)
end

function separate_appetizers(dishes, appetizers)
    setdiff(dishes, appetizers)
end

function singleton_ingredients(dishes, intersection)
    setdiff(union(dishes...), intersection)
end
