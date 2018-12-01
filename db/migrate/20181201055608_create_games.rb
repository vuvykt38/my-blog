class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :black_player, foreign_key: { to_table: :users }
      t.references :white_player, foreign_key: { to_table: :users }
      t.boolean :public, default: true
      t.string :status
      t.string :player_turn
      t.json :board
      t.integer :move_timeout
      t.timestamps
    end
  end
end
