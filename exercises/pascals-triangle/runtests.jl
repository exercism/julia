using Test

include("pascals-triangle.jl")

rows = [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1]]

@testset "$i row(s)" for i in 1:4
    @test triangle(i) == rows[1:i]
end

@testset "special cases" begin
    @test_throws DomainError triangle(-1)
    @test isempty(triangle(0))
end
