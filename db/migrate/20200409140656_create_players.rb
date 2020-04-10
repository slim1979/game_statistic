class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.belongs_to :command, foreign_key: true
      t.string :name
      t.string :number

      t.timestamps
    end
  end
end
