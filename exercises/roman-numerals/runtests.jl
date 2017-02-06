using Base.Test

include("roman-numerals.jl")

# NOTE: Got that one from Python's testset
samples = Dict(
    1 => "I",
    2 => "II",
    3 => "III",
    4 => "IV",
    5 => "V",
    6 => "VI",
    9 => "IX",
    27 => "XXVII",
    48 => "XLVIII",
    59 => "LIX",
    93 => "XCIII",
    141 => "CXLI",
    163 => "CLXIII",
    402 => "CDII",
    575 => "DLXXV",
    911 => "CMXI",
    1024 => "MXXIV",
    3000 => "MMM"
)

for sample in samples
    @testset "convert " * repr(sample[1]) * " to roman numeral" begin
        @test to_roman(sample[1]) == sample[2]
    end
end

@testset "error handling" begin
    @test_throws ErrorException to_roman(0)
end
