class CreateCommandsGames < ActiveRecord::Migration[5.2]
  def change
    create_table :commands_games do |t|
      t.integer :command_id
      t.integer :game_id

      t.timestamps
    end
  end
end
