# See default_template.jl.
using GeneratorUtils

using DataStructures: OrderedDict
using JSON

# Modify as desired.
const IO_IN = stdin
const IO_OUT = stdout

function parse_operations(operations)
    out = IOBuffer()
    for op in operations
        op_name = op["operation"]
        if op_name == "read"
            if op["should_succeed"]
                s = "@test popfirst!(cb) == $(op["expected"])"
            else
                s = "@test_throws BoundsError popfirst!(cb)"
            end
        elseif op_name == "write"
            item = op["item"]
            if op["should_succeed"]
                s = "@test push!(cb, $item) === cb"
            else
                s = "@test_throws BoundsError push!(cb, $item)"
            end
        elseif op_name == "overwrite"
            s = "@test push!(cb, $(op["item"]); overwrite=true) === cb"
        elseif op_name == "clear"
            s = "@test empty!(cb) === cb"
        else
            throw(ArgumentError("Unrecognized operation `$op_name`."))
        end
        write(out, s, '\n')
    end
    out.size -= 1  # remove last newline
    return String(take!(out))
end

function print_custom_tests(io::IO)
    println(
        io,
        """
        @testset "overwrite=true and overwrite=false" begin
            cb = CircularBuffer{Int}(2)
            @test empty!(cb) === cb
            @test push!(cb, 1; overwrite=true) === cb
            @test push!(cb, 2; overwrite=true) === cb
            @test_throws BoundsError push!(cb, 3; overwrite=false)
            @test push!(cb, 4; overwrite=true) === cb
            @test popfirst!(cb) == 2
            @test popfirst!(cb) == 4
            @test_throws BoundsError popfirst!(cb)
        end

        @testset "type parameter" begin
            cb = CircularBuffer{Int}(1)
            @test_throws Exception push!(cb, "0")
            cb = CircularBuffer{String}(1)
            @test_throws Exception push!(cb, 0)
            @test push!(cb, "0") === cb
            @test popfirst!(cb) == "0"
        end
        """
    )
end

function print_bonus_tests(io::IO)
    println(
        io,
        """
if @isdefined(enable_bonus_tests) && enable_bonus_tests
    @testset "is subtype of AbstractVector" begin
        @test CircularBuffer <: AbstractVector
    end

    # Copied from DataStructures.jl and slightly modified.
    @testset "Bonus test set taken from DataStructures.jl (CircularBuffer)" begin
        @testset "Core Functionality" begin
            cb = CircularBuffer{Int}(5)
            @testset "When empty" begin
                @test length(cb) == 0
                @test capacity(cb) == 5
                @test_throws BoundsError first(cb)
                @test_throws BoundsError last(cb)
                @test isempty(cb) == true
                @test isfull(cb) == false
                @test eltype(cb) == Int
                @test eltype(typeof(cb)) == Int
            end

            @testset "With 1 element" begin
                push!(cb, 1)
                @test length(cb) == 1
                @test capacity(cb) == 5
                @test isfull(cb) == false
                @test first(cb) == last(cb)
            end

            @testset "Appending many elements" begin
                append!(cb, 2:8; overwrite=true)
                @test length(cb) == capacity(cb)
                @test size(cb) == (length(cb),)
                @test isempty(cb) == false
                @test isfull(cb) == true
                @test convert(Array, cb) == Int[4,5,6,7,8]
            end

            @testset "getindex" begin
                @test cb[1] == 4
                @test cb[2] == 5
                @test cb[3] == 6
                @test cb[4] == 7
                @test cb[5] == 8
                @test_throws BoundsError cb[6]
                @test_throws BoundsError cb[3:6]
                @test cb[3:4] == Int[6,7]
                @test cb[[1,5]] == Int[4,8]
                @test first(cb) == 4
                @test last(cb) == 8
            end

            @testset "setindex" begin
                cb[3] = 999
                @test convert(Array, cb) == Int[4,5,999,7,8]
            end
        end

        @testset "pushfirst" begin
            cb = CircularBuffer{Int}(5)  # New, empty one for full test coverage
            for i in -5:5
                pushfirst!(cb, i; overwrite=true)
            end
            arr = convert(Array, cb)
            @test arr == Int[5, 4, 3, 2, 1]
            for (idx, n) in enumerate(5:1)
                @test arr[idx] == n
            end
        end

        @testset "Issue 429" begin
            cb = CircularBuffer{Int}(5)
            map(x -> pushfirst!(cb, x; overwrite=true), 1:8)
            pop!(cb)
            pushfirst!(cb, 9)
            arr = convert(Array, cb)
            @test arr == Int[9, 8, 7, 6, 5]
        end

        @testset "Issue 379" begin
            cb = CircularBuffer{Int}(5)
            pushfirst!(cb, 1)
            @test cb == [1]
            pushfirst!(cb, 2)
            @test cb == [2, 1]
        end

        @testset "empty!" begin
            cb = CircularBuffer{Int}(5)
            push!(cb, 13)
            empty!(cb)
            @test length(cb) == 0
        end

        @testset "pop!" begin
            cb = CircularBuffer{Int}(5)
            for i in 0:5    # one extra to force wraparound
                push!(cb, i; overwrite=true)
            end
            for j in 5:-1:1
                @test pop!(cb) == j
                @test convert(Array, cb) == collect(1:j-1)
            end
            @test isempty(cb)
            @test_throws BoundsError pop!(cb)
        end

        @testset "popfirst!" begin
            cb = CircularBuffer{Int}(5)
            for i in 0:5    # one extra to force wraparound
                push!(cb, i; overwrite=true)
            end
            for j in 1:5
                @test popfirst!(cb) == j
                @test convert(Array, cb) == collect(j+1:5)
            end
            @test isempty(cb)
            @test_throws BoundsError popfirst!(cb)
        end
    end
end

if @isdefined(enable_bonus_tests) && enable_bonus_tests
    # Copied from DataStructures.jl and slightly modified.
    @testset "Bonus test set taken from DataStructures.jl (CircularDeque)" begin
        CircularDeque = CircularBuffer

        @testset "Core Functionality" begin
            D = CircularDeque{Int}(5)
            @test eltype(D) == Int
            @test eltype(typeof(D)) == Int
            @test capacity(D) == 5
            @test length(D) == 0
            @test isempty(D)
            @test_throws BoundsError first(D)
            @test_throws BoundsError last(D)
            push!(D, 1)
            @test first(D) === last(D) === 1
            push!(D, 2)
            @test first(D) === 1
            @test last(D)  === 2
            @test length(D) == 2
            for i = 3:5
                push!(D, i)
            end
            @test_throws BoundsError push!(D, 6)
            @test popfirst!(D) === 1
            @test first(D) === 2
            @test last(D) === 5
            push!(D, 6)
            @test first(D) === 2
            @test last(D) === 6
            @test pop!(D) === 6
            @test first(D) === 2
            @test last(D) === 5
            pushfirst!(D, 7)
            @test first(D) === 7
            @test last(D) === 5
            @test_throws BoundsError pushfirst!(D, 8)
            @test popfirst!(D) === 7
            @test popfirst!(D) === 2
            @test pop!(D) === 5
            @test popfirst!(D) === 3
            @test pop!(D) === 4
            @test_throws BoundsError pop!(D)
            @test_throws BoundsError popfirst!(D)
            @test isempty(D)
            push!(D, 10)
            @test !isempty(D)
            empty!(D)
            @test isempty(D)
            @test_throws BoundsError first(D)
            push!(D, 20)
            @test first(D) == last(D) == 20
            empty!(D)
            for i = 1:5
                push!(D, i)
            end
            @test popfirst!(D) == 1
            push!(D, 6)
            for i = 2:6
                @test last(D) === 6
                @test D[1] === i
                @test D[7-i] === 6
                @test popfirst!(D) === i
            end
        end

        @testset "pushfirst! works on an empty deque" begin
            # Test that pushfirst! works on an empty deque, and that first/last give the right answer
            D = CircularDeque{Int}(5)
            pushfirst!(D, 30)
            @test first(D) == last(D) == 30
            empty!(D)
            pushfirst!(D, 40)
            @test first(D) == last(D) == 40
        end

        @testset "iteration over loop" begin
            D = CircularDeque{Int}(5)
            for i in 1:5 push!(D, i) end
            @test collect([i for i in D]) == collect(1:5)
        end
    end
end
"""
    )
end # print_bonus_tests

function main()
    canonical_data = tighten(JSON.parse(IO_IN; dicttype=OrderedDict))

    override!(
        canonical_data;
        subheader="""
            # Uncomment the following line to enable bonus tests.
            # enable_bonus_tests = true

            if @isdefined(enable_bonus_tests) && enable_bonus_tests
                println("Bonus tests enabled.\\n")
            else
                println("Bonus tests disabled.\\n")
            end"""
    )

    for case in canonical_data["cases"]
        input = case["input"]
        override!(
            case;
            setup="cb = CircularBuffer{Int}($(input["capacity"]))",
            test=parse_operations(input["operations"]),
        )
    end

    print_runtests(IO_OUT, canonical_data)
    print_custom_tests(IO_OUT)
    print_bonus_tests(IO_OUT)
end

main()
