function score(dice, category)
  score_side = f(s) = count(die -> die == s, dice) * s
  if category == "yacht"
      length(unique(dice)) == 1 ? 50 : 0
  elseif category == "ones"
      score_side(1)
  elseif category == "twos"
      score_side(2)
  elseif category == "threes"
      score_side(3)
  elseif category == "fours"
      score_side(4)
  elseif category == "fives"
      score_side(5)
  elseif category == "sixes"
      score_side(6)
  elseif category == "full house"
      counts = Dict(die => count(==(die), dice) for die in unique(dice))
      vals = values(counts)
      2 in vals && 3 in vals ? sum(dice) : 0
  elseif category == "four of a kind"
      counts = Dict(die => count(==(die), dice) for die in unique(dice))
      match = findfirst(v -> v >= 4, counts)
      !isnothing(match) ? match * 4 : 0
  elseif category == "little straight"
      sort(dice) == [1, 2, 3, 4, 5] ? 30 : 0
  elseif category == "big straight"
      sort(dice) == [2, 3, 4, 5, 6] ? 30 : 0
  elseif category == "choice"
      sum(dice)
  else
      0
  end
end

