using LinearAlgebra

function orientrobot(vecs)
    stack(vecs ./ norm.(vecs), dims=2)
end

function rotaterobot(orientation, θ)
    [cos(θ) -sin(θ); sin(θ) cos(θ)] * orientation
end

function robotoriented(orientation, direction)
    orientation[:, 2] ⋅ norm(direction) ≈ 1
end

function bodylocation(orientation, position)
    orientation .+ position
end

function translaterobot(position, direction, scale)
    position .+ scale * direction
end
