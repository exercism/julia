function dft(x)
    N = length(x)
    n = 0:(N-1)
    M = @. cispi(-2n' * n / N)
    M * x
end

function fft(x)
    length(x) ≤ 1 && return x 
    N = length(x)
    xeven, xodd = fft(x[1:2:end]), fft(x[2:2:end])
    factors = cispi.(-(0:2:N-2) / N)
    [xeven .+ factors .* xodd; xeven .- factors .* xodd]
end
