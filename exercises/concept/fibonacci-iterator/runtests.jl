using Test

include("fibonacci.jl")

@testset verbose = true "tests" begin
    fibonaccinumbers = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233,
                        377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711,
                        28657, 46368, 75025, 121393, 196418, 317811, 514229,
                        832040, 1346269, 2178309, 3524578, 5702887, 9227465,
                        14930352, 24157817, 39088169, 63245986, 102334155,
                        165580141, 267914296, 433494437, 701408733, 1134903170,
                        1836311903, 2971215073, 4807526976, 7778742049, 12586269025]

    @testset "1. Fiberator is defined" begin
        @test isdefined(@__MODULE__, :Fiberator)
        @test typeof(Fiberator(100)) == Fiberator
        @testset "Fiberator does not contain fields to store state internally" begin
            # Ensure only one numeric value (n) can be stored
            # This should prevent Fiberator types that use a tuple or struct to store more state
            @test fieldcount(Fiberator) == 1
            @test fieldtypes(Fiberator)[1] <: Number
        end
    end

    @testset "2. Fiberator can be iterated" begin
        fiberatornumbers = []
        foreach(fib -> push!(fiberatornumbers, fib), Fiberator(50))
        @test fiberatornumbers == fibonaccinumbers
    end

    @testset "3. Fiberator can be collected" begin
        @test Base.IteratorSize(Fiberator) == Base.HasLength()
        @test collect(Fiberator(50)) == fibonaccinumbers
    end

    @testset "4. Fiberator has an eltype" begin
        @test Base.IteratorEltype(Fiberator) == Base.HasEltype()
        @test typeof(collect(Fiberator(50))) == Vector{Int}
    end
end
