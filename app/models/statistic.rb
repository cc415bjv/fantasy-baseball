class Statistic < ActiveRecord::Base
  attr_accessible :at_bats, :caught_stealing, :doubles, :games, :hits, :homeruns, :player_code, :player_id, :rbis, :runs, :stolen_bases, :team, :triples, :year

  def batting_average
    (self.hits.to_f / self.at_bats.to_f).round(3)
  end

  def slugging_pct
    ([(self.hits.to_i - self.doubles.to_i - self.triples.to_i - self.homeruns.to_i),(2 * self.doubles.to_i),(3 * self.triples.to_i),(4 * self.homeruns.to_i)].inject(:+) / self.at_bats.to_f).round(3)
  end

  def fantasy_points
    [(self.homeruns.to_i * 4),self.rbis.to_i,self.stolen_bases.to_i].inject(:+) - self.caught_stealing.to_i
  end
end
