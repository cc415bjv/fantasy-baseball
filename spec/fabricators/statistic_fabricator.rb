Fabricator(:statistic) do
  player {Player.last || Fabricate(:player)}
  year            "2007"
  team {Team.last || Fabricate(:team)}
  games           1
  at_bats         1
  runs            1
  hits            1
  doubles         1
  triples         1
  homeruns        1
  rbis            1
  stolen_bases    0
  caught_stealing 0
end
