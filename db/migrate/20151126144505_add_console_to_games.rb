class AddConsoleToGames < ActiveRecord::Migration
  def change
    add_column :games, :console, :string
  end
end
