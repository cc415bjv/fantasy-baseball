require 'spec_helper'

describe Player do
  before(:each) do
    @player = Fabricate(:player, :player_code => 'omega')
  end

  context :name do
    it "should return the full name" do
      @player.full_name.should_not be_nil
    end
  end

  context :teams do
    it "should have been a member" do
      statistic = Fabricate(:statistic, :year => 2012)
      @player.team.should == 'Atlanta Braves'
    end
  end

  context :stats do
    it "should have a career batting average" do
      (2007..2012).each do |year|
        Fabricate(:statistic, :year => year, :at_bats => 500, :hits => (2150 - year))
      end
      @player.career_batting_average.should == 0.281
    end
  end

  context :most_improved do
    it "should find the most improved" do
      x = Fabricate(:player, :player_code => 'X')
      y = Fabricate(:player, :player_code => 'Y')
      z = Fabricate(:player, :player_code => 'Z')
      Fabricate(:statistic, player: x, year: 2011, :at_bats => 500, :hits => 100, :runs => 25)
      Fabricate(:statistic, player: x, year: 2012, :at_bats => 500, :hits => 150, :runs => 30)
      Fabricate(:statistic, player: y, year: 2011, :at_bats => 500, :hits => 100, :runs => 25)
      Fabricate(:statistic, player: y, year: 2012, :at_bats => 500, :hits => 160, :runs => 40, :homeruns => 8)
      Fabricate(:statistic, player: z, year: 2011, :at_bats => 500, :hits => 100, :runs => 25)
      Fabricate(:statistic, player: z, year: 2012, :at_bats => 500, :hits => 140, :runs => 20)
      Player.most_improved_fantasy.should == y
    end
  end
end
