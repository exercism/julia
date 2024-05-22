using Test

include("perfect-numbers.jl")

@testset verbose = true "tests" begin
    @testset "Perfect numbers" begin

        @testset "Smallest perfect number is classified correctly" begin
            @test isperfect(6)
        end

        @testset "Medium perfect number is classified correctly" begin
            @test isperfect(28)
        end

        @testset "Large perfect number is classified correctly" begin
            @test isperfect(33550336)
        end
        
        @testset "Correctly handles non-perfect numbers" begin
            @test !isperfect(12)
            @test !isperfect(4)
        end
    end

    @testset "Abundant numbers" begin

        @testset "Smallest abundant number is classified correctly" begin
            @test isabundant(12)
        end

        @testset "Medium abundant number is classified correctly" begin
            @test isabundant(30)
        end

        @testset "Large abundant number is classified correctly" begin
            @test isabundant(33550335)
        end

        @testset "Correctly handles non-abundant numbers" begin
            @test !isabundant(6)
            @test !isabundant(32)
        end
    end

    @testset "Deficient numbers" begin

        @testset "Smallest prime deficient number is classified correctly" begin
            @test isdeficient(2)
        end

        @testset "Smallest non-prime deficient number is classified correctly" begin
            @test isdeficient(4)
        end

        @testset "Medium deficient number is classified correctly" begin
            @test isdeficient(32)
        end

        @testset "Large deficient number is classified correctly" begin
            @test isdeficient(33550337)
        end

        @testset "Edge case (no factors other than itself) is classified correctly" begin
            @test isdeficient(1)
        end

        @testset "Correctly handles non-deficient numbers" begin
            @test !isdeficient(28)
            @test !isdeficient(30)
        end
    end

    @testset "Invalid inputs" begin

        @testset "Zero is rejected (not a natural number)" begin
            @test_throws DomainError isdeficient(0)
            @test_throws DomainError isperfect(0)
            @test_throws DomainError isabundant(0)
        end

        @testset "Negative integer is rejected (not a natural number)" begin
            @test_throws DomainError isdeficient(-1)
            @test_throws DomainError isperfect(-1)
            @test_throws DomainError isabundant(-1)
        end
    end
end
