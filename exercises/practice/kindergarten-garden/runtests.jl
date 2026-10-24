# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/kindergarten-garden/canonical-data.json
# File last updated on 2026-10-24

using Test

include("kindergarten-garden.jl")

@testset verbose = true "tests" begin
    @testset "partial garden" begin
        @testset "garden with single student" begin
            @test plants("RC\nGG", "Alice") == ["radishes", "clover", "grass", "grass"]
        end

        @testset "different garden with single student" begin
            @test plants("VC\nRC", "Alice") == ["violets", "clover", "radishes", "clover"]
        end

        @testset "garden with two students" begin
            @test plants("VVCG\nVVRC", "Bob") == ["clover", "grass", "radishes", "clover"]
        end

        @testset "multiple students for the same garden with three students" begin
            @testset "second student's garden" begin
                @test plants("VVCCGG\nVVCCGG", "Bob") ==
                      ["clover", "clover", "clover", "clover"]
            end

            @testset "third student's garden" begin
                @test plants("VVCCGG\nVVCCGG", "Charlie") ==
                      ["grass", "grass", "grass", "grass"]
            end
        end
    end

    @testset "full garden" begin
        @testset "for Alice, first student's garden" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Alice") ==
                  ["violets", "radishes", "violets", "radishes"]
        end

        @testset "for Bob, second student's garden" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Bob") ==
                  ["clover", "grass", "clover", "clover"]
        end

        @testset "for Charlie" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Charlie") ==
                  ["violets", "violets", "clover", "grass"]
        end

        @testset "for David" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "David") ==
                  ["radishes", "violets", "clover", "radishes"]
        end

        @testset "for Eve" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Eve") ==
                  ["clover", "grass", "radishes", "grass"]
        end

        @testset "for Fred" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Fred") ==
                  ["grass", "clover", "violets", "clover"]
        end

        @testset "for Ginny" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Ginny") ==
                  ["clover", "grass", "grass", "clover"]
        end

        @testset "for Harriet" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Harriet") ==
                  ["violets", "radishes", "radishes", "violets"]
        end

        @testset "for Ileana" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Ileana") ==
                  ["grass", "clover", "violets", "clover"]
        end

        @testset "for Joseph" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Joseph") ==
                  ["violets", "clover", "violets", "grass"]
        end

        @testset "for Kincaid, second to last student's garden" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Kincaid") ==
                  ["grass", "clover", "clover", "grass"]
        end

        @testset "for Larry, last student's garden" begin
            @test plants("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV", "Larry") ==
                  ["grass", "violets", "clover", "violets"]
        end
    end
end
