require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should belong_to :command }
  it { should have_many :indicators }

  let!(:command1)    { create(:command) }
  let!(:command2)    { create(:command) }
  let!(:target_ind)  { create(:indicator, kind: 'target', title: 'Goals per game', value: '1') }

  describe 'Player' do
    context 'indicators count' do
      it 'will increase with valid attributes' do
        game = Game.create(commands: [command1, command2])
        player1 = command1.players.create
        player2 = command2.players.create
        expect{player1.gain_indicator(game, target_ind)}.to change{player1.indicators.count}.by(1)
        expect{player2.gain_indicator(game, target_ind)}.to change{player2.indicators.count}.by(1)
      end
      it 'will not increase with valid attributes' do
        game1 = Game.create(commands: command1)
        game2 = Game.create(commands: command2)
        player1 = command1.players.create
        player2 = command2.players.create

        expect{player1.gain_indicator(game1, target_ind)}.to change{player1.indicators.count}.by(1)
        expect{player2.gain_indicator(game2, target_ind)}.to change{player2.indicators.count}.by(1)

        expect{player1.gain_indicator(game2, target_ind)}.to_not change(player1.indicators, :count)
        expect{player2.gain_indicator(game1, target_ind)}.to_not change(player2.indicators, :count)
      end
    end
    context 'player gain indicator?' do
      before { 6.times { Game.create(commands: command1) } }
      it 'will return false' do
        player = command1.players.create
        player.gain_indicator(Game.first, target_ind)
        expect(player.gain_indicator?(target_ind)).to eq false
      end
      it 'will return true' do
        player = command1.players.create
        player.gain_indicator(Game.second, target_ind)
        expect(player.gain_indicator?(target_ind)).to eq true
      end
    end
  end
end
