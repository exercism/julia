# Instructions

You and your business partners operate a small catering company. You've just agreed to run an event for a local cooking club that features "club favorite" dishes. The club is inexperienced in hosting large events, and needs help with organizing, shopping, prepping and serving. You've decided to write some small Julia functions to speed the whole planning process along.

## 1. Clean up Dish Ingredients

The event recipes were added from various sources and their ingredients appear to have duplicate (_or more_) entries — you don't want to end up purchasing excess items!
 Before the shopping and cooking can commence, each dish's ingredient list needs to be "cleaned".

Implement the `clean_ingredients(<dish_name>, <dish_ingredients>)` function that takes the name of a dish and a `vector` of ingredients.
 This function should return a `tuple` with the name of the dish as the first item, followed by the de-duped `set` of ingredients.


```julia-repl
julia> clean_ingredients("Punjabi-Style Chole", ["onions", "tomatoes", "ginger paste", "garlic paste", "ginger paste", "vegetable oil", "bay leaves", "cloves", "cardamom", "cilantro", "peppercorns", "cumin powder", "chickpeas", "coriander powder", "red chili powder", "ground turmeric", "garam masala", "chickpeas", "ginger", "cilantro"])
("Punjabi-Style Chole", Set(["garam masala", "bay leaves", "ground turmeric", "ginger", "garlic paste", "peppercorns", "ginger paste", "red chili powder", "cardamom", "chickpeas", "cumin powder", "vegetable oil", "tomatoes", "coriander powder", "onions", "cilantro", "cloves"]))
```

## 2. Cocktails and Mocktails

The event is going to include both cocktails and "mocktails" - mixed drinks _without_ the alcohol.
You need to ensure that "mocktail" drinks are truly non-alcoholic and the cocktails do indeed _include_ alcohol.

Implement the `check_drinks(<drink_name>, <drink_ingredients>)` function that takes the name of a drink and a `vector` of ingredients.
The function should return the name of the drink followed by "Mocktail" if the drink has no alcoholic ingredients, and drink name followed by "Cocktail" if the drink includes alcohol.
For the purposes of this exercise, cocktails will only include alcohols from the ALCOHOLS constant in `sets_categories_data.jl`:

```julia-repl
julia> include("sets_categories_data.jl");

julia> check_drinks("Honeydew Cucumber", ["honeydew", "coconut water", "mint leaves", "lime juice", "salt", "english cucumber"])
"Honeydew Cucumber Mocktail"

julia> check_drinks("Shirley Tonic", ["cinnamon stick", "scotch", "whole cloves", "ginger", "pomegranate juice", "sugar", "club soda"])
"Shirley Tonic Cocktail"
```

## 3. Categorize Dishes

The guest list includes diners with different dietary needs, and your staff will need to separate the dishes into Vegan, Vegetarian, Paleo, Keto, and Omnivore.

Implement the `categorize_dish(<dish_name>, <dish_ingredients>)` function that takes a dish name and a `set` of that dish's ingredients.
The function should return a string with the `dish name: <CATEGORY>` (_which meal category the dish belongs to_).
All dishes will "fit" into one of the categories found in `sets_categories_data.jl` (VEGAN, VEGETARIAN, PALEO, KETO, or OMNIVORE).

```julia-repl
julia> include("sets_categories_data.jl");

julia> categorize_dish("Sticky Lemon Tofu", Set(["tofu", "soy sauce", "salt", "black pepper", "cornstarch", "vegetable oil", "garlic", "ginger", "water", "vegetable stock", "lemon juice", "lemon zest", "sugar"]))
"Sticky Lemon Tofu: VEGAN"

julia> categorize_dish("Shrimp Bacon and Crispy Chickpea Tacos with Salsa de Guacamole", Set(["shrimp", "bacon", "avocado", "chickpeas", "fresh tortillas", "sea salt", "guajillo chile", "slivered almonds", "olive oil", "butter", "black pepper", "garlic", "onion"]))
"Shrimp Bacon and Crispy Chickpea Tacos with Salsa de Guacamole: OMNIVORE"
```

## 4. Label Allergens and Restricted Foods

Some guests have allergies and additional dietary restrictions.
These ingredients need to be tagged/annotated for each dish so that they don't cause issues.

Implement the `tag_special_ingredients(<dish>)` function that takes a `tuple` with the dish name in the first position, and a `vector` or `set` of ingredients for that dish in the second position.
Return the dish name followed by the `set` of ingredients that require a special note on the dish description.
Dish ingredients inside a `vector` may or may not have duplicates.
 For the purposes of this exercise, all allergens or special ingredients that need to be labeled are in the SPECIAL_INGREDIENTS constant found in `sets_categories_data.py`.

```julia-repl
julia> include("sets_categories_data.jl");

julia> tag_special_ingredients(("Ginger Glazed Tofu Cutlets", ["tofu", "soy sauce", "ginger", "corn starch", "garlic", "brown sugar", "sesame seeds", "lemon juice"]))
("Ginger Glazed Tofu Cutlets", Set(["garlic","soy sauce","tofu"]))

julia> tag_special_ingredients(("Arugula and Roasted Pork Salad", ["pork tenderloin", "arugula", "pears", "blue cheese", "pine nuts", "balsamic vinegar", "onions", "black pepper"
]))
("Arugula and Roasted Pork Salad", Set(["pork tenderloin", "blue cheese", "pine nuts", "onions"]))
```

## 5. Compile a "Master List" of Ingredients

In preparation for ordering and shopping, you'll need to compile a "master list" of ingredients for everything on the menu (_quantities to be filled in later_).

Implement the `compile_ingredients(<dishes>)` function that takes a `vector` of dishes and returns a set of all ingredients in all listed dishes.
Each individual dish is represented by its `set` of ingredients.

```julia-repl
julia> dishes = [Set(["tofu", "soy sauce", "ginger", "corn starch", "garlic", "brown sugar", "sesame seeds", "lemon juice"]), Set(["pork tenderloin", "arugula", "pears", "blue cheese", "pine nuts","balsamic vinegar", "onions", "black pepper"]), Set(["honeydew", "coconut water", "mint leaves", "lime juice", "salt", "english cucumber"])];

julia> compile_ingredients(dishes)
Set(["arugula", "brown sugar", "honeydew", "coconut water", "english cucumber", "balsamic vinegar", "mint leaves", "pears", "pork tenderloin", "ginger", "blue cheese", "soy sauce", "sesame seeds", "black pepper", "garlic", "lime juice", "corn starch", "pine nuts", "lemon juice", "onions", "salt", "tofu"])
```

## 6. Pull out Appetizers for Passing on Trays

The hosts have given you a list of dishes they'd like prepped as "bite-sized" appetizers to be served on trays.
 You need to pull these from the main list of dishes being prepared as larger servings.

Implement the `separate_appetizers(<dishes>, <appetizers>)` function that takes a `vector` of dish names and a `vector` of appetizer names.
The function should return a `vector` with the list of dish names with appetizer names removed.
Either the `<dishes>` or `<appetizers>` `vector` could contain duplicates and may require de-duping.

```julia-repl
julia> dishes = ["Avocado Deviled Eggs","Flank Steak with Chimichurri and Asparagus", "Kingfish Lettuce Cups", "Grilled Flank Steak with Caesar Salad","Vegetarian Khoresh Bademjan","Avocado Deviled Eggs", "Barley Risotto","Kingfish Lettuce Cups"];
          
julia> appetizers = ["Kingfish Lettuce Cups","Avocado Deviled Eggs","Satay Steak Skewers", "Dahi Puri with Black Chickpeas","Avocado Deviled Eggs","Asparagus Puffs", "Asparagus Puffs"];
              
julia> separate_appetizers(dishes, appetizers)
["Vegetarian Khoresh Bademjan", "Barley Risotto", "Flank Steak with Chimichurri and Asparagus", "Grilled Flank Steak with Caesar Salad"]
```

## 7. Find Ingredients Used in Only One Recipe

Within each category (_Vegan, Vegetarian, Paleo, Keto, Omnivore_), you're going to pull out ingredients that appear in only one dish.
These "singleton" ingredients will be assigned a special shopper to ensure they're not forgotten in the rush to get everything else done.

Implement the `singleton_ingredients(<dishes>, <INTERSECTIONS>)` function that takes a `vector` of dishes and a `<CATEGORY>_INTERSECTIONS` constant for the same category.
Each dish is represented by a `set` of its ingredients.
Each `<CATEGORY>_INTERSECTIONS` is a `set` of ingredients that appear in more than one dish in the category.
Using set operations, your function should return a `set` of "singleton" ingredients (_ingredients appearing in only one dish in the category_).

```julia-repl
julia> include("sets_categories_data.jl");

julia> singleton_ingredients(example_dishes, EXAMPLE_INTERSECTION)
Set(["garlic powder", "sunflower oil", "mixed herbs", "cornstarch", "celeriac", "honey", "mushrooms", "bell pepper", "rosemary", "parsley", "lemon", "yeast", "vegetable oil", "vegetable stock", "silken tofu", "tofu", "cashews", "lemon zest", "smoked tofu", "spaghetti", "ginger", "breadcrumbs", "tomatoes", "barley malt", "red pepper flakes", "oregano", "red onion", "fresh basil"])
```
