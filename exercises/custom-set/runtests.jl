using Test

include("custom-set.jl")

# canonical data
@testset "empty" begin
    @test  isempty(CustomSet([]))
    @test !isempty(CustomSet([1]))
end

@testset "in (contains)" begin
    @test !(1 in CustomSet([]))
    @test   1 in CustomSet([1, 2, 3])
    @test !(4 in CustomSet([1, 2, 3]))
end

@testset "subset" begin
    @test  issubset(CustomSet([]), CustomSet([]))
    @test  issubset(CustomSet([]), CustomSet([1]))
    @test !issubset(CustomSet([1]), CustomSet([]))
    @test  issubset(CustomSet([1, 2, 3]), CustomSet([1, 2, 3]))
    @test  issubset(CustomSet([1, 2, 3]), CustomSet([4, 1, 2, 3]))
    @test !issubset(CustomSet([1, 2, 3]), CustomSet([4, 1, 3]))
end

@testset "disjoint" begin
    @test  disjoint(CustomSet([]), CustomSet([]))
    @test  disjoint(CustomSet([]), CustomSet([1]))
    @test  disjoint(CustomSet([1]), CustomSet([]))
    @test !disjoint(CustomSet([1, 2]), CustomSet([2, 3]))
    @test  disjoint(CustomSet([1, 2]), CustomSet([3, 4]))
end

@testset "equal" begin
    @test CustomSet([]) == CustomSet([])
    @test CustomSet([]) != CustomSet([1, 2, 3])
    @test CustomSet([1, 2, 3]) != CustomSet([])
    @test CustomSet([1, 2]) == CustomSet([2, 1])
    @test CustomSet([1, 2, 3]) != CustomSet([1, 2, 4])
    @test CustomSet([1, 2, 3]) != CustomSet([1, 2, 3, 4])
end

@testset "add" begin
    @test begin
        custom_set = CustomSet([])
        push!(custom_set, 3)
        custom_set == CustomSet([3])
    end
    @test begin
        custom_set = CustomSet([1, 2, 4])
        push!(custom_set, 3)
        custom_set == CustomSet([1, 2, 3, 4])
    end
    @test begin
        custom_set = CustomSet([1, 2, 3])
        push!(custom_set, 3)
        custom_set == CustomSet([1, 2, 3])
    end
end

@testset "intersection" begin
    @testset "in-place" begin
        @test begin
            cs1 = CustomSet([])
            cs2 = CustomSet([])
            intersect!(cs1, cs2)
            isempty(cs1)
        end
        @test begin
            cs1 = CustomSet([])
            cs2 = CustomSet([3, 2, 5])
            intersect!(cs1, cs2)
            isempty(cs1)
        end
        @test begin
            cs1 = CustomSet([1, 2, 3, 4])
            cs2 = CustomSet([])
            intersect!(cs1, cs2)
            isempty(cs1)
        end
        @test begin
            cs1 = CustomSet([1, 2, 3])
            cs2 = CustomSet([4, 5, 6])
            intersect!(cs1, cs2)
            isempty(cs1)
        end
        @test begin
            cs1 = CustomSet([1, 2, 3, 4])
            cs2 = CustomSet([3, 2, 5])
            intersect!(cs1, cs2)
            cs1 == CustomSet([2, 3])
        end
    end
    @testset "not in-place" begin
        @test isempty(intersect(CustomSet([]), CustomSet([])))
        @test isempty(intersect(CustomSet([]), CustomSet([3, 2, 5])))
        @test isempty(intersect(CustomSet([1, 2, 3, 4]), CustomSet([])))
        @test isempty(intersect(CustomSet([1, 2, 3]), CustomSet([4, 5, 6])))
        @test intersect(CustomSet([1, 2, 3, 4]), CustomSet([3, 2, 5])) == CustomSet([2, 3])
    end
end

@testset "complement (difference)" begin
    @testset "in-place" begin
        @test begin
            cs1 = CustomSet([])
            cs2 = CustomSet([])
            complement!(cs1, cs2)
            isempty(cs1)
        end
        @test begin
            cs1 = CustomSet([])
            cs2 = CustomSet([3, 2, 5])
            complement!(cs1, cs2)
            isempty(cs1)
        end
        @test begin
            cs1 = CustomSet([1, 2, 3, 4])
            cs2 = CustomSet([])
            complement!(cs1, cs2)
            cs1 == CustomSet([1, 2, 3, 4])
        end
        @test begin
            cs1 = CustomSet([3, 2, 1])
            cs2 = CustomSet([2, 4])
            complement!(cs1, cs2)
            cs1 == CustomSet([1, 3])
        end
    end
    @testset "not in-place" begin
        @test isempty(complement(CustomSet([]), CustomSet([])))
        @test isempty(complement(CustomSet([]), CustomSet([3, 2, 5])))
        @test complement(CustomSet([1, 2, 3, 4]), CustomSet([])) == CustomSet([1, 2, 3, 4])
        @test complement(CustomSet([3, 2, 1]), CustomSet([2, 4])) == CustomSet([1, 3])
    end
end

@testset "union" begin
    @testset "in-place" begin
        @test begin
            cs1 = CustomSet([])
            cs2 = CustomSet([])
            union!(cs1, cs2)
            isempty(cs1)
        end
        @test begin
            cs1 = CustomSet([])
            cs2 = CustomSet([2])
            union!(cs1, cs2)
            cs1 == CustomSet([2])
        end
        @test begin
            cs1 = CustomSet([1, 3])
            cs2 = CustomSet([])
            union!(cs1, cs2)
            cs1 == CustomSet([1, 3])
        end
        @test begin
            cs1 = CustomSet([1, 3])
            cs2 = CustomSet([2, 3])
            union!(cs1, cs2)
            cs1 == CustomSet([3, 2, 1])
        end
    end
    @testset "not in-place" begin
        @test isempty(union(CustomSet([]), CustomSet([])))
        @test union(CustomSet([]), CustomSet([2])) == CustomSet([2])
        @test union(CustomSet([1, 3]), CustomSet([])) == CustomSet([1, 3])
        @test union(CustomSet([1, 3]), CustomSet([2, 3])) == CustomSet([3, 2, 1])
    end
end

# language specific tests
@testset "implements correct abstract type" begin
    @test CustomSet <: Base.AbstractSet
end

@testset "length" begin
    @test length(CustomSet([])) == 0
    @test length(CustomSet([1, 2, 3])) == 3
end

@testset "iterable" begin
    @test begin
        cs1 = CustomSet([1, 2, 3, 4])
        cs2 = CustomSet([])
        for element in cs1
            push!(cs2, element)
        end
        cs1 == cs2
    end
end

@testset "copy" begin
    @test begin
        cs1 = CustomSet([1, 2, 3])
        cs2 = copy(cs1)
        push!(cs1, 4)
        cs2 == CustomSet([1, 2, 3])
    end
end
