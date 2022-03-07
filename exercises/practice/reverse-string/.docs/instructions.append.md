# Append
## Bonus

Preserve grapheme clusters, i.e.

```julia
myreverse("hi 👋🏾") == "👋🏾 ih"
myreverse("as⃝df̅") == "f̅ds⃝a"
```

You will probably find the `Unicode` stdlib useful for this bonus task.

To enable the graphemes test, add `const TEST_GRAPHEMES = true` to the global scope of your file.
