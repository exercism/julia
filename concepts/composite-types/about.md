# About

## Composite Types

It is often useful to define custom types in our programs.

Creating new primitive types is possible, but rarely done.
The built-in [primitive types][primitive] are not an arbitrary choice: they closely match the standard types in the LLVM compiler used by Julia for JIT compilation.

Much more useful is the the ability to define [composite types][composite], with named fields.

Other languages have something similar, calling them `structs` or `records`.
The Julia documentation refers to them as `composite types`, though (in a slight mismatch) the language syntax defines them with the `struct` keyword.

```julia-repl
julia> struct Person
           id
           name::String
           age::Integer
       end

julia> fred = Person(23, "Fred Smith", 46)
Person(23, "Fred Smith", 46)

julia> typeof(fred)
Person

julia> isstructtype(Person)
true

julia> isconcretetype(Person)
true

julia> fred.age
46
```

A few points are worth noting in the above example:

- No type is specified for `id`, so the compiler interprets this as `id::Any`.
- The type name is used as a constructor, as in `Person(id, name, age)`, to give an instance of type `Person`.
- Individual fields can be accessed with dot notation, the same as [named tuples][named-tuple].

Items of type `Person` are immutable, so updates are not allowed.

```julia-repl
julia> fred.age += 1
ERROR: setfield!: immutable struct of type Person cannot be changed
```

If mutability is necessary, add `mutable` to the definition.

```julia-repl
julia> mutable struct MutPerson
           name
           age
       end

julia> shaila = MutPerson("Shaila", 23)
MutPerson("Shaila", 23)

julia> shaila.age += 1
24

julia> shaila
MutPerson("Shaila", 24)
```

The constructor, by default, requires the fields to appear in the same order as the definition, which becomes inconvenient for more complicated types.

Using the `@kwdef` macro allows two new capabilities:

- The constructor uses keywords, not position.
- Fields can have default values, and optionally can be omitted from the constructor.

```julia-repl
julia> @kwdef struct KwPerson
           name
           age = 42
       end
KwPerson

julia> suki = KwPerson(age=29, name="Suki")
KwPerson("Suki", 29)

julia> qi = KwPerson(name="Qi")
KwPerson("Qi", 42)

# create a Vector{KwPerson}

julia> friends = [suki, qi]
2-element Vector{KwPerson}:
 KwPerson("Suki", 29)
 KwPerson("Qi", 42)
```

## Composite Type Hierarchies

So far, we have only created concrete composite types.
If you check, all are subtypes of `Any`.

When creating multiple related types, it probably makes more sense to define a hierarchy for them.
This is very easily done.

First, create an abstract type:

```julia-repl
julia> abstract type AbstractPerson end

julia> supertype(AbstractPerson)
Any
```

Next, include a `<:` operator in a type definition, to show the relationship.

```julia-repl
julia> struct ConcretePerson <: AbstractPerson
            id
            name::String
            age::Integer
        end

julia> supertype(ConcretePerson)
AbstractPerson

julia> ConcretePerson(15, "Luis", 8)
ConcretePerson(15, "Luis", 8)
```

Repeat as required, remembering that subtyping of concrete types is not allowed.

For a more complex hierarchy, create abstract subtypes as needed.

```julia-repl
julia> abstract type AdultPerson <: AbstractPerson end

julia> supertype(AdultPerson)
AbstractPerson
```

The value of such a hierarchy will become clearer when we reach the `Multiple Dispatch` Concept, and see how functions handle argument types.


## Inner Constructors

We saw at the beginning of this Concept that the name of the type is used as a constructor, to create items of that type:

```julia-repl
julia> struct Person
           id
           name::String
           age::Integer
       end

julia> fred = Person(23, "Fred Smith", 46)
Person(23, "Fred Smith", 46)
```

Here, `Person()` is known as an `outer constructor`.
Field types will be checked for compatibility with the type definition, and an error raised if necessary.

Suppose we want constraints on the _values_ passed in, not just the _types_?

Then we can include an `inner constructor` within the type definition, to carry out appropriate checks.

For example, we have an abstract type `Point`, intended to take `(x, y)` coordinates, but want a subtype with the constraint `y > x`.

```julia-repl
julia> abstract type Point end

julia> struct ConstrainedPoint <: Point
           x::Integer
           y::Integer
           
           ConstrainedPoint(x, y) =
               y > x ? new(x, y) : @error("require y > x")
       end

julia> ConstrainedPoint(3, 2)
Error: require y > x

julia> ConstrainedPoint(3, 5)
ConstrainedPoint(3, 5)
```

The `new()` function can _only_ be used in inner constructors, and returns the desired item if the inputs are found to be valid.

For invalid input, we could stop with an error message, as in the example.
Alternatively, you may prefer to uses a placeholder such as `nothing` or `missing`.
See the [`Nothingness`][nothingness] Concept for more on these.




[primitive]: https://docs.julialang.org/en/v1/manual/types/#Primitive-Types
[composite-types]: https://docs.julialang.org/en/v1/manual/types/#Composite-Types
[named-tuple]: https://exercism.org/tracks/julia/concepts/tuples
[nothingness]: https://exercism.org/tracks/julia/concepts/nothingness
