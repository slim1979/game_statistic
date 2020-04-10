class Player < ApplicationRecord
  belongs_to :command
  has_many :indicators

  def gain_indicator(game, indicator)
    return wrong_game unless player_play_this_game?(game)

    indicators.create(kind: 'player', target_indicator: indicator, game: game)
  end

  def gain_indicator?(indicator)
    indicators.where(target_indicator: indicator, game: command.games.last(5)).count > 0
  end

  private

  def player_play_this_game?(game)
    command.games.include? game
  end

  def wrong_game
    errors.add('wrong game', 'this player didn\'t play this game')
  end
end
