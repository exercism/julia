# Mentoring note: CircularDeque below is sufficient to complete the exercise without bonus
# tasks. The lengthier CircularBuffer afterward completes the bonus tasks and is optimized
# for performance.

module CircularDeques

"""
    CircularDeque{T}(n)

Empty circular deque with capacity for `n` elements of type `T`.
"""
mutable struct CircularDeque{T}
    length::Int  # number of inserted items
    # Can use firstindex instead. When fully optimized, tracking lastindex leads to a faster
    # push! whereas firstindex leads to a faster pushfirst!. Alternatively, instead of
    # tracking length and one end, can track both ends for symmetric performance.
    lastindex::Int  # index in data of the last (i.e., most-recently push!ed) item
    data::Vector{T}

    CircularDeque{T}(n) where {T} = new(0, n, Vector{T}(undef, n))
end

Base.length(cd::CircularDeque) = cd.length
Base.isempty(cd::CircularDeque) = length(cd) == 0
capacity(cd::CircularDeque) = length(cd.data)
isfull(cd::CircularDeque) = length(cd) == capacity(cd)

Base.empty!(cd::CircularDeque) = (cd.length = 0; cd)

function Base.push!(cd::CircularDeque, item; overwrite::Bool=false)
    overwrite || !isfull(cd) || throw(BoundsError(cd, length(cd) + 1))
    cd.lastindex = mod1(cd.lastindex + 1, capacity(cd))
    cd.data[cd.lastindex] = item
    cd.length = min(capacity(cd), cd.length + 1)
    return cd
end

function Base.popfirst!(cd::CircularDeque)
    !isempty(cd) || throw(BoundsError(cd, 0))
    i = mod1(cd.lastindex - length(cd) + 1, capacity(cd))
    cd.length -= 1
    return cd.data[i]
end

end  # module CircularDeques

using .CircularDeques


module CircularBuffers

using Base: @propagate_inbounds
using Printf

export CircularBuffer, capacity, isfull

"""
    CircularBuffer{T}(n) <: AbstractVector{T}

Empty circular buffer with capacity for `n` elements of type `T`.

`CicularBuffer`s are optimized for inserting elements at the end¸ so `push!` performs better
(~1.5x faster) than `pushfirst!`. Deleting elements at either end (`pop!`, and `popfirst!`)
as well as `getindex` and `setindex!` on random elements are all efficient.
"""
mutable struct CircularBuffer{T} <: AbstractVector{T}
    length::Int  # number of inserted items
    lastindex::Int  # index in data of the last (i.e., most-recently push!ed) item
    data::Vector{T}

    CircularBuffer{T}(n) where {T} = new(0, n, Vector{T}(undef, n))
end

# Plain arrays are IndexLinear, but AbstractArrays are IndexCartesian by default for
# compatibility reasons that are irrelevant here. IndexLinear provides speedups in some
# specialized code in Base.
Base.IndexStyle(::Type{<:CircularBuffer}) = IndexLinear()

Base.size(cb::CircularBuffer) = (cb.length,)
Base.empty!(cb::CircularBuffer) = (cb.length = 0; cb)

"""
    capacity(cb::CircularBuffer) -> Int

Return the maximum number of elements that `cb` can store.
"""
capacity(cb::CircularBuffer) = length(cb.data)

"""
    isfull(cb::CircularBuffer) -> Bool

Determine whether `cb` is full.
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
    return j < 1 ? j + length(cb.data) : j  # optimized vs mod1
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
    push!(cb::CircularBuffer, items...; overwrite=false) -> cb

Insert each item from `items` to the end of `cb`, then return `cb`. `overwrite` determines
whether items at the beginning of `cb` can be removed to provide space for new items. If
`overwrite=false` and `push!` attempts to insert an item into a full `CircularBuffer`, then
throw a `BoundsError`.
"""
@inline function Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)
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
    pushfirst!(cb::CircularBuffer, item; overwrite=false) -> cb

Like `push!`, but insert `item` to the *beginning* of `cb`. See [`push!`](@ref).

Note that `pushfirst!(cb::CircularBuffer, items...)` and
`prepend!(cb::CircularBuffer, items)` are overridden to throw `MethodError` due to ambiguity
about the order of insertion.
"""
@inline function Base.pushfirst!(cb::CircularBuffer, item; overwrite::Bool=false)
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

end  # module CircularBuffers

using .CircularBuffers

enable_bonus_tests = true
