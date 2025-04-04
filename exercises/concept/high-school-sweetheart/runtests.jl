using Test 

include("high-school-sweetheart.jl")

@testset verbose = true "tests" begin
    @testset "cleanupname" begin
        @testset "should remove `-` when inside a name" begin
            @test cleanupname("John-Doe") == "John Doe"
        end

        @testset "should remove `-` when at the start and the end of a name" begin
            @test cleanupname("-John-Doe-") == "John Doe"
        end
    end

    @testset "firstletter" begin
        @testset "gets the first letter" begin
            @test firstletter("Mary") == "M"
        end

        @testset "doesn't change the letter's case" begin
            @test firstletter("john") == "j"
        end

        @testset "strips extra characters" begin
            @test firstletter("\n\t   -Sarah-   ") == "S"
        end
    end

    @testset "initial" begin
        @testset "gets the first letter and appends a dot" begin
            @test initial("Betty") == "B."
        end

        @testset "uppercases the first letter" begin
            @test initial("james") == "J."
        end
    end

    @testset "couple" begin
        @testset "prints the couple's initials inside a heart" begin
            @test couple("Avery", "Charlie") == "❤ A.  +  C. ❤"
        end
    end
end
