# This example solution is partially derived from the Julia base implementation of rational numbers (MIT license)
# https://github.com/JuliaLang/julia/blob/52bafeb981bac548afd2264edb518d8d86944dca/base/rational.jl
# https://github.com/JuliaLang/julia/blob/52bafeb981bac548afd2264edb518d8d86944dca/LICENSE.md

import Base: +, *, ^, -, /, <, <=, inv, show, promote_rule

struct RationalNumber{T<:Integer} <: Real
    num::T
    den::T

    # reduce to lowest terms
    function RationalNumber{T}(num::Integer, den::Integer) where T<:Integer
        num == den == zero(T) && throw(ArgumentError("zero($T)//zero($T) is not a valid rational number"))
        num2, den2 = sign(den) < 0 ? Base.divgcd(-num, -den) : Base.divgcd(num, den)
        new(num2, den2)
    end
end

RationalNumber(num::T, den::T) where {T<:Integer} = RationalNumber{T}(num, den)

numerator(x::RationalNumber) = x.num
denominator(x::RationalNumber) = x.den

RationalNumber{T}(x::Integer) where {T<:Integer} = RationalNumber{T}(convert(T, x), convert(T, 1))

promote_rule(::Type{RationalNumber{T}}, ::Type{S}) where {T<:Integer,S<:Integer} = RationalNumber{promote_type(T,S)}

show(io::IO, x::RationalNumber) = (show(io, numerator(x)); print(io, "//"); show(io, denominator(x)))

# Helper method
numden(x::RationalNumber) = numerator(x), denominator(x)

# Arithmetics
function +(x::RationalNumber, y::RationalNumber)
    a, b = numden(x)
    c, d = numden(y)

    RationalNumber(a * d + b * c, b * d)
end

-(x::RationalNumber, y::RationalNumber) = x + (-1) * y
-(x::RationalNumber) = -1 * x

function *(x::RationalNumber, y::RationalNumber)
    a, b = numden(x)
    c, d = numden(y)

    RationalNumber(a * c, b * d)
end

inv(x::RationalNumber) = RationalNumber(denominator(x), numerator(x))
/(x::RationalNumber, y::RationalNumber) = x * inv(y)

^(x::Real, y::RationalNumber) = x^(numerator(y) / denominator(y))

# Ordering
<(x::RationalNumber, y::RationalNumber) = x.den == y.den ? x.num < y.num : x.num * y.den < y.num * x.den
<=(x::RationalNumber, y::RationalNumber) = x.den == y.den ? x.num <= y.num : x.num * y.den <= y.num * x.den
