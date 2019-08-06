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

@testset "names" begin
    @test name(buddy) == "Buddy"
    @test name(sadie) == "Sadie"
    @test name(minka) == "Minka"
    @test name(felix) == "Felix"
end

@testset "encounters" begin
    @test encounter(sadie, buddy) == "Sadie meets Buddy and sniffs."
    @test encounter(buddy, felix) == "Buddy meets Felix and chases."
    @test encounter(minka, sadie) == "Minka meets Sadie and hisses."
    @test encounter(felix, minka) == "Felix meets Minka and slinks."
end

# define a new type of Pet to test the generic fallback
# this belongs to the testset below but struct definitions within the local scope of testsets are not supported in Julia <1.1
struct Penguin <: Pet
    name::String
end
name(p::Penguin) = p.name

tux = Penguin("Tux")

@testset "generic fallback" begin
    @test encounter(buddy, tux) == "Buddy meets Tux and is confused."
    @test encounter(sadie, tux) == "Sadie meets Tux and is confused."
    @test encounter(minka, tux) == "Minka meets Tux and is confused."
    @test encounter(felix, tux) == "Felix meets Tux and is confused."

    @test encounter(tux, buddy) == "Tux meets Buddy and is confused."
    @test encounter(tux, sadie) == "Tux meets Sadie and is confused."
    @test encounter(tux, minka) == "Tux meets Minka and is confused."
    @test encounter(tux, felix) == "Tux meets Felix and is confused."
end
