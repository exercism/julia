# Based on https://github.com/JuliaLang/julia/blob/master/base/complex.jl (MIT license)

import Base: real, imag, conj, abs, +, -, *, /, exp, convert, promote_rule, isfinite

struct ComplexNumber{T<:Real} <: Number
    re::T
    im::T
end

const jm = ComplexNumber(0, 1)

ComplexNumber(re::Real, im::Real) = ComplexNumber(promote(re, im)...)
ComplexNumber(re::Real) = ComplexNumber(re, zero(re))

convert(::Type{ComplexNumber{T}}, x::Real) where {T<:Real} = ComplexNumber{T}(x, 0)
convert(::Type{ComplexNumber{T}}, z::ComplexNumber) where {T<:Real} = ComplexNumber{T}(real(z), imag(z))

promote_rule(::Type{ComplexNumber{T}}, ::Type{S}) where {T<:Real, S<:Real} = ComplexNumber{promote_type(T, S)}
promote_rule(::Type{ComplexNumber{T}}, ::Type{ComplexNumber{S}}) where {T<:Real, S<:Real} = ComplexNumber{promote_type(T, S)}

real(z::ComplexNumber) = z.re
imag(z::ComplexNumber) = z.im

reim(z::ComplexNumber) = z.re, z.im

conj(z::ComplexNumber) = ComplexNumber(real(z), -imag(z))
abs(z::ComplexNumber)  = hypot(real(z), imag(z))

isfinite(z::ComplexNumber) = isfinite(real(z)) && isfinite(imag(z))

+(u::ComplexNumber, v::ComplexNumber) = ComplexNumber(real(u) + real(v), imag(u) + imag(v))
-(u::ComplexNumber, v::ComplexNumber) = ComplexNumber(real(u) - real(v), imag(u) - imag(v))
*(u::ComplexNumber, v::ComplexNumber) = ComplexNumber(real(u) * real(v) - imag(u) * imag(v), real(u) * imag(v) + imag(u) * real(v))
/(u::ComplexNumber, v::ComplexNumber) = ComplexNumber((real(u) * real(v) + imag(u) * imag(v)) / (real(v)^2 + imag(v)^2), (imag(u) * real(v) - real(u) * imag(v)) / (real(v)^2 + imag(v)^2))
-(z::ComplexNumber) = ComplexNumber(-real(z), -imag(z))

function exp(z::ComplexNumber)
    z_re, z_im = reim(z)
    e_re = exp(z_re)
    ComplexNumber(e_re * cos(z_im), e_re * sin(z_im))
end
