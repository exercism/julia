# Instructions

Let's implement the Fast Fourier Transform (FFT)! 
It's potentially more straighforward than you think. 
To do, so, there will be two steps.
First, you will implement the Discrete Fourier Transform (DFT) in all its naive glory.
Then you will go for the FFT.

## Task 1. DFT

We can do this straight from the definition of the DFT: `Xₖ = Σ xₙ * ℯ^(-2iπk * n/N)`
This is of `O(n²)` complexity because you get one `k` for a run through all `n`, and you'll want a `Xₖ` vector that is the same length as the signal `Xₙ` vector (for invertability), so `n` times through `n` points is `O(n²)`.
While the complexity is fixed at `O(n²)`, there are still faster and slower ways to do this.
Loops are slower than matrix multiplcation, and that's all that needs be said.

## Task 2. FFT

As stated in the introduction, this is typically done with a divide-and-conquer strategy, so recursion is likely your friend, by while loops are not ruled out (and can even be more efficient).

If you want to have a go without other help (recommended!), read no further and get to it however you desire.

Otherwise, an outline of what the basic (recursive) FFT algorithm looks like is as follows:
- When the length of the input vector is less than or equal to 1, return the input vector. Otherwise...
- The signal is split into two parts, the elements with even indices `Xₑ` and the elements with odd indices `Xₒ`.
- The FFT is run on both parts.
- The vector `f(n) = ℯ^(-2iπ * n/N)` is made (with `n` running from 0 to N/2-1).
- The two parts `Xₑ` and `Xₒ` are recombined into a full vector `[Xₑ + f(n) * Xₒ; Xₑ - f(n) * Xₒ]`, where the addition and multiplications are elementwise.

There are a lot of resources to find more detail on the particulars of this algorithm, so feel free to do some research.
If you can get the algorithm from only the information here and in the introduction, you get a cookie.
# Instructions

Let's implement the Fast Fourier Transform (FFT)! 
It's potentially more straightforward than you think. 
To do, so, there will be two steps.
First, you will implement the Discrete Fourier Transform (DFT) in all its naive glory.
Then you will go for the FFT.

## Task 1. DFT

We can do this straight from the definition of the DFT: `Xₖ = Σ xₙ * ℯ^(-2iπk * n/N)`
This is of `O(n²)` complexity because you get one `k` for a run through all `n`, and you'll want a `Xₖ` vector that is the same length as the signal `Xₙ` vector (for invertibility), so `n` times through `n` points is `O(n²)`.
While the complexity is fixed at `O(n²)`, there are still faster and slower ways to do this.
Loops are slower than matrix multiplication, and that's all that needs be said.

## Task 2. FFT

As stated in the introduction, this is typically done with a divide-and-conquer strategy, so recursion is likely your friend, by while loops are not ruled out (and can even be more efficient).

If you want to have a go without other help (recommended!), read no further and get to it however you desire.

Otherwise, an outline of what the basic (recursive) FFT algorithm looks like is as follows:
- When the length of the input vector is less than or equal to 1, return the input vector. Otherwise...
- The signal is split into two parts, the elements with even indices `Xₑ` and the elements with odd indices `Xₒ`.
- The FFT is run on both parts.
- The vector `f(n) = ℯ^(-2iπ * n/N)` is made (with `n` running from 0 to N/2-1).
- The two parts `Xₑ` and `Xₒ` are recombined into a full vector `[Xₑ + f(n) * Xₒ; Xₑ - f(n) * Xₒ]`, where the addition and multiplications are elementwise.

There are a lot of resources to find more detail on the particulars of this algorithm, so feel free to do some research.
If you can get the algorithm from only the information here and in the introduction, you get a cookie.
