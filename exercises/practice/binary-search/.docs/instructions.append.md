# Instructions.append

## Behaviour

Your solution should match the behaviour of Julia's built-in `searchsorted` functions for the test cases.
This means that, instead of returning the index of the first matching element that you find in the list, you will return a range whose lower bound is the index of the first matching element in the list and whose upper bound is the index of the last matching element in the list.
However, **to simplify your solution you may assume that the target element is not repeated**, except for the bonus task testset on multiple matches.

If the searched-for item is not in the list you must return an empty range whose lower bound is the index at which the item could be inserted into the sorted list. An empty range is any range where the upper bound is less than the lower bound.

Please read the documenation and examples for the `searchsorted` function for more details:

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

- Extend your solution to support the keyword arguments `by`, `lt` and `rev` so that `by` specifies a
  transformation applied to all elements of the list, `lt` specifies a
  comparison and `rev` specifies if the list is ordered in reverse. When these
  parameters are used you must assume that the list has already been sorted
  using these parameters. See the docs for `sort` for more details.
- Support lists where the target element is repeated (find the first and last index that the target element compares equal to).
