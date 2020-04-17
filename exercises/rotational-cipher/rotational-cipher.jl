"""
    rotate(n, str)
    rotate(n, char::Char)

Using a caesar cipher, rotate the alphabetic characters n places each.

"""
rotate(n, str) =
    map(c -> rotate(n, c), str)

function rotate(n, char::Char)
    if 'a' <= char <= 'z'
        (char - 'a' + n) % 26 + 'a'
    elseif 'A' <= char <= 'Z'
        (char - 'A' + n) % 26 + 'A'
    else
        char
    end
end

rotate(n, str) =
    map(rotater('a':'z', n) ∘ rotater('A':'Z', n), str)

# Just to pass the tests
rotate(n, char::Char) = first(rotate(n, string(char)))

"""
    rotater(alphabet, n)

Return a function that'll rotate a single character `n` places if it is in `alphabet`.

"""
rotater(alphabet, n) = char ->
    if char in alphabet
        alphabet[mod1(findfirst(==(char), alphabet) + n, length(alphabet))]
    else
        char
    end

# Bonus
for i in 1:25
    eval(:(
        macro $(Symbol("R$(i)_str"))(str)
            rotate($i, str)
        end))
end

"""
So `eval` takes a quoted expression and evaluates it. We can express quoted expressions with the `:( )` syntax or `quote ... end`.

Let's eval a single macro:

```julia
eval(:(
    macro R1_str(str)
        rotate(1, str)
    end))
```

Simple enough, but we want to substitute in some values, so let's do that. `$expr` and `$(expr)` evaluate expr in the calling context and substitutes that in to the quote.

```julia
i = 10
eval(:(
    macro R$(i)_str(str)
        rotate($i, str)
    end))
```

But that doesn't work, you can't just substitute into a symbol like that. We need to make a symbol programmatically:

```julia
eval(:(
    macro $(Symbol("R$(i)_str"))(str)
        rotate($i, str)
    end))
```

(`Symbol("R", i, "_str")` would also have been fine)

Now all we need is to wrap that in a for loop:

```julia
for i in 1:25
    eval(:(
        macro $(Symbol("R$(i)_str"))(str)
            rotate($i, str)
        end))
end
```

#= for i in 1:26 =#
#=     quote =#
#=         macro $(Symbol("R$(i)_str"))(input) =#
#=             rotate($(i), input) =#
#=         end =#
#=     end |> eval =#
#= end =#

# Precomputing the index and views:
#
#= function rotate(str, n) =#
#=     rotated_index = [mod1(n+1, 26):26; 1:mod1(n+1, 26)-1] =#
#=     acc = "" =#
#=     for char in str =#
#=         idx = findfirst(==(char), 'a':'z') =#
#=         if !isnothing(idx) =#
#=             char = view('a':'z', rotated_index)[idx] =#
#=         end =#
#=         acc *= char =#
#=     end =#
#=     acc =#
#= end =#

ispangram1(input) = Set(lowercase(input)) >= Set('a':'z')
ispangram2(input) = all(in(lowercase(input)), 'a':'z')

# Very fast, but less clear and only works for ASCII
function ispangram3(input)
    present = repeat([false], 26)
    @inbounds for i in 1:ncodeunits(input)
        c = codeunit(input, i)
        if 0x61 <= c <=  0x7a
            present[c - 0x60] = true
        elseif 0x41 <= c <= 0x5a
            present[c - 0x40] = true
        end
    end
    all(present)
end

using BenchmarkTools

pangram = "the quick brown fox jumps over the lazy dog"

@btime ispangram1($pangram)
@btime ispangram2($pangram)
@btime ispangram3($pangram)

const NUCLEOTIDES = ['C','G','A','T']

function count_nucleotides_nosanitise(strand::AbstractString)
    try
        Dict(n=>mapreduce(x->x==n,+,a for a in strand) for n in NUCLEOTIDES)
    catch(e)
        # This is a (slightly hacky) way of detecting that strand is empty,
        # as reductions over empty strings are not allowed.
        # It is much faster than checking the length!
        isa(e,ArgumentError) && e.msg == "reducing over an empty collection is not allowed" && return Dict('C' => 0, 'G' => 0, 'A' => 0, 'T' => 0)
        throw(e)
    end
end

function count_nucleotides_nosanitise(strand::AbstractString)
    Dict(n => mapreduce(==(n), +, strand, init = 0) for n in "ACGT")
end

function count_nucleotides_nosanitise(strand::AbstractString)
    Dict(n => sum(==(n), strand) for n in "ACGT")
end

function count_nucleotides(strand)
    counts = Dict(b => 0 for b in "ACGT")
    for b in strand
        if haskey(counts, b)
            counts[b] += 1
        else
            throw(DomainError(b))
        end
    end
    counts
end

function count_nucleotides2(strand)
    counts = zeros(Int, 4)
    @inbounds for b in strand
        if b == 'A'
            counts[1] += 1
        elseif b == 'C'
            counts[2] += 1
        elseif b == 'G'
            counts[3] += 1
        elseif b == 'T'
            counts[4] += 1
        else
            throw(DomainError(b, "invalid base"))
        end
    end
    Dict(b => f for (b, f) in zip("ACGT", counts))
end

function count_nucleotides3(strand)
    counts = zeros(Int, 4)
    @inbounds for i in 1:ncodeunits(strand)
        b = codeunit(strand, i)
        if b == UInt('A')
            counts[1] += 1
        elseif b == UInt('C')
            counts[2] += 1
        elseif b == UInt('G')
            counts[3] += 1
        elseif b == UInt('T')
            counts[4] += 1
        else
            throw(DomainError(b, "invalid base"))
        end
    end
    Dict(b => f for (b, f) in zip("ACGT", counts))
end

strand = join(rand("ACGT", 100_000_000));

using BenchmarkTools

@btime count_nucleotides_nosanitise($strand)
@btime count_nucleotides($strand)
@btime count_nucleotides3($strand)
@btime count_nucleotides2($strand)
@btime count_nucleotides4($strand)
@btime count_nucleotides5($strand)
count_nucleotides_nosanitise("")

codeunits("foobar")

function count_nucleotides4(strand::AbstractString)
    rs = zeros(Int,length(NUCLEOTIDES))
    l = Dict(v=>i for (i,v) in enumerate(NUCLEOTIDES))
    try
        for s in strand
            # Inbounds gives us a ~10% speedup
            @inbounds rs[l[s]] += 1
        end
    catch(e)
        isa(e,KeyError) && throw(DomainError(e))
        throw(e)
    end
    Dict(k=>rs[v] for (k,v) in l)
end

function count_nucleotides5(strand::AbstractString)
    rs = zeros(Int,length(NUCLEOTIDES))
    l = Dict(v=>i for (i,v) in enumerate(NUCLEOTIDES))
    for s in strand
        idx = get(l, s, 0)
        if idx == 0
            throw(DomainError(s))
        else
            # Inbounds gives us a ~10% speedup
            @inbounds rs[idx] += 1
        end
    end
    Dict(k=>rs[v] for (k,v) in l)
end
