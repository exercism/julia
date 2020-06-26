module CircularBuffers

using Base: @propagate_inbounds
using Printf

export CircularBuffer, capacity, isfull

const OVERWRITE = false

"""
    CircularBuffer{T} <: AbstractVector{T}

Circular buffer with elements of type `T`, useful as a FIFO or LIFO queue with fixed
capacity.

Optimized for inserting elements at the end¸ so `push!` performs better (~1.5x faster)
than `pushfirst!`. Deleting elements at either end (`pop!`, and `popfirst!`) as well as
`getindex` and `setindex!` on random elements are all efficient.

---

    CircularBuffer(v::Vector{T}) -> CircularBuffer{T}

Construct a `CircularBuffer{T}` using `v` as the backing data without copying. Its capacity
and length are equal to `length(v)`.
"""
mutable struct CircularBuffer{T} <: AbstractVector{T}
    length::Int  # number of inserted items
    lastindex::Int  # index in data of the last (i.e., most-recently push!ed) item
    data::Vector{T}

    CircularBuffer(v::Vector{T}) where {T} = (n = length(v); new{T}(n, n, v))
end

CircularBuffer{T}(v::Vector{T}) where {T} = CircularBuffer(v::Vector{T})

"""
    CircularBuffer{T}([undef,] capacity::Int) -> CircularBuffer{T}

Construct a `CircularBuffer{T}` that stores at most `capacity` elements. If `undef` is
provided, then the circular buffer is full; otherwise it is empty. In either case the
underlying backing data is an uninitialized vector of length `capacity`.
"""
function CircularBuffer{T}(::UndefInitializer, n::Integer) where {T}
    n >= 0 || throw(ArgumentError("Capacity must be nonnegative."))
    return CircularBuffer(Vector{T}(undef, n))
end

function CircularBuffer{T}(n::Integer) where {T}
    cb = CircularBuffer{T}(undef, n)
    cb.length = 0
    return cb
end

Base.size(cb::CircularBuffer) = (cb.length,)
Base.empty!(cb::CircularBuffer) = (cb.length = 0; cb)

"""
    capacity(cb::CircularBuffer) -> Int

Return the maximum number of elements that `cb` can store.
"""
capacity(cb::CircularBuffer) = length(cb.data)

"""
    isfull(cb::CircularBuffer) -> Bool

Return `true` if `cb` cannot insert a new item without overwriting an old item, and `false`
otherwise.
"""
isfull(cb::CircularBuffer) = length(cb) == capacity(cb)

"""
    _dataindex(cb::CircularBuffer, i::Integer) -> Int

Given an index `i` of `cb`, return the corresponding index `j` of `cb.data` such that `cb[i]
== cb.data[j]`.
"""
@inline function _dataindex(cb::CircularBuffer, i::Integer)
    @boundscheck checkbounds(cb, i)
    j = cb.lastindex - length(cb) + i
    return j < 1 ? j + length(cb.data) : j
end

@propagate_inbounds function Base.getindex(cb::CircularBuffer, i::Integer)
    j = _dataindex(cb, i)
    @inbounds return cb.data[j]
end

@propagate_inbounds function Base.setindex!(cb::CircularBuffer, item, i::Integer)
    j = _dataindex(cb, i)
    @inbounds return cb.data[j] = item
end

"""
    push!(cb::CircularBuffer, items...; overwrite=$OVERWRITE) -> cb

Insert each item from `items` to the end of `cb`, then return `cb`. `overwrite` determines
whether items at the beginning of `cb` can be removed to provide space for new items. If
`overwrite=false` and `push!` attempts to insert an item into a full `CircularBuffer`, then
throw a `BoundsError`.
"""
@inline function Base.push!(cb::CircularBuffer, item; overwrite::Bool=OVERWRITE)
    full = isfull(cb)
    @boundscheck overwrite || !full || throw(BoundsError(cb, length(cb) + 1))
    i = cb.lastindex
    cb.lastindex = (i == capacity(cb) ? 1 : i + 1)
    @inbounds cb.data[cb.lastindex] = item
    !full && (cb.length += 1)
    return cb
end

@propagate_inbounds Base.push!(cb::CircularBuffer, itr...; kw...) = append!(cb, itr; kw...)

@propagate_inbounds function Base.append!(cb::CircularBuffer, itr; kw...)
    for item in itr
        push!(cb, item; kw...)
    end
    return cb
end

"""
    pushfirst!(cb::CircularBuffer, item; overwrite=$OVERWRITE) -> cb

Like `push!`, but insert item to the *beginning* of `cb`. See [`push!`](@ref).

Note that `pushfirst!(cb::CircularBuffer, items...)` and
`prepend!(cb::CircularBuffer, items)` are overridden to throw `MethodError` due to ambiguity
about the order of insertion.
"""
@inline function Base.pushfirst!(cb::CircularBuffer, item; overwrite::Bool=OVERWRITE)
    full = isfull(cb)
    @boundscheck overwrite || !full || throw(BoundsError(cb, 0))
    if full
        i = cb.lastindex
        cb.lastindex = (i == 1 ? capacity(cb) : i - 1)
    else
        cb.length += 1
    end
    @inbounds cb[1] = item
    return cb
end

Base.pushfirst!(cb::CircularBuffer, args...) = throw(MethodError(pushfirst!, (cb, args...)))
Base.prepend!(cb::CircularBuffer, args...) = throw(MethodError(pushfirst!, (cb, args...)))

@propagate_inbounds function Base.popfirst!(cb::CircularBuffer)
    out = first(cb)
    cb.length -= 1
    return out
end

@propagate_inbounds function Base.pop!(cb::CircularBuffer)
    out = last(cb)
    cb.length -= 1
    i = cb.lastindex
    cb.lastindex = (i == 1 ? capacity(cb) : i - 1)
    return out
end

function Base.show(io::IO, cb::CircularBuffer)
    print(io, "CircularBuffer(")
    Base.show_vector(io, cb)
    print(io, ')')
end

function Base.summary(io::IO, cb::CircularBuffer)
    n = length(cb)
    Base.showarg(io, cb, true)
    @printf(io, " with %s element%s and %s capacity", n, n == 1 ? "" : "s", capacity(cb))
end

end  # module CircularBuffers

using .CircularBuffers

enable_bonus_tests = true
