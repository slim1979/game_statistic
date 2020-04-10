class CreateIndicators < ActiveRecord::Migration[5.2]
  def change
    create_table :indicators do |t|
      t.belongs_to :player, foreign_key: true, index: true
      t.belongs_to :game, foreign_key: true, index: true
      t.string :kind, index: true
      t.string :title
      t.string :value
      t.boolean :gained

      t.timestamps
    end
  end
end
