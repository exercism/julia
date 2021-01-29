using Test

include("allergies.jl")

#canonical data
@testset "testing for single allergies" begin
    @testset "testing for eggs allergy" begin
        @test !allergic_to(0, "eggs")
        @test  allergic_to(1, "eggs")
        @test  allergic_to(3, "eggs")
        @test !allergic_to(2, "eggs")
        @test  allergic_to(255, "eggs")
    end

    @testset "testing for peanuts allergy" begin
        @test !allergic_to(0, "peanuts")
        @test  allergic_to(2, "peanuts")
        @test  allergic_to(7, "peanuts")
        @test !allergic_to(5, "peanuts")
        @test  allergic_to(255, "peanuts")
    end

    @testset "testing for shellfish allergy" begin
        @test !allergic_to(0, "shellfish")
        @test  allergic_to(4, "shellfish")
        @test  allergic_to(14, "shellfish")
        @test !allergic_to(10, "shellfish")
        @test  allergic_to(255, "shellfish")
    end

    @testset "testing for strawberries allergy" begin
        @test !allergic_to(0, "strawberries")
        @test  allergic_to(8, "strawberries")
        @test  allergic_to(28, "strawberries")
        @test !allergic_to(20, "strawberries")
        @test  allergic_to(255, "strawberries")
    end

    @testset "testing for tomatoes allergy" begin
        @test !allergic_to(0, "tomatoes")
        @test  allergic_to(16, "tomatoes")
        @test  allergic_to(56, "tomatoes")
        @test !allergic_to(40, "tomatoes")
        @test  allergic_to(255, "tomatoes")
    end

    @testset "testing for chocolate allergy" begin
        @test !allergic_to(0, "chocolate")
        @test  allergic_to(32, "chocolate")
        @test  allergic_to(112, "chocolate")
        @test !allergic_to(80, "chocolate")
        @test  allergic_to(255, "chocolate")
    end

    @testset "testing for pollen allergy" begin
        @test !allergic_to(0, "pollen")
        @test  allergic_to(64, "pollen")
        @test  allergic_to(224, "pollen")
        @test !allergic_to(160, "pollen")
        @test  allergic_to(255, "pollen")
    end

    @testset "testing for cats allergy" begin
        @test !allergic_to(0, "cats")
        @test  allergic_to(128, "cats")
        @test  allergic_to(192, "cats")
        @test !allergic_to(64, "cats")
        @test  allergic_to(255, "cats")
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
