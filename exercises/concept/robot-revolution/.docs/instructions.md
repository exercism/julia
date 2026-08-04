# Instructions

Your working for a robotics startup which is developing a simple robot as a proof-of-concept.
You have been tasked with providing some functionality to control the motion of the robot.

## 1. Orient the Robot

The robot has three markers, which are 1 unit of distance from its center, to keep track of its orientation and extension.
To initialize its position, we need to take the three directional vectors, normalize them, and put them in a matrix.

Implement the `orientrobot(vectors)` function, which takes a vector of three vectors.
Return a `2x3` matrix with the normalized vectors as columns.

```julia-repl
julia> orientrobot([[-1,1],[1,0],[-1,-1]])
2×3 Matrix{Float64}:
 -0.707107  1.0  -0.707107
  0.707107  0.0  -0.707107
```

## 2. Rotate the Robot

Next, we need functionality on how to change the direction of motion.
To do this, we need to rotate the robot to face where it wants to go.

Implement the `rotaterobot(orientation, θ)` function, which takes the robot's orientation matrix and an angle `θ` to rotate *counterclockwise* around.
Return the new orientation matrix.

```julia-repl
julia> orientmatrix = initialize([[-1,1],[1,0],[-1,-1]]);

julia> rotaterobot(orientmatrix, π/2)
2×3 Matrix{Float64}:
 -0.707107  6.12323e-17   0.707107
 -0.707107  1.0          -0.707107
```

## 3. Check for Correct Orientation

To move the robot from one location to another, first we have to check it has the right orientation before moving it.
The second column of the orientation matrix represents the forward facing direction.

Implement the `robotoriented(orientation, direction)` function, which takes an orientation matrix and a relative position vector.
Return `true` if the robot is oriented in the same direction as the relative position vector (within rounding error).

```julia-repl
julia> orientmatrix = initialize([[-1,1],[1,0],[-1,-1]]);

julia> robotoriented(orientmatrix, [5, 0])
true

julia> robotoriented(orientmatrix, [0, 5])
false

julia> robotoriented(orientmatrix, [-5, 0])
false
```

## 4. Robot Body Coordinates

Since the orientation matrix also keeps track of the shape of the robot, we need to know where these points are in reference to the origin after moving the robot.
This will help the robot avoid collisions with other objects when moving around.

Implement the `bodylocation(orientation, position)` function, which takes an orientation matrix and the current position of the center of the robot.
Return the translated orientation matrix.

```julia-repl
julia> orientmatrix = initialize([[-1,1],[1,0],[-1,-1]]);

julia> bodylocation(orientmatrix, [5, 3])
2×3 Matrix{Float64}:
 4.29289  6.0  4.29289
 3.70711  3.0  2.29289
```

## 5. Translate Robot

To move a robot from one place to another, we use a normalized direction vector, and a scale factor, which determines the magnitude of the movement.
To get the new position, these two are combined and added to the current position of the center of the robot.

Implement the `translaterobot(position, direction, scale)` which takes the position vector, a direction vector and a scale.
Return the new position vector of the robot.

```julia-repl
julia> translaterobot([0, 0], [1, 0], 5)
2-element Vector{Int64}:
 5
 0

julia> translaterobot([3, 2], [√2/2, √2/2], 2)
2-element Vector{Float64}:
 5.82842712474619
 4.82842712474619
```
