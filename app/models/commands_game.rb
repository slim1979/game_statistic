class CommandsGame < ApplicationRecord
  belongs_to :command
  belongs_to :game

  validates :command_id, uniqueness: { scope: :game_id }
end
