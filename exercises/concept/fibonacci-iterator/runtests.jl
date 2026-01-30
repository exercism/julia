using Test

include("fibonacci.jl")

const fib = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 2178309, 3524578, 5702887, 9227465, 14930352, 24157817, 39088169, 63245986, 102334155, 165580141, 267914296, 433494437, 701408733, 1134903170, 1836311903, 2971215073, 4807526976, 7778742049, 12586269025]

@testset verbose = true "tests" begin
    @testset "1. Fiberator is defined" begin
        @test isdefined(@__MODULE__, :Fiberator)
        @test typeof(Fiberator(100)) == Fiberator
        @testset "Fiberator does not contain fields to store state internally" begin
            # Backport fieldtypes for Julia 1.0 - no longer relevant
            # if VERSION < v"1.1"
            #     @eval fieldtypes(T::Type) = ntuple(i -> fieldtype(T, i), fieldcount(T))
            # end
    
            # Ensure only one numeric value (n) can be stored
            # This should prevent Fiberator types that use a tuple or struct to store more state
            @test fieldcount(Fiberator) == 1
            @test fieldtypes(Fiberator)[1] <: Number
        end
    end

    @testset "2. Can be iterated" begin
        @test [a for a in Fiberator(50)] == fib
    end

    @testset "3. Can be collected" begin
        @test collect(Fiberator(50)) == fib
        @test Base.IteratorSize(Fiberator) == Base.HasLength()
    end

    @testset "4. Has an eltype" begin
        @test typeof(collect(Fiberator(50))) == Vector{Int}
        @test Base.IteratorEltype(Fiberator) == Base.HasEltype()
    end
end
