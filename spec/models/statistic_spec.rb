require 'spec_helper'

describe Statistic do

  context :batting_average do
    before(:each) do
      @player = Fabricate(:player, :player_code => 'Peewee')
    end

    it "should have a batting average" do
      @statistic = Fabricate(:statistic, year: 2012, at_bats: 500, hits: 100)
      @statistic.batting_average.should == 0.200
    end
  end

  context :slugging_pct do
    before(:each) do
      @player = Fabricate(:player, :player_code => 'Posey')
    end

    it "should have a batting average" do
      @statistic = Fabricate(:statistic, year: 2012, at_bats: 530, hits: 178, doubles: 39, triples: 1, homeruns: 24)
      @statistic.slugging_pct.should == 0.549
    end
  end

  context :fantasy_points do
    before(:each) do
      @player = Fabricate(:player, :player_code => 'Posey')
    end

    it "should have a batting average" do
      @statistic = Fabricate(:statistic, year: 2012, at_bats: 530, hits: 178, doubles: 39, triples: 1, homeruns: 24, rbis: 103)
      @statistic.fantasy_points.should == 199
    end
  end

  context :most_improved do
    before(:each) do
      @playerA = Fabricate(:player, :player_code => 'A')
      @statistic = Fabricate(:statistic, year: 2009, at_bats: 500, hits: 100, rbis: 20)
      @statistic = Fabricate(:statistic, year: 2010, at_bats: 600, hits: 200, rbis: 30)
      @statistic = Fabricate(:statistic, year: 2011, at_bats: 500, hits: 130, rbis: 35)
      @statistic = Fabricate(:statistic, year: 2012, at_bats: 550, hits: 140, rbis: 45)
      @playerB = Fabricate(:player, :player_code => 'B')
      @statistic = Fabricate(:statistic, year: 2009, at_bats: 500, hits: 100, rbis: 35)
      @statistic = Fabricate(:statistic, year: 2010, at_bats: 510, hits: 200, rbis: 45)
      @statistic = Fabricate(:statistic, year: 2011, at_bats: 505, hits: 120, rbis: 50)
      @statistic = Fabricate(:statistic, year: 2012, at_bats: 555, hits: 155, rbis: 62)
      @playerC = Fabricate(:player, :player_code => 'C')
      @statistic = Fabricate(:statistic, year: 2009, at_bats: 500, hits: 100, rbis: 35)
      @statistic = Fabricate(:statistic, year: 2010, at_bats: 520, hits: 200, rbis: 55)
      @statistic = Fabricate(:statistic, year: 2011, at_bats: 510, hits: 145, rbis: 45)
      @statistic = Fabricate(:statistic, year: 2012, at_bats: 560, hits: 150, rbis: 55)
    end

    it "should determine the most improved between 2009 and 2010" do
      improved = Statistic.most_improved_avg
      improved.first[:player_id].should == @playerB.id
    end

    it "should have fantasy points" do
      @playerC.statistics.last.fantasy_points.should be > 5
    end

    it "should determine the most improved points between 2011 and 2012" do
      Statistic.most_improved_points.first[:player_id].should == @playerA.id
    end
  end

  context :triple_crown do
    before(:each) do
      @playerA = Fabricate(:player, :player_code => 'A')
      Fabricate(:statistic, year: 2012, at_bats: 550, hits: 140, homeruns: 11, rbis: 30)
      @playerB = Fabricate(:player, :player_code => 'B')
      Fabricate(:statistic, year: 2012, at_bats: 555, hits: 155, homeruns: 12, rbis: 50)
      @playerC = Fabricate(:player, :player_code => 'C')
      Fabricate(:statistic, year: 2012, at_bats: 540, hits: 145, homeruns: 8, rbis: 25)
    end

    it "should have a team that belongs in a league" do
      Statistic.first.team.league.should == 'National'
    end

    it "should find the triple crown winner" do
      Statistic.tc_winner('National',2012,200).should_not == 'No Winner'
    end

  end
end
