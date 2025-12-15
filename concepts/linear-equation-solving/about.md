# About

Remember when you first learned algebra, back in High School?

Typically, we would be given a system of equations, and asked to solve for `x` and `y`.

```
4x - 3y = -2
2x + 7y = 16
```

Two equations, two unknowns: a bit of substitution, and you can soon see that `x = 1, y = 2`.

Look again at the left side of the previous example.
It looks like a matrix `[4 -3; 2 7]` multiplying an unknown vector `[x, y]` to give the vector `[-2, 16]`.

In Linear Algebra notation: **A** **x** = **b**, following the usual convention of Uppercase letters for matrices and lowercase for vectors.

## **A x = 0** and the nullspace

An important special case is when all our equations have zero on the right hand side.

```
4x - 3y = 0
2x + 7y = 0
```

In the above example, the only solution is when `x = y = 0`, which is not usually interesting.

Non-trivial solutions for **A x = 0** only exist when **A** has a zero [determinant][wiki-determinant].

```julia-repl
julia> using LinearAlgebra

julia> A = [4 -3; 2 7]
2×2 Matrix{Int64}:
 4  -3
 2   7

julia> det(A)  # not zero!
34.0
```

Consider instead these equations:

```
4x - 3y = 0
8x + 6y = 0
```

The second equation is just double the first equation, adding no new information.
Any values where `x = 0.75y` will be a solution.

These `(x, y)` values lie along a line in 2-D space.
There are an infinite number of solutions, and they form the [nullspace][wiki-nullspace] of the matrix.

The rows in the matrix are not [linearly independent][indep] in this case, and the [rank][rank] of the matrix is less than the row or column count.

```julia-repl
julia> A = [4 -3; 8 -6]
2×2 Matrix{Int64}:
 4  -3
 8  -6

julia> det(A)
0.0

julia> size(A)  # total number of rows and columns
(2, 2)

julia> rank(A)  # number of linearly-independent rows (or columns)
1

julia> nullspace(A)
2×1 Matrix{Float64}:
 -0.6
 -0.8

julia> nullspace(A) |> norm  # Julia returns unit vectors when possible
1.0
```

The [`nullspace()`][ref-nullspace] function returns a single point, chosen to be [normalized][wiki-unit-vec] to a unit vector, but any scalar multiple of this vector is also in the nullspace.

## Solving **A x = b**

Now suppose you have 1000 equations in 1000 unknowns?
If that sounds silly, remember that wireless digital transducers are now cheap and versatile (measure strain, wind speed, 3-axis acceleration, whatever...).
Having 1000 of them monitoring a modern structure like a suspension bridge is perfectly reasonable.
There needs to be a control system interpreting the data stream, ready to signal an alert if things get alarming.

Again, **A** **x** = **b**, where we have **A** (from the engineering design) and **b** (measured values from the transducers) but need to find **x**.

A first thought, for anyone unfamiliar with this, is to somehow "divide through by **A**" to move it to the RHS.

In fact, **A** has an inverse (most but not all square matrices do: the [determinant][wiki-determinant] must be non-zero), and the calculation works (_slowly!_).

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

Sometime as a pre-teen, you were probably taught that you need a system of `N` equations to solve for `N` unknowns.

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
[Unofficially][underdet], this is apparently the solution with the smallest norm (closest to the origin, geometrically).

To get the other solutions, we need the [`nullspace`][ref-nullspace] of `A2`.

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

The simplest technique uses the [`pseudoinverse`][pseudoinv] of the matrix, which Julia implements as the [`pinv()`][pinv] function.

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

_For suitable values of **x** and λ, square matrix **A** scales the nonzero vector **x** by a factor λ in length, without changing its direction (other than negative λ reversing it)_.

This sounds niche, but it turns out to be _ridiculously_ useful!

***Terminology:*** Valid values of λ are the _eigenvalues_ of **A**, and the corresponding values of **x** are the _eigenvectors_ of **A**.
_Unfortunately, we just have to live with words that switch language halfway through._

Students are usually taught how to calculate eigenvalues/vectors for 2×2 matrices manually, but using a computer is very much easier (though still fairly slow, and scaling as `O(n^3)` for an `n×n` matrix in the general case).

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

# each column is an eigenvector, normalized to a unit vector
julia> F.vectors
2×2 Matrix{Float64}:
 -0.497417  0.945605
  0.867511  0.325317
```

In general, an `n×n` matrix will have `n` eigenvalues, though not always _distinct_ values.
Think of them as the roots of an `n`th-order polynomial (called the [characteristic polynomial][wiki-char-poly]), which can be repeated, and are often complex even for a real-valued matrix.

Each eigenvector represents a direction, and any scalar multiple is also a valid eigenvector.
For convenience in further calculations, Julia returns unit vectors with a [norm][wiki-norm] of 1.

### Applications

Explaining why eigenvectors are important is ideally a job for a 500-page textbook, rather than a few short paragraphs.
This topic permeates _so much_ of modern applied mathematics.

At the top level, eigenvectors represent the "most important" axes (directions) in a dataset.
Eigenvalues indicate the "relative importance" of each axis (_subject to some assumptions about normalization of the inputs_).

What this actually _means_ depends on the application.

#### Principal Components Analysis

In a typical data science problem, we might have 100 or more "features", stored as columns of data.
Almost inevitably, there will be noise, redundancy, and unwanted correlations.

We need to do dimension reduction, and [PCA][wiki-PCA] is one way to bring order to the chaos:

- Calculate the [covariance matrix][wiki-cov-matrix] of the data.
- We now have a square matrix, so next calculate the eigenvalues and eigenvectors.
- Sort the eigenvectors in descending order of their eigenvalues (more precisely, the absolute value `|λ|`).
- The top `k` eigenvectors are now your `principal components`, where `k` is significantly smaller than the original number of features.
- Project the full dataset onto these `k` axes, and start looking for interesting patterns.

In this form, PCA has been used by groups as diverse as medical scientists trying to improve molecular properties in drug design, and political campaigners trying to understand voter preferences from polling data.
Probably also by marketing groups trying to sell you stuff, but any technology can be used for good or bad.

PCA is not part of a minimal Julia installation, but (outside of Exercism) the [MultivariateStats][ref-multistats] package contains what you need.

#### Image processing

Taking the PCA idea a step further, digital images are just matrices of pixel values, and we can calculate principal components for them.

This has been used for decades in image compression, where PCA is a guide to what is most impotant to preserve when reducing the file size.

Increasingly, PCA is a vital part of image classifiers such as facial recognition.
Next time you walk through an airport, [Big Brother][wiki-big-brother] is not just watching, he also uses Linear Algebra to understand what he sees!

#### Mechanical Engineering

Less controversially, the principal axes of a mechanical component are the eigenvectors of its [moment of inertia tensor][wiki-I-tensor] ***I*** (a matrix by a slightly different name).

Each wheel on your car probably has one or more balance weights, adjusted to zero out off-diagonal elements in this tensor ***I***.
The garage mechanic no doubt avoids doing the math (in contrast to aircraft designers and rocket engineers), but "wobble" is just an everyday word to describe cross-terms in the tensor, which in this case would make your journey less comfortable and increase mechanical wear on the bearings.


[linalg-wiki]: https://en.wikipedia.org/wiki/Linear_algebra
[3blue1brown]: https://www.3blue1brown.com/topics/linear-algebra
[gaussian-elim]: https://en.wikipedia.org/wiki/Gaussian_elimination
[indep]: https://en.wikipedia.org/wiki/Linear_independence
[rank]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.rank
[rhr]: https://en.wikipedia.org/wiki/Right-hand_rule
[least-squares]: https://en.wikipedia.org/wiki/Least_squares
[pseudoinv]: https://en.wikipedia.org/wiki/Moore%E2%80%93Penrose_inverse
[pinv]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.pinv
[underdet]: https://discourse.julialang.org/t/underdetermined-linear-system-general-solution/37865/2
[ref-nullspace]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.nullspace
[wiki-cov-matrix]: https://en.wikipedia.org/wiki/Covariance_matrix
[wiki-PCA]: https://en.wikipedia.org/wiki/Principal_component_analysis
[wiki-I-tensor]: https://en.wikipedia.org/wiki/Moment_of_inertia#Inertia_tensor
[wiki-big-brother]: https://en.wikipedia.org/wiki/Big_Brother_(Nineteen_Eighty-Four)
[wiki-char-poly]: https://en.wikipedia.org/wiki/Characteristic_polynomial
[wiki-nullspace]: https://en.wikipedia.org/wiki/Kernel_(linear_algebra)#Representation_as_matrix_multiplication
[wiki-determinant]: https://en.wikipedia.org/wiki/Determinant
[ref-multistats]: https://juliastats.org/MultivariateStats.jl/dev/pca/
[wiki-unit-vec]: https://en.wikipedia.org/wiki/Unit_vector
[wiki-norm]: https://en.wikipedia.org/wiki/Norm_(mathematics)
