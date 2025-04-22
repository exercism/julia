# Instructions

Your friend is a sound engineer who has asked you to help them code up a Fourier Transform for some proprietary software they are putting together.
Since you want to get this right, you will first implement the Discrete Fourier Transform (DFT) in all its naive glory.
This could then be used to test the correctness of your final objective, the Fast Fourier Transform (FFT).

## 1. DFT

Implement the DFT.

Note, that this is of `O(n²)` complexity because you get one `k` for a run through all `n`, and you'll want a `Xₖ` vector that is the same length as the signal `Xₙ` vector (for invertibility), so `n` times through `n` points is `O(n²)`.

## 2. FFT

Implement the FFT.

~~~~exercism/note
There are a lot of resources to find more detail on the particulars of this algorithm, so feel free to do some research.
~~~~
