require 'fileutils'
require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
puts 'DEFAULT USERS'
#user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
#puts 'user: ' << user.name

if true
  puts "Populating Players..."
  Player.destroy_all
  open("#{Rails.root}/db/Master-small.csv") do |players|
    players.read.each_line do |r|
      player_id,birth_year,first_name,last_name = r.chomp.split(",")
      if first_name != 'nameFirst'
        if birth_year.to_i > 1957
          begin
            Player.create!(player_code: player_id, birth_year: birth_year, first_name: first_name, last_name: last_name)
            puts "Adding #{[first_name,last_name].join(" ")}"
          rescue
            puts "Duplicate #{player_id} with #{first_name}, #{last_name}"
          end
        end
      end
    end
  end
end

if true
  puts "Populating Statistics..."
  Statistic.destroy_all
  Team.destroy_all
  pc = nil
  player = nil
  open("#{Rails.root}/db/Batting-07-12.csv") do |stats|
    stats.read.each_line do |r|
      player_code,year,team_code,games,ab,runs,hits,doubles,triples,hr,rbi,sb,cs = r.chomp.split(",")
      if player_code != pc
        player = Player.where(player_code: player_code).first
        pc = player_code
      end
      unless team_code == 'teamID'
        team = Team.find_or_create_by_code(team_code)
        if ['ATL','CHN','CIN','COL','LAN','MIA','MIL','NYN','PHI','PIT','ARI','SDN','SLN','SFN','WAS'].include? team.code
          team.league = 'National'
        else
          team.league = 'American'
        end
        team.save
      end
      if player
        Statistic.create!(player_id: player.id, year: year, team_id: team.id, games: games,
          at_bats: ab, runs: runs, hits: hits, doubles: doubles, triples: triples, homeruns: hr, rbis: rbi, stolen_bases: sb,
          caught_stealing: cs)
        #puts "Adding #{player_code}"
      end
    end
  end
end
