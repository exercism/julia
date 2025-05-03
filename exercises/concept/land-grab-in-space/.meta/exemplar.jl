struct Coord
    x::UInt16
    y::UInt16
end

@kwdef struct Plot
    bottom_left::Coord
    top_right::Coord
end

is_claim_staked(claim::Plot, register::Set{Plot}) = claim ∈ register

function stake_claim!(claim::Plot, register::Set{Plot})
    is_claim_staked(claim, register) && return false
    push!(register, claim)
    true
end

get_longest_side(claim::Plot) = max(
    claim.top_right.x - claim.bottom_left.x,
    claim.top_right.y - claim.bottom_left.y
    )

function get_claim_with_longest_side(register::Set{Plot})
    claims = collect(register)
    lengths = get_longest_side.(claims)
    maxlen = maximum(lengths)
    result = [claim for (len, claim) in zip(lengths, claims) if len == maxlen]
    length(result) > 1 ? Set(result) : result[1]
end
