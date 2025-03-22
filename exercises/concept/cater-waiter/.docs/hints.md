# Hints

## General

- [Sets][sets] are mutable, unordered collections with no duplicate elements.
- Sets can contain any data type.
- Sets are [iterable][iterable].
- Sets are most often used to quickly dedupe other collections or for membership testing.
- Sets also support mathematical operations like `union`, `intersection`, `difference`, and `symmetric difference`

## 1. Clean up Dish Ingredients

- The `set()` constructor can take any [iterable][iterable] as an argument. Vectors are iterable.
- Remember: Tuples can be formed using `(<element_1>, <element_2>)`.

## 2. Cocktails and Mocktails

- A `Set` is _disjoint_ from another set if the two sets share no elements.
- The `Set()` constructor can take any [iterable][iterable] as an argument. Vectors are iterable.
- Strings can be concatenated with the `*` sign and interpolation can be done via `$()`.

## 3. Categorize Dishes

- Using loops to iterate through the available meal categories might be useful here.
- If all the elements of `<set_1>` are contained within `<set_2>`, then `<set_1> ⊆ <set_2>`.
- The method equivalent of `⊆` is `issubset(<set>, <iterable>)`
- Tuples can contain any data type, including other tuples.  Tuples can be formed using `(<element_1>, <element_2>)`.
- Elements within Tuples can be accessed from the left using a 1-based index number, or from the right using an `end`-based index number (e.g. `<tuple>[end]`).
- The `Set()` constructor can take any [iterable][iterable] as an argument. Vectors are iterable.
- Strings can be concatenated with the `*` sign and interpolation can be done via `$()`.

## 4. Label Allergens and Restricted Foods

- A set _intersection_ are the elements shared between `<set_1>` and `<set_2>`.
- The set method equivalent of `∩` is `intersect(<set>, <iterable>)` or `∩(<set>, <iterable>)`.
- Elements within Tuples can be accessed from the left using a 1-based index number, or from the right using an `end`-based index number (e.g. `<tuple>[end]`).
- The `Set()` constructor can take any [iterable][iterable] as an argument. Vectors are iterable.
- Tuples can be formed using `(<element_1>, <element_2>)`.

## 5. Compile a "Master List" of Ingredients

- A set _union_ is where elements of `<set_1`> and `<set_2>` are combined into a single `set`
- The set method equivalent of `∪` is `union(<set>, <iterable>)` or `∪(<set>, <iterable>)`
- Using loops to iterate through the various dishes might be useful here.

## 6. Pull out Appetizers for Passing on Trays

- A set _difference_ is where the elements of  `<set_2>`  are removed from `<set_1>`, e.g. `setdiff(<set_1>, <set_2>)`.
- The `Set()` constructor can take any [iterable][iterable] as an argument. Vectors are iterable.
- The Vector constructor can take any [iterable][iterable] as an argument. Sets are iterable.

## 7. Find Ingredients Used in Only One Recipe

- A set _symmetric difference_ is where  elements appear in `<set_1>` or `<set_2>`, but not **_both_** sets.
- A set _symmetric difference_ is the same as subtracting the `set` _intersection_ from the `set` _union_, e.g. `setdiff(<set_1> ∪ <set_2>, <set_1> ∩ <set_2>)`
- A _symmetric difference_ of more than two `Sets` will include elements that are repeated more than two times across the input `Sets`.  To remove these cross-set repeated elements, the _intersections_ between set pairs needs to be subtracted from the symmetric difference.
- Using looops to iterate through the various dishes might be useful here.


[iterable]: https://docs.julialang.org/en/v1/base/collections/#Iterable-Collections
[sets]: https://docs.julialang.org/en/v1/base/collections/#Base.Set
