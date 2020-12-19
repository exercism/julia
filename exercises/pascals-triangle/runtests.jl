using Test

include("pascals-triangle.jl")

const rows = [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1], [1, 5, 10, 10, 5, 1], [1, 6, 15, 20, 15, 6, 1], [1, 7, 21, 35, 35, 21, 7, 1], [1, 8, 28, 56, 70, 56, 28, 8, 1], [1, 9, 36, 84, 126, 126, 84, 36, 9, 1]]

@testset "$i row(s)" for i in eachindex(rows)
    @test triangle(i) == @view rows[1:i]
end

@testset "special cases" begin
    @test_throws DomainError triangle(-1)
    @test isempty(triangle(0))
end
