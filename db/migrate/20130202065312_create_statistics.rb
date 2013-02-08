class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :player_id
      t.integer :year
      t.integer :team_id
      t.integer :games
      t.integer :at_bats
      t.integer :runs
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :homeruns
      t.integer :rbis
      t.integer :stolen_bases
      t.integer :caught_stealing

      t.timestamps
    end
  end
end
