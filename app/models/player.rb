class Player < ActiveRecord::Base
  has_many :statistics

  validates_uniqueness_of :player_code

  attr_accessible :birth_year, :first_name, :last_name, :player_code

  paginates_per 10

  def full_name
    [first_name, last_name].join(" ")
  end
  alias :name :full_name

  def career_batting_average
    abs = self.statistics.map{|s|s.at_bats.to_i}.reduce(:+).to_f
    if abs > 0
      (self.statistics.map{|s|s.hits.to_i}.reduce(:+).to_i / abs).round(3)
    else
      abs
    end
  end

  def team
    self.statistics.where(:year => 2012).first.try(:team).name
  end

  def self.most_improved_fantasy
    find(Statistic.most_improved_points.first[:player_id])
  end
end
