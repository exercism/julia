# About

What is "Linear Algebra"?

There are plenty of technical definitions, on [Wikipedia][linalg-wiki], in textbooks and on excellent websites such as [3blue1brown][3blue1brown], but for our purposes we can be more informal.

~~~~exercism/note
Linear Algebra is about lots of interesting (and very useful) things you can do with Vectors and Matrices.
~~~~

The Julia (and Python) maintainers love this sort of thing. 
Exercism management, not so much.

This document will be restricted to the simpler aspects of a huge subject, but be warned: _this is, inevitably, quite a mathematical concept_.

## What is a Vector?

It depends who you ask, and how you want to visualize something rather abstract.

- In Julia, `Vector{T}` is just an alias for `Array{T, 1}`, and the `eltype` `T` can be anything.
- In (much of) Physics, a vector is an arrow with a `length` and `direction` in N-dimensional space, but no fixed position.
- In Linear Algebra, the physicists' arrow is fixed in space, with its tail at the origin. This makes the shaft of the arrow redundant, so we can represent the vector as a `point` in N-dimensional space, with the `N` elements representing distance from the origin along each of the `N` axes.

For present purposes, ignore vectors of strings or characters.
We will be working with numerical types: Int, Float, or Complex.

## What is a matrix?

Again, you will find a variety of answers.

- A rectangular 2-D array of numbers _(with no ragged edges)_. A square matrix is a common special case.
- A linear combination of column vectors, stacked side by side.
- A `transformation` that can be applied to a vector, just as a `function` is applied to other input types.

Some types of square matrix are common enough to have [special names][special-matrices].

***Diagonal matrix:*** All non-zero entries are on the `main diagonal` (top-left to bottom-right).

```julia-repl
julia> [1 0 0; 0 2 0; 0 0 3]
3×3 Matrix{Int64}:
 1  0  0
 0  2  0
 0  0  3
```

***Identity matrix:*** A diagonal matrix with only ones on the diagonal (for reasons that will become clearer later).

***Upper triangular:*** Non-zero values on and above the diagonal, zeros below.
***Lower triangular*** you can guess.

## Transposing a matrix

If you really want to swap rows with columns, the function [`permutedims()`][permutedims] will do this and give you a new matrix.

This involves copying, whish is slow and memory-hungry when working with large matrices.

For Linear Algebra purposes, the [`transpose()`][transpose] function is more useful, as it quickly creates a lazy wrapper around the original matrix.

Even more useful is the [`adjoint()`][adjoint] function, which flips the sign of the imaginary part in any complex numbers (if you wonder why, the quick answer is Quantum Mechanics).
This operation is common enough that we can just add an apostrophe `'` to the variable name to create the adjoint.

```julia-repl
julia> m
2×3 Matrix{Int64}:
 1  2  3
 4  5  6

# new, full copy
julia> permutedims(m)
3×2 Matrix{Int64}:
 1  4
 2  5
 3  6

# lazy version
julia> transpose(m)
3×2 transpose(::Matrix{Int64}) with eltype Int64:
 1  4
 2  5
 3  6

julia> mc = [1+2im 2+3im; 3+2im 1+2im]
2×2 Matrix{Complex{Int64}}:
 1+2im  2+3im
 3+2im  1+2im

# lazy conjugate transpose
julia> adjoint(mc)
2×2 adjoint(::Matrix{Complex{Int64}}) with eltype Complex{Int64}:
 1-2im  3-2im
 2-3im  1-2im

# syntactic sugar for adjoint
julia> mc'
2×2 adjoint(::Matrix{Complex{Int64}}) with eltype Complex{Int64}:
 1-2im  3-2im
 2-3im  1-2im
```

## Multiplication

The rest of this document includes functionalty from the `LinearAlgebra` module.
A `using LinearAlgebra` line will bring it into the namespace, but we will not keep repeating this in the examples (too much visual clutter).

### Vectors, element-wise product

This was discussed in the [Vector Operations][vector-ops] Concept.
The operator is `.*`, which operates on the input vectors pair-wise, giving an output the same size and type as the inputs.

```julia-repl
julia> [1, 2] .* [3, 4]
2-element Vector{Int64}:
 3
 8
```

### Vectors, dot product

This extremely common operation is written in textbooks as `u ⋅ v`, and called the "dot" product.

The raised (_center_) dot is available in Julia (entered `\cdot` tab) as syntactic sugar for the `dot()` function.

A dot product is equivalent to the _sum_ of the element-wise product, as in the example below.

Also, two vectors can be multiplied with the usual `*` operator, but only if the left vector is an `adjoint`: conveniently written `u' * v`.
This should become clearer in the later section on matrix multiplication.

```julia-repl
julia> using LinearAlgebra

# with dot()
julia> dot([1, 2], [3, 4])
11

# with \cdot syntax
julia> [1, 2] ⋅ [3, 4]
11

# with element-wise syntax
julia> sum([1, 2] .* [3, 4])
11

# with u' * v syntax
julia> [1, 2]' * [3, 4]
11
```

For complex-valued vectors, the left vector needs to be the conjugate (sign flipped).
The `dot` function does this automatically, the `u'` syntax does it explicitly, but `sum(u .* v)` will fail if `u` and `v` are complex.

### Vectors, cross product

_A bit of nostalgia for anyone who has taken an Electricity and Magnetism course in the past!
Also, engineers familiar with calculating torque or angular momentum vectors._

Whereas the dot product converts two vectors to a `scalar`, the cross product converts two 3-vectors to a third 3-vector.

In the geometric representation of the vector space, the new vector is _perpendicular_ the the plane containing the two input vectors.
If the two inputs are parallel (up to a sign), they do not define a plane, so the output will be `[0, 0, 0]`.

Order matters: `u × v == -(v × u)`.
This is the famous [Right-Hand Rule][rhr], which has left many of us staring at our thumb and two fingers as we twisted them around in space (_with a puzzled expression_).

```julia-repl
# with \times syntax
julia> [1, 2, 3] × [3, 4, 5]
3-element Vector{Int64}:
 -2
  4
 -2

# with cross()
julia> cross([1, 2, 3], [3, 4, 5])
3-element Vector{Int64}:
 -2
  4
 -2
```

Notice that this operation is restricted to length-3 vectors (equivalent to Euclidian space with orthogonal `x, y, z` axes).
Mathematicians are happy to define the operation for other dimensions, with higher-order tensors as the result.
_Most of us run away or quickly change the subject at that point!_

### Norms

_How "big" is a vector?_

The `norm` is an attempt to capture this, by reducing the vector to an appropriate scalar.

A whole family of norms are defined, but by far the most common is the 2-norm, which is `√(v ⋅ v)`.

This root-mean-square operation is the _Pythagorean distance_ from the origin (in N-dimensional space).
If we visualize the vector as an arrow, with its tail at the origin, the 2-norm is the _length_ of the arrow.

Any p-norm can be calculated by providing `p` as the 2nd argument.
The 1-norm is sometimes useful: it is simply the sum of the entries (so very quick and easy to calculate).

```julia-repl
# defaults to the 2-norm
julia> norm([1, 2, 3])
3.7416573867739413

# the 1-norm
julia> norm([1, 2, 3], 1)
6.0
```

### Matrix multiplication

It sometimes seems as though every applied mathematician in the world has spent much of the last 80 years turning every calculation into a series of matrix multiplications.

This is an operation that computers are very good at: 

- It is highly repetitive.
- It can be parallelized efficiently.
- A lot of specialized hardware has been developed to make it faster, from the $80 million [Cray-1][cray] in the 1970's to the GPU that is probably integrated into your laptop.

The details are fairly simple, though not very intuitive at first sight.

Consider a matrix `A` multiplying a vector `v` to give an output `w` (by Linear algebra convention, we will uses uppercase letters for matrices, lowercase for vectors).

The top row of `A` is dotted with `v` to get the first element of `w`, the second row gives the second element, and so on down.

```julia-repl
julia> A = [1 2; 3 4]
2×2 Matrix{Int64}:
 1  2
 3  4

julia> v = [5, 6]
2-element Vector{Int64}:
 5
 6

julia> A * v
2-element Vector{Int64}:
 17  # equals [1, 2] ⋅ [5, 6]
 39  # equals [3, 4] ⋅ [5, 6]
```

A matrix * matrix multiplication extends this across the columns of the matrix on the right.

For `A * B = C`, the first row of `A` is dotted with each column of `B` to give the top row of `C`, the second row gives the second row, and so on down.

```julia-repl
julia> A
2×2 Matrix{Int64}:
 1  2
 3  4

julia> B = [5 7; 6 8]
2×2 Matrix{Int64}:
 5  7
 6  8

# left column is the same as A*v previously
julia> A * B
2×2 Matrix{Int64}:
 17  23
 39  53

julia> B * A
2×2 Matrix{Int64}:
 26  38
 30  44
```

As shown in the example above, matrix multiplication _does not commute_: there is no simple relationship between `A*B` and `B*A`.
0
This is probably hard to visualize for anyone new to it, just by reading the words.
YouTube has lots of videos demonstrating it graphically, so search for "matrix multiplication" and choose one with yourr preferred style, detail level and language.

### Dimensions

The dot product of two vectors relies on them having equal length.

By extension, for matrix multiplication the _rows_ of the left matrix must match the _columns_ of the right matrix.

Expressing the sizes as `(nrows, ncols)` tuples, as output by `size(A)`, we have `(a, b) * (b, c) -> (a, c)`.
The "inner" dimensions, here `b` and `b`, are compatible with taking dot products.
The "outer" dimensions, here `a` and `c`, determine the dimensions of the output.

An example with rectangular matrices:

```julia-repl
julia> D = reshape(1:6, 2, 3)
2×3 reshape(::UnitRange{Int64}, 2, 3) with eltype Int64:
 1  3  5
 2  4  6

julia> E = reshape(1:12, 3, 4)
3×4 reshape(::UnitRange{Int64}, 3, 4) with eltype Int64:
 1  4  7  10
 2  5  8  11
 3  6  9  12

julia> D * E
2×4 Matrix{Int64}:
 22  49   76  103
 28  64  100  136

# (3, 4) * (2, 3) not possible
julia> E * D
ERROR: DimensionMismatch: matrix A has axes (Base.OneTo(3),Base.OneTo(4)), matrix B has axes (Base.OneTo(2),Base.OneTo(3))
```

Multiplying pairs of vectors, natrix-style, has two possibilities.

Conventionally, we would use `u' * v` as an equivalent to the dot product.
The dimensions are `(1, 3) * (3, 1)`, and Julia simplifies the `(1, 1)` output to a scalar (unlike, for example, R).

Alternatively, we could use `u * v'`, with dimensions `(3, 1) * (1, 3) -> (3, 3)`, to multiply all possible pairs of elements and expand the vectors to a matrix.

```julia-repl
julia> u = [1, 2]
2-element Vector{Int64}:
 1
 2

julia> v = [3, 4]
2-element Vector{Int64}:
 3
 4

julia> u' * v
11

julia> u * v'
2×2 Matrix{Int64}:
 3  4
 6  8
```

`u' * v` is sometimes called the _inner product_.

The (less common) `u * v'` is correspondingly the _outer product_.
This is related to the [tensor product][tensor-prod], though that is beyond our scope.

### Rotations

One particularly common type of matrix multiplication involves [rotation matrices][rotmat].

In 2D, there is a relatively simple matrix to rotate a vector anti-clockwise by `θ` radians.

```julia-repl
julia> rot2d(θ, vec) = [cos(θ) -sin(θ); sin(θ) cos(θ)] * vec
rot2d (generic function with 1 method)

# unit vector in the x direction
julia> i_hat = [1, 0]
2-element Vector{Int64}:
 1
 0

# rotate 45 degrees
julia> rot2d(π/4, i_hat)
2-element Vector{Float64}:
 0.7071067811865476
 0.7071067811865475

# rotate 90 degrees -> unit vector in the y direction, j_hat
julia> rot2d(π/2, i_hat)
2-element Vector{Float64}:
 6.123233995736766e-17  # zero, within numerical error
 1.0
```

Rotations in 3D need a more complex matrix, with two angles.
This is hard to dispay in a Markdown document without embedding a lot of LaTeX, so check [Wikipedia][3d-rot] for the formula.

For 3-D graphics, such as OpenGL and its successors, the convention is to work with [Homogeneous Coordinates][homogeneous].

Each vertex is represented by a 4-vector (or equivalently a matrix column): `[x, y, z, 1.0]` for a point at `(x, y, z)`.

This enables more elaborate transformation matrices.
The rotation is still at `A[1:3, 1:3]`, translations are `[Δx, Δy, Δz]` at `A[1:3, 4]`, scaling is on the diagonal, and other possibilities exist for skew, perspective, etc.

### Performance

In CS departments around the world, there are many PhD theses with one or more chapters on small, incremental improvements in algorithms for matrix multiplication.
This is _really_ important, and various organizations are willing to fund the research for their own benefit.

Performance is a big topic that we can't get deep into, but for illustration we can try multiplying random matrices of various sizes.

The code below is a quick-and-dirty estimate (use [BenchmarkTools.jl][benchmark] for a better approach).

The system used was a small $430 (US) PC: Ryzen 9 processor, 32GB RAM, Linux Mint 22.1, Julia 1.11.6.

```julia-repl
julia> mmul(A) = A * A
mmul (generic function with 1 method)

julia> A = rand(Float64, 1_000, 1_000);

julia> @time mmul(A);
  0.011055 seconds (3 allocations: 7.629 MiB)

julia> A = rand(Float64, 10_000, 10_000);

julia> @time mmul(A);
  7.236284 seconds (1.61 k allocations: 763.027 MiB, 17.92% gc time, 0.15% compilation time)
```

Roughly, a pair of million-element matrices took a few milliseconds, 100-million-element matrices took a few seconds.
_Adding several more order of magnitude will need better hardware..._

## Systems of linear equations

Remember when you first learned algebra, back in High School?

Typically, we would be given a system of equations, and asked to solve for `x` and `y`.

```
4x - 3y = -2
2x + 7y = 16
```

Two equations, two unknowns: a bit of substitution, and you can soon see that `x = 1, y = 2`.

Now suppose you have 1000 equations in 100 unknowns?
If that sounds silly, remember that wireless digital transducers are now cheap and versatile (measure strain, wind speed, 3-axis acceleration, whatever...).
Having 1000 of them monitoring a modern structure like a suspension bridge is perfectly reasonable.
There needs to be a control system interpreting the data stream, ready to signal an alert if things get alarming.

Look again at the left side of the previous example.
It looks like a matrix `[4 -3; 2 7]` multiplying an unknown vector `[x, y]` to give the vector `[-2, 16]`.

In Linear Algebra notation: **A** **x** = **b**, where we have **A** (from the engineering design) and **b** (measured values from the transducers) but need to find **x**.

A first thought, for anyone unfamiliar with this, is to somehow "divide through by **A**" to move it to the RHS.

In fact, **A** has an inverse (most but not all square matrices do), and the calculation works (_slowly!_).

```julia-repl
julia> A = [4 -3; 2 7]
2×2 Matrix{Int64}:
 4  -3
 2   7

julia> b = [-2, 16]
2-element Vector{Int64}:
 -2
 16

# the inverse matrix
julia> inv(A)
2×2 Matrix{Float64}:
  0.205882   0.0882353
 -0.0588235  0.117647

julia> inv(A) * b
2-element Vector{Float64}:
 0.9999999999999999
 2.0
```

Unfortunately, calculating the inverse is slow for small matrices and glacial for large ones.
Not ideal, if your bridge collapses during the calculation!

Fortunately, other algorithms are dramatically faster (in this case [Gaussian elimination][gaussian-elim]).

Julia (copying Matlab) just uses a backslash for the solver (technically, "left division").

```julia-repl
julia> x = A \ b
2-element Vector{Float64}:
 1.0
 2.0
```

This is a trivial example, but there are a few details to watch out for.

- The coefficients need to line up in columns, so insert zeros as needed for missing terms.
- The equations (and hence the matrix rows) need to be [linearly independent][indep]. If row 3 is just the sum of rows 1 and 2, it adds no new information and the problem is under-determined.

The [`rank()`][rank] command will give the number of linearly independent rows/columns, so aim for this to equal the number of unknown variables.

```julia-repl
julia> rank(A)
2
```

### Rectangular matrices

Sometine as a pre-teen, you were probably taught that you need a system of `N` equations to solve for `N` unknowns.

As with most things in mathematics, the reality is a bit more nuanced (not just the linear-independence detail, mentioned in the previous section).

#### "Too few" rows

With `N-1` equations (rows in the matrix `A`), the problem is under-determined.
Do we give up in despair?

It depends!

The `N-1` equations still contain a lot of information.
In geometrical terms, we need `N` to determine the solution as a _point_ in N-dimensional space, but `N-1` will tell us that the solution must lie somewhere on a _line_.

This leaves us with an infinite number of solutions, but also an infinite amount of parameter space with _no_ solutions.

Does your line of solutions pass through a region of parameter space that a reputable engineer should worry about?
Or that could justify closing the structure to public access (_suspension bridges can get lively in strong crosswinds_)?
Maybe it is worth doing some more calculations to determine that!

```julia-repl
julia> A3 = [4 -3 1; 2 2 2; 3 -4 -3]
3×3 Matrix{Int64}:
 4  -3   1
 2   2   2
 3  -4  -3

julia> b3 = [1, 12, -14]
3-element Vector{Int64}:
   1
  12
 -14

# fully-determined solution
julia> A3 \ b3
3-element Vector{Float64}:
 1.0
 2.0
 3.0

# remove row 3 from A3 and B3
julia> A2 = A3[1:2, :]
2×3 Matrix{Int64}:
 4  -3  1
 2   2  2

julia> b2 = b3[1:2]
2-element Vector{Int64}:
  1
 12

# an under-determined solution
julia> z1 = A2 \ b2
3-element Vector{Float64}:
 1.594594594594594
 2.445945945945947
 1.9594594594594592
```

The backslash solver gives us a solution!
[Unofficially][underdet], this is apparently the solution with the smallest norm (so closest to the origin, geometrically).

To get the other solutions, we need the [`nullspace`][nullspace] of `A2`.

Adding any scalar multiple of the nullpace to the original solution will give another valid solution.

```julia-repl
# get the nummspace of A2
julia> N = nullspace(A2)
3×1 Matrix{Float64}:
 -0.46499055497527725
 -0.3487429162314578
  0.813733471206735

# add a random multiple of the nullspace to the earlier solution
julia> z = z1 + rand() * N
3×1 Matrix{Float64}:
 1.274331860650258
 2.205748895487695
 2.5199192438620472

# our random z is a valid solution, recovering b2 = [1, 12]
julia> A2 * z
2×1 Matrix{Float64}:
  0.9999999999999947
 12.0
```

Similarly, `N-2` equations will constrain the (infinite) solutions to a plane, and the same principles apply.

#### "Too many" rows

The opposite situation comes when there are _more_ equations than unknowns, yet somehow they are still linearly independent.

_In real-world engineering, this is entirely normal, and seen as a Good Thing!_

Transducers have limited precision, the **b** vector has limited precision, and there is noise in the calculation.
Now the solution is a [least squares][least-squares] fit to the noisy data.

The simplest technique uses the [`pseudoinverse`][pseudoinv] of the matrix, wwhich Julia implements as the [`pinv()`][pinv] function.

This can be used much like the inverse of a (non-singular) square matrix, giving a least-squares estimate of the variables rather than an exact solution.

```julia-repl
# create 5-row A and b for 2 variables
julia> A5 = [4 -3; 2 7; -1 2; 1 -1; 3 1]
5×2 Matrix{Int64}:
  4  -3
  2   7
 -1   2
  1  -1
  3   1

julia> rank(A5)
2

# add some random-normal noise to b5
julia> b5n = [-2, 16, 3, -1, 5] + randn(5) * 0.1
5-element Vector{Float64}:
 -1.9337349223581917
 16.024913008059457
  3.0087646177373992
 -0.8675748721176717
  4.914568047308805

# solve to get x ≈ 1, y ≈ 2, using the pseudoinverse
julia> pinv(A5) * b5n
2-element Vector{Float64}:
 1.006117942769543
 1.9962973764508272
```

## Eigenvalues and Eigenvectors

The previous section described solutions for **A** **x** = **b**, equivalent to familiar algebra.

This section is about solutions to **A** **x** = λ **x**, where λ is a scalar.

This is a distinctively Linear Algebra concept, but we can interpret it geometrically:

_For suitable values of **b** and λ, square matrix **A** scales the nonzero vector **b** by a factor λ in length, without changing its direction (other than negative λ reversing it)_.

This sounds niche, but it turns out to be _ridiculously_ useful!

***Terminology:*** Valid values of λ are the _eigenvalues_ of **A**, and the corresponding values of **x** are the _eigenvectors_ of **A**.
Unfortunately, we just have to live with words that switch language halfway through.

Students are usually taught how to calculate eigenvalues/vectors for 2×2 matrices manually, but using a computer is very much easier (though still fairly slow).

```julia-repl
julia> A = rand(-9:9, 2, 2)
2×2 Matrix{Int64}:
 9  5
 3  2

julia> F = eigen(A)
Eigen{Float64, Float64, Matrix{Float64}, Vector{Float64}}
values:
2-element Vector{Float64}:
  0.27984674554472466
 10.720153254455274
vectors:
2×2 Matrix{Float64}:
 -0.497417  0.945605
  0.867511  0.325317

# eigenvalues
julia> F.values
2-element Vector{Float64}:
  0.27984674554472466
 10.720153254455274

# each column is an eigenvector
julia> F.vectors
2×2 Matrix{Float64}:
 -0.497417  0.945605
  0.867511  0.325317
```

In general, an `n×n` matrix will have `n` eigenvalues, though not always _distinct_ values.
Think of them as the roots of an `n`th-order polynomial (called the `correspomding equation`), which can be repeated, and are often complex even for a real-valued matrix.

***TODO : add applications and examples***


## Factorization

***TODO (perhaps?)***




[linalg-wiki]: https://en.wikipedia.org/wiki/Linear_algebra
[3blue1brown]: https://www.3blue1brown.com/topics/linear-algebra
[special-matrices]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#Special-matrices
[permutedims]: https://docs.julialang.org/en/v1/base/arrays/#Base.permutedims
[transpose]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#Base.transpose
[adjoint]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#Base.adjoint
[vector-ops]: https://exercism.org/tracks/julia/concepts/vector-operations
[cray]: https://en.wikipedia.org/wiki/Cray-1
[tensor-prod]: https://en.wikipedia.org/wiki/Tensor_product
[benchmark]: https://github.com/JuliaCI/BenchmarkTools.jl
[rotmat]: https://en.wikipedia.org/wiki/Rotation_matrix
[3d-rot]: https://en.wikipedia.org/wiki/Rotation_matrix#General_3D_rotations
[homogeneous]: https://en.wikipedia.org/wiki/Homogeneous_coordinates
[gaussian-elim]: https://en.wikipedia.org/wiki/Gaussian_elimination
[indep]: https://en.wikipedia.org/wiki/Linear_independence
[rank]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.rank
[rhr]: https://en.wikipedia.org/wiki/Right-hand_rule
[least-squares]: https://en.wikipedia.org/wiki/Least_squares
[pseudoinv]: https://en.wikipedia.org/wiki/Moore%E2%80%93Penrose_inverse
[pinv]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.pinv
[underdet]: https://discourse.julialang.org/t/underdetermined-linear-system-general-solution/37865/2
[nullspace]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.nullspace
