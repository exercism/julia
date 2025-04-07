rotate(x, y, θ) = reim(complex(x, y)cispi(θ/π))
rdisplace(x, y, r) = reim((abs(complex(x, y)) + r)cispi(angle(complex(x, y)) / π))
findsong(x, y, r, θ) = rotate(rdisplace(x, y, r)..., θ)
