class Team < ActiveRecord::Base
  attr_accessible :code, :league, :name
  has_many :statistics
end
