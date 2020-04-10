class Command < ApplicationRecord
  has_many :commands_games, dependent: :destroy
  has_many :games, through: :commands_games, dependent: :destroy
  has_many :players, dependent: :destroy

  private

  def play_game(game)
    commands_games.create(command: self, game: game)
  end
end
