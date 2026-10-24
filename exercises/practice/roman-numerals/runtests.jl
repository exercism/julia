# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/roman-numerals/canonical-data.json
# File last updated on 2026-10-23

using Test

include("roman-numerals.jl")

@testset verbose = true "tests" begin
    @testset "1 is I" begin
        @test to_roman(1) == "I"
    end

    @testset "2 is II" begin
        @test to_roman(2) == "II"
    end

    @testset "3 is III" begin
        @test to_roman(3) == "III"
    end

    @testset "4 is IV" begin
        @test to_roman(4) == "IV"
    end

    @testset "5 is V" begin
        @test to_roman(5) == "V"
    end

    @testset "6 is VI" begin
        @test to_roman(6) == "VI"
    end

    @testset "9 is IX" begin
        @test to_roman(9) == "IX"
    end

    @testset "16 is XVI" begin
        @test to_roman(16) == "XVI"
    end

    @testset "27 is XXVII" begin
        @test to_roman(27) == "XXVII"
    end

    @testset "48 is XLVIII" begin
        @test to_roman(48) == "XLVIII"
    end

    @testset "49 is XLIX" begin
        @test to_roman(49) == "XLIX"
    end

    @testset "59 is LIX" begin
        @test to_roman(59) == "LIX"
    end

    @testset "66 is LXVI" begin
        @test to_roman(66) == "LXVI"
    end

    @testset "93 is XCIII" begin
        @test to_roman(93) == "XCIII"
    end

    @testset "141 is CXLI" begin
        @test to_roman(141) == "CXLI"
    end

    @testset "163 is CLXIII" begin
        @test to_roman(163) == "CLXIII"
    end

    @testset "166 is CLXVI" begin
        @test to_roman(166) == "CLXVI"
    end

    @testset "402 is CDII" begin
        @test to_roman(402) == "CDII"
    end

    @testset "575 is DLXXV" begin
        @test to_roman(575) == "DLXXV"
    end

    @testset "666 is DCLXVI" begin
        @test to_roman(666) == "DCLXVI"
    end

    @testset "911 is CMXI" begin
        @test to_roman(911) == "CMXI"
    end

    @testset "1024 is MXXIV" begin
        @test to_roman(1024) == "MXXIV"
    end

    @testset "1666 is MDCLXVI" begin
        @test to_roman(1666) == "MDCLXVI"
    end

    @testset "3000 is MMM" begin
        @test to_roman(3000) == "MMM"
    end

    @testset "3001 is MMMI" begin
        @test to_roman(3001) == "MMMI"
    end

    @testset "3888 is MMMDCCCLXXXVIII" begin
        @test to_roman(3888) == "MMMDCCCLXXXVIII"
    end

    @testset "3999 is MMMCMXCIX" begin
        @test to_roman(3999) == "MMMCMXCIX"
    end
end
