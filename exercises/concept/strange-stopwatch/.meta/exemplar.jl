rotate(x, y, θ) = reim(complex(x, y)cispi(θ/π))
timearg(x, y) = π - angle(complex(rotate(x, y, π/2)...))
readtime(x, y) = "$(floor(Int, abs(complex(x, y))))m $(rad2deg(timearg(x, y))/6)s"
getcoords(m, s) = rotate(reim(m * cispi(-deg2rad(6s)/π))..., π/2)
