# Sets


A [set][type-set] is a _mutable_ and _unordered_ collection of objects.
Set members must be distinct — duplicate items are not allowed.
They can hold multiple different data types and even nested structures like a `tuple` of `tuples` or `vector` of `vectors`.

Sets are most commonly used to quickly remove duplicates from other data structures or item groupings.
They are also used for efficient comparisons when sequencing and duplicate tracking are not needed.

Like other collection types (_dictionaries, vectors, tuples_), `sets` support:
- Iteration via `for item in <set>`
- Membership checking via `in` or `∈`, and `not in` or `∉`,
- Length calculation through `length()`, and
- Shallow copies through `copy()`

`sets` do not support:
- Indexing of any kind
- Ordering via sorting or insertion
- Slicing


Checking membership in a `set` has constant time complexity (on average) versus checking membership in a `list` or `string`, where the time complexity grows as the length of the data increases.
Methods such as `union(<set>, <iterable>)`, `intersect(<set>, <iterable>)`, or `setdiff(<set>, <iterable>)` also have constant time complexity (on average).


## Set Literals

A `set` can be directly entered as a _set literal_ with the `Set(<iterable>)` constructor.
Duplicates are silently omitted:

```julia-repl
julia> one_element = Set('😀')
Set{Char} with 1 element:
  '😀'

julia> multiple_elements = Set(['😀', '😃', '😄', '😁'])
Set{Char} with 4 elements:
  '😁'
  '😃'
  '😀'
  '😄'

julia> multiple_duplicates =  Set(["Hello!", "Hello!", "Hello!", 
                            "¡Hola!","Привіт!", "こんにちは！", 
                            "¡Hola!","Привіт!", "こんにちは！"])
Set{String} with 4 elements:
  "こんにちは！"
  "¡Hola!"
  "Привіт!"
  "Hello!"
```

You can also use `Set()` to create an empty `set`.


## The Set Constructor

`Set()` (_the constructor for the `set` class_) can be used with any `iterable` passed as an argument.
Elements of the `iterable` are cycled through and added to the `set` individually.
Element order is not preserved and duplicates are silently omitted:

```julia-repl
# To create an empty set, the constructor is used without input.
julia> no_elements = Set()
Set{Any}()

# The tuple is unpacked & each element is added.  
# Duplicates are removed.
>>> elements_from_tuple = Set(("Parrot", "Bird", 
                               334782, "Bird", "Parrot"))
Set(["Parrot", 334782, "Bird"])

# The vector is unpacked & each element is added.
# Duplicates are removed.
>>> elements_from_list = Set([2, 3, 2, 3, 3, 3, 5, 
                              7, 11, 7, 11, 13, 13])
Set([5, 7, 13, 2, 11, 3])
```

### Gotchas when Creating Sets

Due to its "unpacking" behavior, using `Set()` with a string might be surprising:

```julia-repl
# String elements (Unicode code points) are 
# iterated through and added *individually*.
>>> elements_string = Set("Timbuktu")
Set(['i', 'u', 'k', 't', 'm', 'T', 'b'])


# Unicode separators and positioning code points 
# are also added *individually*.
>>> multiple_code_points_string = Set("अभ्यास")
Set(['अ', 'भ', 'य', 'ा', '्', 'स'])
```

Unlike some other languagues, Julia allows mutable collections to be hashed. This can cause some unwanted behavior if one mutates a element of a set since the original hash value will no longer map to the item in that hash slot.

```julia-repl
julia> array1 = ['😅','🤣'];
julia> set1 = Set([array1, ['😂','🙂','🙃'], ['😜', '🤪', '😝']]);

julia> ['😅','🤣'] ∈ set1
true

julia> array1  ∈ set1
true

julia> pop!(array1);

julia> array1
['😅']

julia> set1
Set([['😅'], ['😂', '🙂', '🙃'], ['😜', '🤪', '😝']])

julia> ['😅'] ∈ set1
false

julia> ['😅','🤣'] ∈ set1
false

julia> array1 ∈ set1
false
```

## Working with Sets

Sets have methods that generally mimic [mathematical set operations][mathematical-sets].
Most (_not all_) of these methods have an [operator][operator] equivalent.
Methods and operators generally take any `iterable` as an argument.


### Disjoint Sets

The `isdisjoint(<set>, <other_collection>)` method is used to test if a `sets` elements have any overlap with the elements of another `set`.
The method will accept any `iterable` or `set` as an argument.
It will return `True` if the two sets have **no elements in common**, `False` if elements are **shared**.


```julia-repl
# Both mammals and additional_animals are vectors.
julia> mammals = ["squirrel","dog","cat","cow", "tiger", "elephant"];
julia> additional_animals = ["pangolin", "panda", "parrot", 
                             "lemur", "tiger", "pangolin"];

# Animals is a dict.
julia> animals = Dict("chicken" => "white",
                      "sparrow" => "gray",
                      "eagle" => "brown and white",
                      "albatross" => "gray and white",
                      "crow" => "black",
                      "elephant" => "gray", 
                      "dog" => "rust",
                      "cow" => "black and white",
                      "tiger" => "orange and black",
                      "cat" => "gray",
                      "squirrel" => "black");
               
# Birds is a set.
julia> birds = Set(["crow","sparrow","eagle","chicken", "albatross"]);

# Mammals and birds don't share any elements.
julia> isdisjoint(birds, mammals)
true

# There are also no shared elements between 
# additional_animals and birds.
julia> isdisjoint(birds, additional_animals)
true

# Animals and mammals have shared elements.
# **Note** The objects need to be comparable, so the dictionary `animals` can't be compared
# directly to  vector `mammals`, since the former is make up of pairs, while the latter is
# made up of strings. We can use the keys or values of the dictionary though.
julia> isdisjoint(keys(animals), mammals)
false
```


### Subsets

`issubset(<set>, <other_collection>)` is used to check if every element in `<set>` is also in `<other_collection>`.
The operator form is `<set> ⊆ <other_set>`:


```julia-repl
# Both mammals and additional_animals are vectors.
julia> mammals = ["squirrel","dog","cat","cow","tiger","elephant"];
julia> additional_animals = ["pangolin", "panda", "parrot", 
                             "lemur", "tiger", "pangolin"];

# Animals is a dict.
julia> animals = Dict("chicken" => "white",
                      "sparrow" => "gray",
                      "eagle" => "brown and white",
                      "albatross" => "gray and white",
                      "crow" => "black",
                      "elephant" => "gray", 
                      "dog" => "rust",
                      "cow" => "black and white",
                      "tiger" => "orange and black",
                      "cat" => "gray",
                      "squirrel" => "black");

# Birds is a set.
julia> birds = Set(["crow","sparrow","eagle","chicken","albatross"]);

# Set methods will take any iterable as an argument.
# All members of birds are also members of animals.
julia> issubset(birds, animals)
true

# All members of mammals also appear in animals.
julia> issubset(mammals, animals)
true

# We can also use the set operator
julia> birds ⊆ mammals
false

# A set is always a loose subset of itself.
>>> set(additional_animals) ⊆ set(additional_animals)
true
```

There is also an operator `<set> ⊊ <other collection>` which checks if `<set>` is a subset of `<other collection>` without being equal to it (i.e. .a "proper subset")

### Set Intersections

`intersect(<set>, <other iterables>...)` returns a new `set` with elements common to the original `set` and all `<others>` (_in other words, the `set` where everything [intersects][intersection]_).
The operator version of this method is `<set> ∩ <other set> ∩ <other set 2> ∩ ... ∩ <other set n>`:

There is also an `intersect!(<set>, <other iterables>...)` form which overwrites `<set>` with the result of the intersection.

```julia-repl
julia> perennials = Set(["Annatto","Asafetida","Asparagus","Azalea",
                         "Winter Savory", "Broccoli","Curry Leaf","Fennel",
                         "Kaffir Lime","Kale","Lavender","Mint","Oranges",
                         "Oregano", "Tarragon", "Wild Bergamot"]);

julia> annuals = Set(["Corn", "Zucchini", "Sweet Peas", "Marjoram",
                      "Summer Squash", "Okra","Shallots", "Basil",
                      "Cilantro", "Cumin", "Sunflower", "Chervil",
                      "Summer Savory"]);

julia> herbs = ["Annatto","Asafetida","Basil","Chervil","Cilantro",
                "Curry Leaf","Fennel","Kaffir Lime","Lavender",
                "Marjoram","Mint","Oregano","Summer Savory",
                "Tarragon","Wild Bergamot","Wild Celery",
                "Winter Savory"];


# Methods will take any iterable as an argument.
julia> perennial_herbs = intersect(perennials, herbs)
Set(["Annatto", "Asafetida", "Curry Leaf", "Fennel", "Kaffir Lime",
     "Lavender", "Mint", "Oregano", "Wild Bergamot","Winter Savory"])

# Operators work with any collection.
julia> annuals ∩ herbs
 Set(["Basil", "Chervil", "Marjoram", "Cilantro"])
```


### Set Unions

`union(<set>, <other iterables>...)` returns a new `set` with elements from `<set>` and all `<other iterables>`.
The operator form of this method is `<set> ∪ <other set 1> ∪ <other set 2> ∪ ... ∪ <other set n>`:

There is also a `union!(<set>, <other iterables>...)` form which overwrites `<set>` with the result of the union.

```julia-repl
julia> perennials = Set(["Asparagus", "Broccoli", "Sweet Potato", "Kale"]);
julia> annuals = Set(["Corn", "Zucchini", "Sweet Peas", "Summer Squash"]);
julia> more_perennials = ["Radicchio", "Rhubarb", "Spinach", "Watercress"];

# Methods will take any iterable as an argument.
>>> union(perenials, more_perennials)
Set(["Asparagus","Broccoli","Kale","Radicchio","Rhubarb",
"Spinach","Sweet Potato","Watercress"])
```


### Set Differences

`setdiff(<set>, <other iterables>...)` returns a new `set` with elements from the original `<set>` that are not in `<others>`.
There is also a `setdiff!(<set>, <other iterables>...)` form which overwrites `<set>` with the result of the set difference.

```julia-repl
julia> berries_and_veggies = Set(["Asparagus",
                                  "Broccoli",
                                  "Watercress",
                                  "Goji Berries",
                                  "Goose Berries",
                                  "Ramps",
                                  "Walking Onions",
                                  "Blackberries",
                                  "Strawberries",
                                  "Rhubarb",
                                  "Kale",
                                  "Artichokes",
                                  "Currants"]);

julia> veggies = ("Asparagus", "Broccoli", "Watercress", "Ramps",
                  "Walking Onions", "Rhubarb", "Kale", "Artichokes")

# Methods will take any iterable as an argument.
julia> berries = setdiff(berries_and_veggies, veggies)
Set(["Blackberries","Currants","Goji Berries",
     "Goose Berries", "Strawberries"])
```


# Set Symmetric Difference

`symdiff(<set>, <other iterable>...)` returns a new `set` that contains elements that are in `<set>` OR `<other>`, **but not in both**.

There is also a `symdiff!(<set>, <other iterable>...)` which overwrites `<set>` with the result of the symmetric difference.


```julia-repl
julia> plants_1 = Set(['🌲','🍈','🌵', '🥑','🌴', '🥭']);
julia> plants_2 = ('🌸','🌴', '🌺', '🌲', '🌻', '🌵');


# Methods will take any iterable as an argument.
>>> fruit_and_flowers = symdiff(plants_1, plants_2)
>>> fruit_and_flowers
Set(['🌸', '🌺', '🍈', '🥑', '🥭','🌻' ])
```

~~~~exercism/note

A symmetric difference of more than two sets will result in a `set` that includes both the elements unique to each `set` AND elements shared between more than two sets in the series (_details in the Wikipedia article on [symmetric difference][symmetric_difference]_).  

To obtain only items unique to each `set` in the series, intersections between all 2-set combinations need to be aggregated in a separate step, and removed:  


```julia-repl
julia> one = Set(["black pepper","breadcrumbs","celeriac","chickpea flour",
                  "flour","lemon","parsley","salt","soy sauce",
                  "sunflower oil","water"]);

julia> two = Set(["black pepper","cornstarch","garlic","ginger",
                  "lemon juice","lemon zest","salt","soy sauce","sugar",
                  "tofu","vegetable oil","vegetable stock","water"]);

julia> three = Set(["black pepper","garlic","lemon juice","mixed herbs",
                    "nutritional yeast", "olive oil","salt","silken tofu",
                    "smoked tofu","soy sauce","spaghetti","turmeric"]);

julia> four = Set(["barley malt","bell pepper","cashews","flour",
                   "fresh basil","garlic","garlic powder", "honey",
                   "mushrooms","nutritional yeast","olive oil","oregano",
                   "red onion", "red pepper flakes","rosemary","salt",
                   "sugar","tomatoes","water","yeast"]);

julia> intersections = (one ∩ two ∪ one ∩ three ∪ one ∩ four ∪ 
                     two ∩ three ∪ two ∩ four ∪ three ∩ four)
...
Set(["black pepper","flour","garlic","lemon juice","nutritional yeast", 
"olive oil","salt","soy sauce", "sugar","water"])

# The symdiff method will include some of the items in intersections, 
# which means it is not a "clean" symmetric difference - there
# are overlapping members.
julia> symdiff(one, two, three, four) ∩ intersections
Set(["black pepper", "garlic", "soy sauce", "water"])

# Overlapping members need to be removed in a separate step
# when there are more than two sets that need symmetric difference.
julia> setdiff(symdiff(one, two, three, four), intersections)
...
Set(["barley malt","bell pepper","breadcrumbs", "cashews","celeriac",
     "chickpea flour","cornstarch","fresh basil", "garlic powder",
     "ginger","honey","lemon","lemon zest","mixed herbs","mushrooms",
     "oregano","parsley","red onion","red pepper flakes","rosemary",
     "silken tofu","smoked tofu","spaghetti","sunflower oil", "tofu", 
     "tomatoes","turmeric","vegetable oil","vegetable stock","yeast"])
```

[symmetric_difference]: https://en.wikipedia.org/wiki/Symmetric_difference
~~~~

[intersection]: https://www.mathgoodies.com/lessons/sets/intersection
[mathematical-sets]: https://en.wikipedia.org/wiki/Set_theory#Basic_concepts_and_notation
[operator]: https://www.computerhope.com/jargon/o/operator.htm
[type-set]: https://docs.julialang.org/en/v1/base/collections/#Base.Set
