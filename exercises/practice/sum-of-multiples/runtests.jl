include("sum-of-multiples.jl")
using Test

@testset "no multiples within limit" begin
    @test sum_of_multiples(1, [3, 5]) == 0
 end

@testset "test one factor has multiples within limit" begin
    @test sum_of_multiples(4, [3, 5]) == 3
end

@testset "more than one multiple within limit" begin
    @test sum_of_multiples(7, [3]) == 9
end

@testset "more than one factor with multiples within limit" begin
    @test sum_of_multiples(10, [3, 5]) == 23
end

@testset "each multiple is only counted once" begin
    @test sum_of_multiples(100, [3, 5]) == 2318
end

@testset "a much larger limit" begin
    @test sum_of_multiples(1000, [3, 5]) == 233168
end

@testset "three factors" begin
    @test sum_of_multiples(20, [7, 13, 17]) == 51
end

@testset "factors not relatively prime" begin
    @test sum_of_multiples(15, [4, 6]) == 30
end

@testset "some pairs of factors relatively prime and some not" begin
    @test sum_of_multiples(150, [5, 6, 8]) == 4419
end

@testset "one factor is a multiple of another" begin
    @test sum_of_multiples(51, [5, 25]) == 275
end

@testset "test much larger factors" begin
    @test sum_of_multiples(10000, [43, 47]) == 2203160
end

@testset "all numbers are multiples of 1" begin
    @test sum_of_multiples(100, [1]) == 4950
end

@testset "no factors means an empty sum" begin
    @test sum_of_multiples(10000, []) == 0
end

@testset "the only multiple of 0 is 0" begin
    @test sum_of_multiples(1, [0]) == 0
end

@testset "the factor 0 does not affect the sum_of_multiples of other factors" begin
    @test sum_of_multiples(4, [3, 0]) == 3
end

@testset "solutions using include exclude must extend to cardinality greater than 3" begin
    @test sum_of_multiples(10000, [2, 3, 5, 7, 11]) == 39614537
end


# def test no multiples within limit(self):
# self.assertEqual(sum_of_multiples(1, [3, 5]), 0)

# def test one factor has multiples within limit(self):
# self.assertEqual(sum_of_multiples(4, [3, 5]), 3)

# def test more than one multiple within limit(self):
# self.assertEqual(sum_of_multiples(7, [3]), 9)

# def test more than one factor with multiples within limit(self):
# self.assertEqual(sum_of_multiples(10, [3, 5]), 23)

# def test each multiple is only counted once(self):
# self.assertEqual(sum_of_multiples(100, [3, 5]), 2318)

# def test a much larger limit(self):
# self.assertEqual(sum_of_multiples(1000, [3, 5]), 233168)

# def test three factors(self):
# self.assertEqual(sum_of_multiples(20, [7, 13, 17]), 51)

# def test factors not relatively prime(self):
# self.assertEqual(sum_of_multiples(15, [4, 6]), 30)

# def test some pairs of factors relatively prime and some not(self):
# self.assertEqual(sum_of_multiples(150, [5, 6, 8]), 4419)

# def test one factor is a multiple of another(self):
# self.assertEqual(sum_of_multiples(51, [5, 25]), 275)

# def test much larger factors(self):
# self.assertEqual(sum_of_multiples(10000, [43, 47]), 2203160)

# def test all numbers are multiples of 1(self):
# self.assertEqual(sum_of_multiples(100, [1]), 4950)

# def test no factors means an empty sum(self):
# self.assertEqual(sum_of_multiples(10000, []), 0)

# def test the only multiple of 0 is 0(self):
# self.assertEqual(sum_of_multiples(1, [0]), 0)

# def test the factor 0 does not affect the sum_of_multiples of other factors(self):
# self.assertEqual(sum_of_multiples(4, [3, 0]), 3)

# def test solutions using include exclude must extend to cardinality greater than 3(
# self,
# ):
# self.assertEqual(sum_of_multiples(10000, [2, 3, 5, 7, 11]), 39614537)
