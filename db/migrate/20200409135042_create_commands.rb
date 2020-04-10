class CreateCommands < ActiveRecord::Migration[5.2]
  def change
    create_table :commands do |t|
      t.string :title, index: true
      t.bigint :games_count

      t.timestamps
    end
  end
end
