mutable struct CircularBuffer{T}


    function CircularBuffer{T}(capacity::Integer) where {T}

    end
end

function Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)

end

function Base.popfirst!(cb::CircularBuffer)

end

function Base.empty!(cb::CircularBuffer)

end
