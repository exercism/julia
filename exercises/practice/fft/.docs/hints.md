# Hints

## 1. DFT
- This can be done straight from the definition of the DFT: `Xₖ = Σ xₙ * ℯ^(-2iπk * n/N)`
- While the complexity is fixed at `O(n²)`, there are still methods to do this which are more efficient.
- Loops are generally slower than matrix multiplication.

## 2. FFT
- As stated in the introduction, this is typically done with a divide-and-conquer strategy, so recursion is likely your friend, but while loops are not ruled out (and can even be more efficient).
- An outline of an algorithm is as follows:
    - When the length of the input vector is less than or equal to 1, return the input vector. Otherwise...
    - The signal is split into two parts, the elements with even indices `Xₑ` and the elements with odd indices `Xₒ`.
    - The FFT is run on both parts.
    - The vector `f(n) = ℯ^(-2iπ * n/N)` is made (with `n` running from 0 to N/2-1).
    - The two parts `Xₑ` and `Xₒ` are recombined into a full vector `[Xₑ + f(n) * Xₒ; Xₑ - f(n) * Xₒ]`, where the addition and multiplications are elementwise.
