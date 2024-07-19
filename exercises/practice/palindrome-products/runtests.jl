using Test

include("palindrome-products.jl")

@testset verbose = true "tests" begin
    @testset "find the smallest palindrome from single digit factors" begin
        palindrome, factors = palindromeproducts(1, 9, true)
        @test palindrome == 1
        @test factors == [[1, 1]]
    end
    
    @testset "find the largest palindrome from single digit factors" begin
        palindrome, factors = palindromeproducts(1, 9, false)
        @test palindrome == 9
        @test sort(factors) == [[1, 9], [3, 3]]
    end
    
    @testset "find the smallest palindrome from double digit factors" begin
        palindrome, factors = palindromeproducts(10, 99, true)
        @test palindrome == 121
        @test factors == [[11, 11]]
    end

    @testset "find the largest palindrome from double digit factors" begin
        palindrome, factors = palindromeproducts(10, 99, false)
        @test palindrome == 9009
        @test factors == [[91, 99]]
    end
    
    @testset "find the smallest palindrome from triple digit factors" begin
        palindrome, factors = palindromeproducts(100, 999, true)
        @test palindrome == 10201
        @test factors == [[101, 101]]
    end
    
    @testset "find the largest palindrome from triple digit factors" begin
        palindrome, factors = palindromeproducts(100, 999, false)
        @test palindrome == 906609
        @test factors == [[913, 993]]
    end
    
    @testset "find the smallest palindrome from four digit factors" begin
        palindrome, factors = palindromeproducts(1000, 9999, true)
        @test palindrome == 1002001
        @test factors == [[1001, 1001]]
    end
    
    @testset "find the largest palindrome from four digit factors" begin
        palindrome, factors = palindromeproducts(1000, 9999, false)
        @test palindrome == 99000099
        @test factors == [[9901, 9999]]
    end
    
    @testset "empty result for smallest if no palindrome in the range" begin
        palindrome, factors = palindromeproducts(1002, 1003, true)
        @test isnothing(palindrome)
        @test isempty(factors)
    end
    
    @testset "empty result for largest if no palindrome in the range" begin
        palindrome, factors = palindromeproducts(15, 15, false)
        @test isnothing(palindrome)
        @test isempty(factors)
    end
    
    @testset "error result for smallest if min is more than max" begin
        @test_throws ArgumentError palindromeproducts(10000, 1, true)
    end
    
    @testset "error result for largest if min is more than max" begin
        @test_throws ArgumentError palindromeproducts(10000, 1, false)
    end
    
    @testset "smallest product does not use the smallest factor" begin
        palindrome, factors = palindromeproducts(3215, 4000, true)
        @test palindrome == 10988901
        @test factors == [[3297, 3333]]
    end
end
