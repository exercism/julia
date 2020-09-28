# canonical data version: 2.0.0

using Test

include("allergies.jl")

#canonical data
@testset "testing for single allergies" begin
    @testset "testing for eggs allergy" begin
        @test allergic_to(0, "eggs") == false
        @test allergic_to(1, "eggs") == true
        @test allergic_to(3, "eggs") == true
        @test allergic_to(2, "eggs") == false
        @test allergic_to(255, "eggs") == true
    end

    @testset "testing for peanuts allergy" begin
        @test allergic_to(0, "peanuts") == false
        @test allergic_to(2, "peanuts") == true
        @test allergic_to(7, "peanuts") == true
        @test allergic_to(5, "peanuts") == false
        @test allergic_to(255, "peanuts") == true
    end

    @testset "testing for shellfish allergy" begin
        @test allergic_to(0, "shellfish") == false
        @test allergic_to(4, "shellfish") == true
        @test allergic_to(14, "shellfish") == true
        @test allergic_to(10, "shellfish") == false
        @test allergic_to(255, "shellfish") == true
    end

    @testset "testing for strawberries allergy" begin
        @test allergic_to(0, "strawberries") == false
        @test allergic_to(8, "strawberries") == true
        @test allergic_to(28, "strawberries") == true
        @test allergic_to(20, "strawberries") == false
        @test allergic_to(255, "strawberries") == true
    end

    @testset "testing for tomatoes allergy" begin
        @test allergic_to(0, "tomatoes") == false
        @test allergic_to(16, "tomatoes") == true
        @test allergic_to(56, "tomatoes") == true
        @test allergic_to(40, "tomatoes") == false
        @test allergic_to(255, "tomatoes") == true
    end

    @testset "testing for chocolate allergy" begin
        @test allergic_to(0, "chocolate") == false
        @test allergic_to(32, "chocolate") == true
        @test allergic_to(112, "chocolate") == true
        @test allergic_to(80, "chocolate") == false
        @test allergic_to(255, "chocolate") == true
    end

    @testset "testing for pollen allergy" begin
        @test allergic_to(0, "pollen") == false
        @test allergic_to(64, "pollen") == true
        @test allergic_to(224, "pollen") == true
        @test allergic_to(160, "pollen") == false
        @test allergic_to(255, "pollen") == true
    end

    @testset "testing for cats allergy" begin
        @test allergic_to(0, "cats") == false
        @test allergic_to(128, "cats") == true
        @test allergic_to(192, "cats") == true
        @test allergic_to(64, "cats") == false
        @test allergic_to(255, "cats") == true
    end
end

@testset "testing the allergy_list" begin
        @testset "testing single allergies" begin
        @test allergy_list(0) == Set([])
        @test allergy_list(1) == Set(["eggs"])
        @test allergy_list(2) == Set(["peanuts"])
        @test allergy_list(8) == Set(["strawberries"])
    end

    @testset "testing for more allergies" begin
        @test allergy_list(3) == Set(["eggs", "peanuts"])
        @test allergy_list(5) == Set(["eggs", "shellfish"])
        @test allergy_list(248) == Set(["strawberries", "tomatoes", "chocolate", "pollen", "cats"])
        @test allergy_list(255) == Set(["eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"])
        @test allergy_list(509) == Set(["eggs", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"])
    end
end
