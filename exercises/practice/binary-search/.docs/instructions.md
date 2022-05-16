# Instructions

Implement a binary search algorithm.

Searching a sorted collection is a common task. A dictionary is a sorted
list of word definitions. Given a word, one can find its definition. A
telephone book is a sorted list of people's names, addresses, and
telephone numbers. Knowing someone's name allows one to quickly find
their telephone number and address.

If the list to be searched contains more than a few items (a dozen, say)
a binary search will require far fewer comparisons than a linear search,
but it imposes the requirement that the list be sorted.

In computer science, a binary search or half-interval search algorithm
finds the position of a specified input value (the search "key") within
an array sorted by key value.

In each step, the algorithm compares the search key value with the key
value of the middle element of the array.

If the keys match, then a matching element has been found and the range of
indices that equal the search key value are returned.
This matches Julia's built-in `searchsorted` functions.
However, **to simplify your solution you may assume that the target element is
not repeated**, except for the bonus task testset on multiple matches.

Otherwise, if the search key is less than the middle element's key, then
the algorithm repeats its action on the sub-array to the left of the
middle element or, if the search key is greater, on the sub-array to the
right.

If the remaining array to be searched is empty, then the key cannot be
found in the array and a special "not found" indication is returned.
For this exercise, you must do as Julia's built-in `searchsorted` functions do
and return an empty range located at the insertion point, see the docs for
`searchsorted` below for examples.

A binary search halves the number of items to search with each iteration,
so locating an item (or determining its absence) takes logarithmic time.

## Documentation for Julia's `searchsorted` function:

```
searchsorted(a, x; by=<transform>, lt=<comparison>, rev=false)

Return the range of indices of a which compare as equal to x (using binary
search) according to the order specified by the by, lt and rev keywords,
assuming that a is already sorted in that order. 
Return an empty range located at the insertion point if a does not contain
values equal to x.

See also: insorted, searchsortedfirst, sort, findall.

Examples

julia> searchsorted([1, 2, 4, 5, 5, 7], 4) # single match
3:3

julia> searchsorted([1, 2, 4, 5, 5, 7], 5) # multiple matches
4:5

julia> searchsorted([1, 2, 4, 5, 5, 7], 3) # no match, insert in the middle
3:2

julia> searchsorted([1, 2, 4, 5, 5, 7], 9) # no match, insert at end
7:6

julia> searchsorted([1, 2, 4, 5, 5, 7], 0) # no match, insert at start
1:0
```

## Bonus tasks

- Implement keyword arguments `by`, `lt` and `rev` so that `by` specifies a
  transformation applied to all elements of the list, `lt` specifies a
  comparison and `rev` specifies if the list is ordered in reverse. When these
  parameters are used you must assume that the list has already been sorted
  using these parameters. See the docs for `sort` for more details.
- Implement a solution that works on lists with non-unique elements.
