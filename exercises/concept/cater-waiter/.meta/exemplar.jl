"""Functions for compiling dishes and ingredients for a catering company."""

include(joinpath(dirname(@__DIR__), "sets_categories_data.jl"))

"""Remove duplicates from `dish_ingredients`.

:param dish_name: String - containing the dish name.
:param dish_ingredients: Vector - dish ingredients.
:return: tuple - containing (dish_name, ingredient set).

This function should return a `Tuple` with the name of the dish as the first item,
followed by the de-duped `Set` of ingredients as the second item.
"""
function clean_ingredients(dish_name, dish_ingredients)
    (dish_name, Set(dish_ingredients))
end

"""Append "Cocktail" (alcohol)  or "Mocktail" (no alcohol) to `drink_name`, based on `drink_ingredients`.

:param drink_name: String - name of the drink.
:param drink_ingredients: Vector - ingredients in the drink.
:return: String - drink_name appended with "Mocktail" or "Cocktail".

The function should return the name of the drink followed by "Mocktail" (non-alcoholic) and drink
name followed by "Cocktail" (includes alcohol).
"""
function check_drinks(drink_name, drink_ingredients)
    drink_name * (isdisjoint(drink_ingredients, ALCOHOLS) ? " Mocktail" : " Cocktail")
end

"""Categorize `dish_name` based on `dish_ingredients`.

:param dish_name: String - dish to be categorized.
:param dish_ingredients: Set - ingredients for the dish.
:return: String - the dish name appended with ": <CATEGORY>".

This function should return a string with the `dish name: <CATEGORY>` (which meal category the dish belongs to).
`<CATEGORY>` can be any one of  (VEGAN, VEGETARIAN, PALEO, KETO, or OMNIVORE).
All dishes will "fit" into one of the categories imported from `sets_categories_data.py`
"""
function categorize_dish(dish_name, dish_ingredients)
    for category in ("VEGAN"=>VEGAN, "VEGETARIAN"=>VEGETARIAN, "PALEO"=>PALEO, "KETO"=>KETO, "OMNIVORE"=>OMNIVORE)
        dish_ingredients ⊆ category.second && return dish_name * ": " * category.first
    end
end

"""Compare `dish` ingredients to `SPECIAL_INGREDIENTS`.

:param dish: Tuple - of (dish name, list of dish ingredients).
:return: Tuple - containing (dish name, dish special ingredients).

Return the dish name followed by the `Set` of ingredients that require a special note on the dish description.
For the purposes of this exercise, all allergens or special ingredients that need to be tracked are in the
SPECIAL_INGREDIENTS constant imported from `sets_categories_data.py`.
"""
function tag_special_ingredients((dish_name, dish_ingredients))
    (dish_name, SPECIAL_INGREDIENTS ∩ dish_ingredients)
end

"""Create a master list of ingredients.

:param dishes: Vector - of dish ingredient sets.
:return: Set - of ingredients compiled from `dishes`.

This function should return a `Set` of all ingredients from all listed dishes.
"""
function compile_ingredients(dishes)
    union(dishes...)
end

"""Determine which `dishes` are designated `appetizers` and remove them.

:param dishes: Vector - of dish names.
:param appetizers: Vector - of appetizer names.
:return: Vector - of dish names that do not appear on appetizer list.

The function should return the vector of dish names with appetizer names removed.
Either vector could contain duplicates and may require de-duping.
"""
function separate_appetizers(dishes, appetizers)
    setdiff(dishes, appetizers)
end

"""Determine which `dishes` have a singleton ingredient (an ingredient that only appears once across dishes).

:param dishes: Vector - of ingredient sets.
:param intersection: constant - can be one of `<CATEGORY>_INTERSECTIONS` constants imported from `sets_categories_data.py`.
:return: Set - containing singleton ingredients.

Each dish is represented by a `Set` of its ingredients.

Each `<CATEGORY>_INTERSECTIONS` is an `intersection` of all dishes in the category. `<CATEGORY>` can be any one of:
    (VEGAN, VEGETARIAN, PALEO, KETO, or OMNIVORE).

The function should return a `Set` of ingredients that only appear in a single dish.
"""
function singleton_ingredients(dishes, intersection)
    setdiff(union(dishes...), intersection)
end
