class Game < ApplicationRecord
  has_many :commands_games, dependent: :destroy
  has_many :crews, through: :commands_games, source: :command
  has_many :indicators
  validate :commands_persistence

  attr_accessor :commands
  after_create :start_game

  private

  def start_game
    if commands.is_a? Array
      @commands.each { |c| c.send :play_game, self }
    else
      commands.send :play_game, self
    end
  end

  def commands_persistence
    if commands.is_a? Array
      return check_type(commands) if commands.blank?

      commands.each {|command| check_type(command)}
    else
      check_type(commands)
    end
  end

  def check_type(command)
    if command.blank? || (!command.is_a? Command)
      errors.add('command type', 'to play game we need a true commands')
    end
  end
end
