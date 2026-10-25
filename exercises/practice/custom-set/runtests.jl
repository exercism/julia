# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/custom-set/canonical-data.json
# File last updated on 2026-10-25

using Test

include("custom-set.jl")

@testset verbose = true "tests" begin
    @testset "Returns true if the set contains no elements" begin
        @testset "sets with no elements are empty" begin
            @test isempty(CustomSet([]))
        end

        @testset "sets with elements are not empty" begin
            @test !isempty(CustomSet([1]))
        end
    end

    @testset "Sets can report if they contain an element" begin
        @testset "nothing is contained in an empty set" begin
            @test !(1 in CustomSet([]))
        end

        @testset "when the element is in the set" begin
            @test 1 in CustomSet([1, 2, 3])
        end

        @testset "when the element is not in the set" begin
            @test !(4 in CustomSet([1, 2, 3]))
        end
    end

    @testset "A set is a subset if all of its elements are contained in the other set" begin
        @testset "empty set is a subset of another empty set" begin
            @test issubset(CustomSet([]), CustomSet([]))
        end

        @testset "empty set is a subset of non-empty set" begin
            @test issubset(CustomSet([]), CustomSet([1]))
        end

        @testset "non-empty set is not a subset of empty set" begin
            @test !issubset(CustomSet([1]), CustomSet([]))
        end

        @testset "set is a subset of set with exact same elements" begin
            @test issubset(CustomSet([1, 2, 3]), CustomSet([1, 2, 3]))
        end

        @testset "set is a subset of larger set with same elements" begin
            @test issubset(CustomSet([1, 2, 3]), CustomSet([4, 1, 2, 3]))
        end

        @testset "set is not a subset of set that does not contain its elements" begin
            @test !issubset(CustomSet([1, 2, 3]), CustomSet([4, 1, 3]))
        end
    end

    @testset "Sets are disjoint if they share no elements" begin
        @testset "the empty set is disjoint with itself" begin
            @test disjoint(CustomSet([]), CustomSet([]))
        end

        @testset "empty set is disjoint with non-empty set" begin
            @test disjoint(CustomSet([]), CustomSet([1]))
        end

        @testset "non-empty set is disjoint with empty set" begin
            @test disjoint(CustomSet([1]), CustomSet([]))
        end

        @testset "sets are not disjoint if they share an element" begin
            @test !disjoint(CustomSet([1, 2]), CustomSet([2, 3]))
        end

        @testset "sets are disjoint if they share no elements" begin
            @test disjoint(CustomSet([1, 2]), CustomSet([3, 4]))
        end
    end

    @testset "Sets with the same elements are equal" begin
        @testset "empty sets are equal" begin
            @test CustomSet([]) == CustomSet([])
        end

        @testset "empty set is not equal to non-empty set" begin
            @test CustomSet([]) != CustomSet([1, 2, 3])
        end

        @testset "non-empty set is not equal to empty set" begin
            @test CustomSet([1, 2, 3]) != CustomSet([])
        end

        @testset "sets with the same elements are equal" begin
            @test CustomSet([1, 2]) == CustomSet([2, 1])
        end

        @testset "sets with different elements are not equal" begin
            @test CustomSet([1, 2, 3]) != CustomSet([1, 2, 4])
        end

        @testset "set is not equal to larger set with same elements" begin
            @test CustomSet([1, 2, 3]) != CustomSet([1, 2, 3, 4])
        end

        @testset "set is equal to a set constructed from an array with duplicates" begin
            @test CustomSet([1]) == CustomSet([1, 1])
        end
    end

    @testset "Unique elements can be added to a set" begin
        @testset "add to empty set" begin
            custom_set = CustomSet([])
            push!(custom_set, 3)
            @test custom_set == CustomSet([3])
        end

        @testset "add to non-empty set" begin
            custom_set = CustomSet([1, 2, 4])
            push!(custom_set, 3)
            @test custom_set == CustomSet([1, 2, 3, 4])
        end

        @testset "adding an existing element does not change the set" begin
            custom_set = CustomSet([1, 2, 3])
            push!(custom_set, 3)
            @test custom_set == CustomSet([1, 2, 3])
        end
    end

    @testset "Intersection returns a set of all shared elements" begin
        @testset "intersection of two empty sets is an empty set" begin
            @test isempty(intersect(CustomSet([]), CustomSet([])))
            cs1 = CustomSet([])
            intersect!(cs1, CustomSet([]))
            @test isempty(cs1)
        end

        @testset "intersection of an empty set and non-empty set is an empty set" begin
            @test isempty(intersect(CustomSet([]), CustomSet([3, 2, 5])))
            cs1 = CustomSet([])
            intersect!(cs1, CustomSet([3, 2, 5]))
            @test isempty(cs1)
        end

        @testset "intersection of a non-empty set and an empty set is an empty set" begin
            @test isempty(intersect(CustomSet([1, 2, 3, 4]), CustomSet([])))
            cs1 = CustomSet([1, 2, 3, 4])
            intersect!(cs1, CustomSet([]))
            @test isempty(cs1)
        end

        @testset "intersection of two sets with no shared elements is an empty set" begin
            @test isempty(intersect(CustomSet([1, 2, 3]), CustomSet([4, 5, 6])))
            cs1 = CustomSet([1, 2, 3])
            intersect!(cs1, CustomSet([4, 5, 6]))
            @test isempty(cs1)
        end

        @testset "intersection of two sets with shared elements is a set of the shared elements" begin
            @test intersect(CustomSet([1, 2, 3, 4]), CustomSet([3, 2, 5])) ==
                  CustomSet([2, 3])
            cs1 = CustomSet([1, 2, 3, 4])
            intersect!(cs1, CustomSet([3, 2, 5]))
            @test cs1 == CustomSet([2, 3])
        end
    end

    @testset "Difference (or Complement) of a set is a set of all elements that are only in the first set" begin
        @testset "difference of two empty sets is an empty set" begin
            @test isempty(complement(CustomSet([]), CustomSet([])))
            cs1 = CustomSet([])
            complement!(cs1, CustomSet([]))
            @test isempty(cs1)
        end

        @testset "difference of empty set and non-empty set is an empty set" begin
            @test isempty(complement(CustomSet([]), CustomSet([3, 2, 5])))
            cs1 = CustomSet([])
            complement!(cs1, CustomSet([3, 2, 5]))
            @test isempty(cs1)
        end

        @testset "difference of a non-empty set and an empty set is the non-empty set" begin
            @test complement(CustomSet([1, 2, 3, 4]), CustomSet([])) ==
                  CustomSet([1, 2, 3, 4])
            cs1 = CustomSet([1, 2, 3, 4])
            complement!(cs1, CustomSet([]))
            @test cs1 == CustomSet([1, 2, 3, 4])
        end

        @testset "difference of two non-empty sets is a set of elements that are only in the first set" begin
            @test complement(CustomSet([3, 2, 1]), CustomSet([2, 4])) == CustomSet([1, 3])
            cs1 = CustomSet([3, 2, 1])
            complement!(cs1, CustomSet([2, 4]))
            @test cs1 == CustomSet([1, 3])
        end

        @testset "difference removes all duplicates in the first set" begin
            @test isempty(complement(CustomSet([1, 1]), CustomSet([1])))
            cs1 = CustomSet([1, 1])
            complement!(cs1, CustomSet([1]))
            @test isempty(cs1)
        end
    end

    @testset "Union returns a set of all elements in either set" begin
        @testset "union of empty sets is an empty set" begin
            @test isempty(union(CustomSet([]), CustomSet([])))
            cs1 = CustomSet([])
            union!(cs1, CustomSet([]))
            @test isempty(cs1)
        end

        @testset "union of an empty set and non-empty set is the non-empty set" begin
            @test union(CustomSet([]), CustomSet([2])) == CustomSet([2])
            cs1 = CustomSet([])
            union!(cs1, CustomSet([2]))
            @test cs1 == CustomSet([2])
        end

        @testset "union of a non-empty set and empty set is the non-empty set" begin
            @test union(CustomSet([1, 3]), CustomSet([])) == CustomSet([1, 3])
            cs1 = CustomSet([1, 3])
            union!(cs1, CustomSet([]))
            @test cs1 == CustomSet([1, 3])
        end

        @testset "union of non-empty sets contains all unique elements" begin
            @test union(CustomSet([1, 3]), CustomSet([2, 3])) == CustomSet([3, 2, 1])
            cs1 = CustomSet([1, 3])
            union!(cs1, CustomSet([2, 3]))
            @test cs1 == CustomSet([3, 2, 1])
        end
    end
end
