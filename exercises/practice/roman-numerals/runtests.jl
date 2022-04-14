using Test

include("roman-numerals.jl")

samples = Dict(
    1 => "I",
    2 => "II",
    3 => "III",
    4 => "IV",
    5 => "V",
    6 => "VI",
    9 => "IX",
    16 => "XVI",
    27 => "XXVII",
    48 => "XLVIII",
    49 => "XLIX",
    59 => "LIX",
    66 => "LXVI",
    93 => "XCIII",
    141 => "CXLI",
    163 => "CLXIII",
    166 => "CLXVI",
    402 => "CDII",
    575 => "DLXXV",
    666 => "DCLXVI",
    911 => "CMXI",
    1024 => "MXXIV",
    1666 => "MDCLXVI",
    1703 => "MDCCIII",
    1991 => "MCMXCI",
    2017 => "MMXVII",
    3000 => "MMM",
)

@testset "convert $(sample[1]) to roman numeral" for sample in samples
    @test to_roman(sample[1]) == sample[2]
end

@testset "error handling" begin
    @test_throws ErrorException to_roman(0)
    @test_throws ErrorException to_roman(-2017)
end
