import Base: ==

mutable struct Point{T<:Number}
    x::T
    y::T
end

==(p::Point, q::Point) = p.x == q.x && p.y == q.y

@enum Heading NORTH=1 EAST=2 SOUTH=3 WEST=4

mutable struct Robot
    position::Point
    heading::Heading
end

function Robot(position::Tuple{T, T}, heading::Heading) where T<:Number
    Robot(Point(position...), heading)
end

heading(r::Robot) = r.heading
position(r::Robot) = r.position

function turn_right!(r::Robot)
    r.heading = Heading(mod1(Int(r.heading) + 1, 4))
    r
end

function turn_left!(r::Robot)
    r.heading = Heading(mod1(Int(r.heading) - 1, 4))
    r
end

function advance!(r::Robot)
    if heading(r) == NORTH
        r.position.y += 1
    elseif heading(r) == SOUTH
        r.position.y -= 1
    elseif heading(r) == EAST
        r.position.x += 1
    else
        r.position.x -= 1
    end
    r
end

function move!(r::Robot, instructions::AbstractString)
    moves = Dict('A' => advance!, 'R' => turn_right!, 'L' => turn_left!)
    for move in instructions
        move in keys(moves) && moves[move](r)
    end
    r
end
