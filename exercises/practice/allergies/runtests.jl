# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/allergies/canonical-data.json
# File last updated on 2026-10-24

using Test

include("allergies.jl")

@testset verbose = true "tests" begin
    @testset "testing for eggs allergy" begin
        @testset "not allergic to anything" begin
            @test !allergic_to(0, "eggs")
        end

        @testset "allergic only to eggs" begin
            @test allergic_to(1, "eggs")
        end

        @testset "allergic to eggs and something else" begin
            @test allergic_to(3, "eggs")
        end

        @testset "allergic to something, but not eggs" begin
            @test !allergic_to(2, "eggs")
        end

        @testset "allergic to everything" begin
            @test allergic_to(255, "eggs")
        end
    end

    @testset "testing for peanuts allergy" begin
        @testset "not allergic to anything" begin
            @test !allergic_to(0, "peanuts")
        end

        @testset "allergic only to peanuts" begin
            @test allergic_to(2, "peanuts")
        end

        @testset "allergic to peanuts and something else" begin
            @test allergic_to(7, "peanuts")
        end

        @testset "allergic to something, but not peanuts" begin
            @test !allergic_to(5, "peanuts")
        end

        @testset "allergic to everything" begin
            @test allergic_to(255, "peanuts")
        end
    end

    @testset "testing for shellfish allergy" begin
        @testset "not allergic to anything" begin
            @test !allergic_to(0, "shellfish")
        end

        @testset "allergic only to shellfish" begin
            @test allergic_to(4, "shellfish")
        end

        @testset "allergic to shellfish and something else" begin
            @test allergic_to(14, "shellfish")
        end

        @testset "allergic to something, but not shellfish" begin
            @test !allergic_to(10, "shellfish")
        end

        @testset "allergic to everything" begin
            @test allergic_to(255, "shellfish")
        end
    end

    @testset "testing for strawberries allergy" begin
        @testset "not allergic to anything" begin
            @test !allergic_to(0, "strawberries")
        end

        @testset "allergic only to strawberries" begin
            @test allergic_to(8, "strawberries")
        end

        @testset "allergic to strawberries and something else" begin
            @test allergic_to(28, "strawberries")
        end

        @testset "allergic to something, but not strawberries" begin
            @test !allergic_to(20, "strawberries")
        end

        @testset "allergic to everything" begin
            @test allergic_to(255, "strawberries")
        end
    end

    @testset "testing for tomatoes allergy" begin
        @testset "not allergic to anything" begin
            @test !allergic_to(0, "tomatoes")
        end

        @testset "allergic only to tomatoes" begin
            @test allergic_to(16, "tomatoes")
        end

        @testset "allergic to tomatoes and something else" begin
            @test allergic_to(56, "tomatoes")
        end

        @testset "allergic to something, but not tomatoes" begin
            @test !allergic_to(40, "tomatoes")
        end

        @testset "allergic to everything" begin
            @test allergic_to(255, "tomatoes")
        end
    end

    @testset "testing for chocolate allergy" begin
        @testset "not allergic to anything" begin
            @test !allergic_to(0, "chocolate")
        end

        @testset "allergic only to chocolate" begin
            @test allergic_to(32, "chocolate")
        end

        @testset "allergic to chocolate and something else" begin
            @test allergic_to(112, "chocolate")
        end

        @testset "allergic to something, but not chocolate" begin
            @test !allergic_to(80, "chocolate")
        end

        @testset "allergic to everything" begin
            @test allergic_to(255, "chocolate")
        end
    end

    @testset "testing for pollen allergy" begin
        @testset "not allergic to anything" begin
            @test !allergic_to(0, "pollen")
        end

        @testset "allergic only to pollen" begin
            @test allergic_to(64, "pollen")
        end

        @testset "allergic to pollen and something else" begin
            @test allergic_to(224, "pollen")
        end

        @testset "allergic to something, but not pollen" begin
            @test !allergic_to(160, "pollen")
        end

        @testset "allergic to everything" begin
            @test allergic_to(255, "pollen")
        end
    end

    @testset "testing for cats allergy" begin
        @testset "not allergic to anything" begin
            @test !allergic_to(0, "cats")
        end

        @testset "allergic only to cats" begin
            @test allergic_to(128, "cats")
        end

        @testset "allergic to cats and something else" begin
            @test allergic_to(192, "cats")
        end

        @testset "allergic to something, but not cats" begin
            @test !allergic_to(64, "cats")
        end

        @testset "allergic to everything" begin
            @test allergic_to(255, "cats")
        end
    end

    @testset "list when:" begin
        @testset "no allergies" begin
            @test allergy_list(0) == Set([])
        end

        @testset "just eggs" begin
            @test allergy_list(1) == Set(["eggs"])
        end

        @testset "just peanuts" begin
            @test allergy_list(2) == Set(["peanuts"])
        end

        @testset "just strawberries" begin
            @test allergy_list(8) == Set(["strawberries"])
        end

        @testset "eggs and peanuts" begin
            @test allergy_list(3) == Set(["eggs", "peanuts"])
        end

        @testset "more than eggs but not peanuts" begin
            @test allergy_list(5) == Set(["eggs", "shellfish"])
        end

        @testset "lots of stuff" begin
            @test allergy_list(248) ==
                  Set(["strawberries", "tomatoes", "chocolate", "pollen", "cats"])
        end

        @testset "everything" begin
            @test allergy_list(255) ==
                  Set(["eggs", "peanuts", "shellfish", "strawberries", "tomatoes",
                       "chocolate", "pollen", "cats"])
        end

        @testset "no allergen score parts" begin
            @test allergy_list(509) ==
                  Set(["eggs", "shellfish", "strawberries", "tomatoes", "chocolate",
                       "pollen", "cats"])
        end

        @testset "no allergen score parts without highest valid score" begin
            @test allergy_list(257) == Set(["eggs"])
        end
    end
end
