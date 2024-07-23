# Introduction
**Note: This is quite a _mathsy_ exercise. If you don't enjoy solving maths-based exercises, maybe skip this one. But if you do, you'll enjoy this.**
### Perceptron
[Perceptron](https://en.wikipedia.org/wiki/Perceptron) is one of the oldest and bestestly named machine learning algorithms out there. Since it is also quite simple to implement, it's a favorite place to start a machine learning journey. Perceptron is what is known as a linear classifier, which means that, if we have two labled classes of objects, for example in 2D space, it will search for a line that can be drawn to separate them. If such a line exists, Perceptron is guaranteed to find one. See Perceptron in action separating black and white dots below!

<p align="center">
<a title="Miquel Perelló Nieto, CC BY 4.0 &lt;https://creativecommons.org/licenses/by/4.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Perceptron_training_without_bias.gif"><img width="512" alt="Perceptron training without bias" src="https://upload.wikimedia.org/wikipedia/commons/a/aa/Perceptron_training_without_bias.gif"></a>
</p>

### Details
The basic idea is fairly straightforward. As illustrated above, we cycle through the objects and check if they are on the correct side of our guess at a line. If one is not, we make a correction and continue checking the objects against the corrected line. Eventually the line is adjusted to correctly separate all the objects and we have what is called a decision boundary!

Why is this of any use? The decision boundary found can then help us in predicting what a new, unlabeled, object would likely be classified as by seeing which side of the boundary it is on.

#### A Brief Word on Hyperplanes
What we have been calling a line in 2D can be generalized to something called a [hyperplane](https://en.wikipedia.org/wiki/Hyperplane), which is a convenient representation, and, if you follow the classic Perceptron algorithm, you will have to pick an initial hyperplane to start with. How do you pick your starting hyperplane? It's up to you! Be creative! Or not... Actually perceptron's convergence times are sensitive to conditions such as the initial hyperplane and even the order the objects are looped through, so you might not want to go too wild.

We will be playing in a two dimensional space, so our separating hyperplane will simply be a 1D line. You might remember the standard equation for a line as `y = ax+b`, where `a,b ∈ ℝ`, however, in order to help generalize the idea to higher dimensions, it's convenient to reformulate this equation as `w₀ + w₁x + w₂y = 0`. This is the form of the hyperplane we will be using, so your output should be `[w₀, w₁, w₂]`. In machine learning, the `{w₀, w₁, w₂}` are usually referred to as weights. 

Scaling a hyperplane by a positive value gives an equivalent hyperplane (e.g. `[w₀, w₁, w₂] ≈ [c⋅w₀, c⋅w₁, c⋅w₂]` with `c > 0`), since an infinite line scaled by a value is just the same infinite line. However, it should be noted that there is a difference between the normal vectors (the green arrow in illustration above) associated with hyperplanes scaled by a negative value (e.g. `[w₀, w₁, w₂]` vs `[-w₀, -w₁, -w₂]`) in that the normal to the negative hyperplane points in opposite direction of that of the positive one. By convention, the perceptron normal points towards the class defined as positive.
