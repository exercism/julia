# Instructions append

## Bonus

You might like to use this exercise as an excuse to experiment with [non-standard string literals][nssl].
A short introduction to non-standard string literals can be found in this [blog post][nssl-blog].

To pass the bonus tests, define a macro `rna_str` as explained in the links above, then your users could write code like this:

```julia
rna"AUGUGU" == ["Methionine", "Cysteine"]

rna"""
AUGUUUUCUUAAAUG
""" == ["Methionine", "Phenylalanine", "Serine"]
```

[nssl]: https://docs.julialang.org/en/v1/manual/metaprogramming/#meta-non-standard-string-literals
[nssl-blog]: https://web.archive.org/web/20170625222109/https://iaindunning.com/blog/julia-unicode.html
