using Dates
using Printf

import Base: show, +, -

"Clock that displays 24 hour clock that rolls over properly"
struct Clock{T<:Integer}
    h::T
    min::T

    function Clock(h::T, min::T) where {T}
        h += fld(min, 60)
        h %= 24
        min %= 60
        if h < 0
            h += 24
        end
        if min < 0
            min += 60
        end
        new{T}(h, min)
    end
end

show(io::IO, c::Clock) = show(io, @sprintf("%02d:%02d", c.h, c.min))

+(c::Clock, min::Dates.Minute) = Clock(c.h, c.min + min.value)
-(c::Clock, min::Dates.Minute) = Clock(c.h, c.min - min.value)
