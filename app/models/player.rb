class Player < ActiveRecord::Base
  has_many :statistics

  validates_uniqueness_of :player_code

  attr_accessible :birth_year, :first_name, :last_name, :player_code

  def full_name
    [first_name, last_name].join(" ")
  end

  def career_batting_average
    (self.statistics.map(&:hits).reduce(:+).to_i / self.statistics.map(&:at_bats).reduce(:+).to_f).round(3) 
  end

  def team
    self.statistics.order(:year).first.try(:team)
  end
end
