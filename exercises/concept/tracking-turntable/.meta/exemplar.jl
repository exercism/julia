z = complex
euler(r, θ) = r * cispi(θ / π)
rotate(x, y, θ) = reim(z(x, y)euler(1, θ))
rdisplace(x, y, r) = reim((abs(z(x, y)) + r)cispi(angle(z(x, y)) / π))
findsong(x, y, r, θ) = rotate(rdisplace(x, y, r)..., θ)
