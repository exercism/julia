# Instructions

### Introduction
[Perceptron](https://en.wikipedia.org/wiki/Perceptron) is one of the oldest and bestestly named machine learning algorithms out there. Since it is also quite simple to implement, it's a favorite place to start a machine learning journey. Perceptron is what is known as a linear classifier, which means that, if we have two labled classes of objects, for example in 2D space, it will search for a line that can be drawn to separate them. If such a line exists, Perceptron is guaranteed to find one. See Perceptron in action separating black and white dots below!

<p align="center">
<a title="Miquel Perelló Nieto, CC BY 4.0 &lt;https://creativecommons.org/licenses/by/4.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Perceptron_training_without_bias.gif"><img width="512" alt="Perceptron training without bias" src="https://upload.wikimedia.org/wikipedia/commons/a/aa/Perceptron_training_without_bias.gif"></a>
</p>

### Details
The basic idea is fairly straightforward. As illustrated above, we cycle through the objects and check if they are on the correct side of our guess at a line. If one is not, we make a correction and continue checking the objects against the corrected line. Eventually the line is adjusted to correctly separate all the objects and we have what is called a decision boundary!

Why is this of any use? The decision boundary found can then help us in predicting what a new, unlabeled, object would likely be classified as by seeing which side of the boundary it is on.

#### A Brief Word on Hyperplanes
What we have been calling a line in 2D can be generalized to something called a [hyperplane](https://en.wikipedia.org/wiki/Hyperplane), which is a convenient representation, and, if you follow the classic Perceptron algorithm, you will have to pick an initial hyperplane to start with. How do you pick your starting hyperplane? It's up to you! Be creative! Or not... Actually perceptron's convergence times are sensitive to conditions such as the initial hyperplane and even the order the objects are looped through, so you might not want to go too wild.

We will be playing in a two dimensional space, so our separating hyperplane will simply be a 1D line. You might remember the standard equation for a line as `y = ax+b`, where `a,b ∈ R`, however, in order to help generalize the idea to higher dimensions, it's convenient to reformulate this equation as `w_0 + w_1x + w_2y = 0`. This is the form of the hyperplane we will be using, so your output should be `[w_0, w_1, w_2]`. In machine learning, the `{w_0, w_1, w_2}` are usually referred to as weights. 

Scaling a hyperplane by a positive value gives an equivalent hyperplane (e.g. `[w_0, w_1, w_2] ≈ [c * w_0, c * w_1, c * w_2]` with `c > 0`), since an infinite line scaled by a value is just the same infinite line. However, it should be noted that there is a difference between the normal vectors (the green arrow in illustration above) associated with hyperplanes scaled by a negative value (e.g. `[w_0, w_1, w_2]` vs `[-w_0, -w_1, -w_2]`) in that the normal to the negative hyperplane points in opposite direction of that of the positive one. By convention, the perceptron normal points towards the class defined as positive.

#### Updating
Checking if an object is on one side of a hyperplane or another can be done by checking the normal vector which points to the object. The value will be positive, negative or zero, so all of the objects from a class should have normal vectors with the same sign. A zero value means the object is on the hyperplane, which we don't want to allow since its ambiguous. Checking the sign of a normal to a hyperplane might sound like it could be complicated, but it's actually quite easy. Simply plug in the coordinates for the object into the equation for the hyperplane and check the sign of the result. For example, we can look at two objects `v_1, v_2` in relation to the hyperplane `[w_0, w_1, w_2] = [1, 1, 1]`:

`v_1 = [x_1, y_1] = [2, 2]`

`w_0 + w_1 * x_1 + w_2 * y_1 = 1 + 1 * 2 + 1 * 2 = 5 > 0`


`v_2 = [x_2, y_2] = [-2, -2]` 

`w_0 + w_1 * x_2 + w_2 * y_2 = 1 + 1 * (-2) + 1 * (-2) = -3 < 0`

If `v_1` and `v_2` have the labels `1` and `-1` (like we will be using), then the hyperplane `[1, 1, 1]` is a valid decision boundary for them since the signs match. 

Now that we know how to tell which side of the hyperplane an object lies on, we can look at how perceptron updates a hyperplane. If an object is on the correct side of the hyperplane, no update is performed on the weights. However, if we find an object on the wrong side, the update rule for the weights is:

`[w_0', w_1', w_2'] = [w_0 + class, w_1 + x * class, w_2 + y * class]`

Where `class ∈ {1,-1}`, according to the class of the object (i.e. its label), `x, y` are the coordinates of the object, the `w_i` are the weights of the hyperplane and the `w_i'` are the weights of the updated hyperplane.

This update is repeated for each object in turn, and then the whole process repeated until there are no updates made to the hyperplane. All objects passing without an update means they have been successfully separated and you can return your decision boundary!

Notes: 
- Although the perceptron algorithm is deterministic, a decision boundary depends on initialization and is not unique in general, so the tests accept any hyperplane which fully separates the objects.
- The tests here will only include linearly separable classes, so a decision boundary will always be possible (i.e. no need to worry about non-separable classes).
