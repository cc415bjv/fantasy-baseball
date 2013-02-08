class Statistic < ActiveRecord::Base
  attr_accessible :at_bats, :caught_stealing, :doubles, :games, :hits, :homeruns, :player_id, :rbis, :runs, :stolen_bases, :team_id, :triples, :year

  belongs_to :player
  belongs_to :team

  delegate :name, :code, :league, to: :team, :prefix => true, :allow_nil => true
  delegate :name, :first_name, :last_name, to: :player, :prefix => true, :allow_nil => true

  scope :team_stats, lambda{|team,year|includes(:team).where('teams.code = ? and statistics.year = ?',team,year)}
  scope :minimum_at_bats, lambda{|num,start_year,end_year| where("at_bats >= ? and year in (?)",num,[start_year,end_year])}

  def batting_average
    abs = self.at_bats.to_f
    abs > 0 ? (self.hits.to_f / abs).round(3) : 0
  end

  def slugging_pct
    abs = self.at_bats.to_f
    abs > 0 ? ([(self.hits.to_i - self.doubles.to_i - self.triples.to_i - self.homeruns.to_i),(2 * self.doubles.to_i),(3 * self.triples.to_i),(4 * self.homeruns.to_i)].inject(:+) / abs).round(3) : 0
  end

  def fantasy_points
    [(self.homeruns.to_i * 4),self.rbis.to_i,self.stolen_bases.to_i].inject(:+) - self.caught_stealing.to_i
  end

  def self.most_improved_avg
    statistics = minimum_at_bats(200,2009,2010).order('player_id, year desc').group_by(&:player_id)
    rankings = []
    statistics.each do |pid,stats|
      if stats.count > 1
        improvement = (stats.first.batting_average * 1.0 / stats.last.batting_average).to_f
        rankings << {player_id: pid, improvement: improvement}
      end
    end
    rankings.sort_by{|k|k[:improvement]}.reverse
  end

  def self.most_improved_points
    statistics = minimum_at_bats(500,2011,2012).order('player_id, year desc').group_by(&:player_id)
    rankings = []
    statistics.each do |pid,stats|
      if stats.count > 1
        improvement = (stats.first.fantasy_points * 1.0 / stats.last.fantasy_points).to_f
        rankings << {player_id: pid, improvement: improvement}
      end
    end
    rankings.sort_by{|k|k[:improvement]}.reverse
  end

  def self.tc_winner(league,year,at_bats)
    leaders = []
    leaders << includes(:team).where("statistics.year = ? and teams.league = ?",year, league).order('homeruns desc').first
    leaders << includes(:team).where("statistics.year = ? and teams.league = ?",year, league).order('rbis desc').first
    leaders << includes(:team).where("teams.league = ? and year = ? and at_bats > ?",league,year,at_bats).sort_by{|s|s.batting_average}.reverse.first
    leaders.group_by(&:player_id).first.last.count == 3 ? leaders.first.player.full_name : 'No Winner'
  end
end
