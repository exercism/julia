# Instructions

#### Updating
Checking if an object is on one side of a hyperplane or another can be done by checking the normal vector which points to the object. The value will be positive, negative or zero, so all of the objects from a class should have normal vectors with the same sign. A zero value means the object is on the hyperplane, which we don't want to allow since its ambiguous. Checking the sign of a normal to a hyperplane might sound like it could be complicated, but it's actually quite easy. Simply plug in the coordinates for the object into the equation for the hyperplane and check the sign of the result. For example, we can look at two objects `v₁, v₂` in relation to the hyperplane `[w₀, w₁, w₂] = [1, 1, 1]`:

`v₁ = [x₁, y₁] = [2, 2]`

`w₀ + w₁⋅x₁ + w₂⋅y₁ = 1 + 1⋅2 + 1⋅2 = 5 > 0`


`v₂ = [x₂, y₂] = [-2, -2]` 

`w₀ + w₁⋅x₂ + w₂⋅y₂ = 1 + 1⋅(-2) + 1⋅(-2) = -3 < 0`

If `v₁` and `v₂` have the labels `1` and `-1` (like we will be using), then the hyperplane `[1, 1, 1]` is a valid decision boundary for them since the signs match. 

Now that we know how to tell which side of the hyperplane an object lies on, we can look at how perceptron updates a hyperplane. If an object is on the correct side of the hyperplane, no update is performed on the weights. However, if we find an object on the wrong side, the update rule for the weights is:

`[w₀', w₁', w₂'] = [w₀ + 1ₗ, w₁ + x⋅1ₗ, w₂ + y⋅1ₗ]`

Where `1ₗ ∈ {1, -1}`, according to the class of the object (i.e. its label), `x, y` are the coordinates of the object, the `wᵢ` are the weights of the hyperplane and the `wᵢ'` are the weights of the updated hyperplane.

This update is repeated for each object in turn, and then the whole process repeated until there are no updates made to the hyperplane. All objects passing without an update means they have been successfully separated and you can return your decision boundary!

Notes: 
- Although the perceptron algorithm is deterministic, a decision boundary depends on initialization and is not unique in general, so the tests accept any hyperplane which fully separates the objects.
- The tests here will only include linearly separable classes, so a decision boundary will always be possible (i.e. no need to worry about non-separable classes).
