class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.date :release_date
      t.string :region
      t.string :boxart
      t.string :tags

      t.timestamps
    end
  end
end
