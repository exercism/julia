using Test

include("cats-and-dogs.jl")

@testset "type abstraction" begin
    @test Dog <: Pet
    @test Cat <: Pet
end

# create some pets
buddy = Dog("Buddy")
sadie = Dog("Sadie")
minka = Cat("Minka")
felix = Cat("Felix")

@testset "encounters" begin
    @test encounter(sadie, buddy) == "Sadie meets Buddy and sniffs."
    @test encounter(buddy, felix) == "Buddy meets Felix and chases."
    @test encounter(minka, sadie) == "Minka meets Sadie and hisses."
    @test encounter(felix, minka) == "Felix meets Minka and slinks."
end

@testset "verbs" begin
    @test meets(buddy, sadie) == "sniffs"
    @test meets(sadie, minka) == "chases"
    @test meets(felix, buddy) == "hisses"
    @test meets(minka, felix) == "slinks"
end

# define a new type of Pet to test the generic fallback
# this belongs to the testset below but struct definitions within the local scope of testsets are not supported in Julia <1.1
struct Yak <: Pet
    name::String
end

julia = Yak("Julia")

@testset "generic fallback" begin
    @test encounter(buddy, julia) == "Buddy meets Julia and is confused."
    @test encounter(sadie, julia) == "Sadie meets Julia and is confused."
    @test encounter(minka, julia) == "Minka meets Julia and is confused."
    @test encounter(felix, julia) == "Felix meets Julia and is confused."

    @test encounter(julia, buddy) == "Julia meets Buddy and is confused."
    @test encounter(julia, sadie) == "Julia meets Sadie and is confused."
    @test encounter(julia, minka) == "Julia meets Minka and is confused."
    @test encounter(julia, felix) == "Julia meets Felix and is confused."
end
