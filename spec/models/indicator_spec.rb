require 'rails_helper'

def create_games(commands)
  10.times do
    game = Game.create(commands: commands)
    5.times{ |n| gain_indicators(n, commands, game) }
  end
end

def gain_indicators(n, commands, game)
  commands.each do |command|
    command.players.last(n + 1).each do |p|
      p.gain_indicator(game, target_ind)
    end
  end
end

RSpec.describe Indicator, type: :model do
  it { should belong_to(:player).optional }
  it { should belong_to(:game).optional }
  it { should validate_presence_of :kind }

  let!(:command1)    { create(:command) }
  let!(:command2)    { create(:command) }
  let!(:target_ind)  { create(:indicator, kind: 'target', title: 'Goals per game', value: '1') }

  describe 'Top players' do
    context 'should get top players of current indicator' do
      before { 10.times { command1.players.create } }

      it 'from command' do
        create_games([command1])
        top_players = target_ind.top_players(scope: command1)
        expect(top_players.first(5)).to match_array(command1.players.last(5))
      end

      it 'from all scope' do
        10.times { command2.players.create }
        create_games([command1, command2])

        top_players = target_ind.top_players
        players     = Player.includes(:indicators).references(:indicators)
        expect(top_players.first(5)).to match_array players.sort { |a, b| a.indicators.count <=> b.indicators.count }.reverse.first(5)
      end
    end
  end
end
