class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.string :player_id
      t.string :player_code
      t.string :year
      t.string :team
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