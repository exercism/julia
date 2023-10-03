# Instructions

### Introduction
[Perceptron](https://en.wikipedia.org/wiki/Perceptron) is one of the oldest and bestestly named machine learning algorithms out there. Since perceptron is also quite simple to implement, it's a favorite place to start a machine learning journey. As a linear classifier, if a linear decision boundary (e.g. a line in 2D or hyperplane in general) can be drawn to separate two labled classes of objects, perceptron is guaranteed to do so. This can help in predicting what an unlabeled object would likely be classified as by seeing which side of the decision boundary it is on.

### Details
The basic idea is fairly straightforward. We cycle through the objects and check if they are on the correct side of our hyperplane. If one is not, we make a correction to the hyperplane and continue checking the objects against the new hyperplane. Eventually the hyperplane is adjusted to correctly separate all the objects and we have our decision boundary!

#### A Brief Word on Hyperplanes
How do you pick your starting hyperplane? It's up to you! Be creative! Or not... Actually perceptron's convergence times are sensitive to conditions such as the initial hyperplane and even the order the objects are looped through, so you might not want to go too wild.

We will be dealing with a two dimensional space, so our divider will be a line. The standard equation for a line is usually written as $y = ax+b$, where $a,b \in \Re$, however, in order to help generalize the idea to higher dimensions, it's convenient to reformulate this equation as $w_0 + w_1x + w_2y = 0$. This is the form of the [hyperplane](https://en.wikipedia.org/wiki/Hyperplane) we will be using, so your output should be $[w_0, w_1, w_2]$. In machine learning, ${w_0,w_1,w_2}$ are usually referred to as weights. 

While hyperplanes are equivalent under scalar multiplication, there is a difference between $[w_0, w_1, w_2]$ and $[-w_0, -w_1, -w_2]$ in that the normal to the hyperplane points in opposite directions. By convention, the perceptron normal points towards the class defined as positive, so this property will be checked but not result in a test failure.

#### Updating
Checking if an object is on one side of a hyperplane or another can be done by checking the normal vector which points to the object. The value will be positive, negative or zero, so all of the objects from a class should have normal vectors with the same sign. A zero value means the object is on the hyperplane, which we don't want to allow since its ambiguous. Checking the sign of a normal to a hyperplane might sound like it could be complicated, but it's actually quite easy. Simply plug in the coordinates for the object into the equation for the hyperplane and check the sign of the result. For example, we can look at two objects $v_1,v_2$ in relation to the hyperplane $[w_0, w_1, w_2] = [1, 1, 1]$:

$$v_1$$ $$[x_1, y_1] = [2, 2]$$ $$w_0 + w_1*x_1 + w_2*y_1 = 1 + 1*2 + 1*2 = 5 > 0$$


$$v_2$$ $$[x_2,y_2]=[-2,-2]$$ $$w_0 + w_1*x_2 + w_2*y_2 = 1 + 1*(-2) + 1*(-2) = -3 < 0$$

If $v_1$ and $v_2$ have different labels, such as $1$ and $-1$ (like we will be using), then the hyperplane $[1, 1, 1]$ is a valid decision boundary for them. 

Now that we know how to tell which side of the hyperplane an object lies on, we can look at how perceptron updates a hyperplane. If an object is on the correct side of the hyperplane, no update is performed on the weights. However, if we find an object on the wrong side, the update rule for the weights is:

$$[w_0', w_1', w_2'] = [w_0 \pm l_{class}, w_1 \pm x*l_{class}, w_2 \pm y*l_{class}]$$

Where $l_{class}=\pm 1$, according to the class of the object (i.e. its label), $x,y$ are the coordinates of the object, the $w_i$ are the weights of the hyperplane and the $w_i'$ are the weights of the updated hyperplane. The plus or minus signs are homogenous, so either all plus or all minus, and are determined by the choice of which class you define to be on the positive side of the hyperplane. Beware that only two out of the four possible combinations of class on positive side of the hyperplane and the plus/minus in the update are valid ($\pm \pm, \mp \mp$), with the other two ($\pm \mp, \mp \pm$) leading to infinite loops.

This update is repeated for each object in turn, and then the whole process repeated until there are no updates made to the hyperplane. All objects passing without an update means they have been successfully separated and you can return your decision boundary!

Note: Although the perceptron algorithm is deterministic, a decision boundary depends on initialization and is not unique in general, so the tests accept any hyperplane which fully separates the objects.