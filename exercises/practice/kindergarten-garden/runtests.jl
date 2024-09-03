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
        
        @testset "second student's garden" begin
            @test plants("VVCCGG\nVVCCGG", "Bob") == ["clover", "clover", "clover", "clover"]
        end
        
        @testset "third student's garden" begin
            @test plants("VVCCGG\nVVCCGG", "Charlie") == ["grass", "grass", "grass", "grass"]
        end
    end

    @testset "full garden" begin
        @testset "for Alice, first student's garden" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Alice") == ["violets", "radishes", "violets", "radishes"]
        end

        @testset "for Bob, second student's garden" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Bob") == ["clover", "grass", "clover", "clover"]
        end

        @testset "for Charlie" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Charlie") == ["violets", "violets", "clover", "grass"]
        end

        @testset "for David" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "David") == ["radishes", "violets", "clover", "radishes"]
        end

        @testset "for Eve" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Eve") == ["clover", "grass", "radishes", "grass"]
        end

        @testset "for Fred" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Fred") == ["grass", "clover", "violets", "clover"]
        end

        @testset "for Ginny" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Ginny") == ["clover", "grass", "grass", "clover"]
        end

        @testset "for Harriet" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Harriet") == ["violets", "radishes", "radishes", "violets"]
        end

        @testset "for Ileana" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Ileana") == ["grass", "clover", "violets", "clover"]
        end

        @testset "for Joseph" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Joseph") == ["violets", "clover", "violets", "grass"]
        end

        @testset "for Kincaid, second to last student's garden" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Kincaid") == ["grass", "clover", "clover", "grass"]
        end

        @testset "for Larry, last student's garden" begin
            diagram = "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
            @test plants(diagram, "Larry") == ["grass", "violets", "clover", "violets"]
        end

    end
end
