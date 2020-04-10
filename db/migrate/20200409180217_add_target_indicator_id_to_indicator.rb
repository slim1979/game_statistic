class AddTargetIndicatorIdToIndicator < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :indicators, :target_indicator, index: true
  end
end
