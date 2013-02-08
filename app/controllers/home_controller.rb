class HomeController < ApplicationController
  expose(:fantasy_leader) { Player.most_improved_fantasy }
  def index
  end
end
