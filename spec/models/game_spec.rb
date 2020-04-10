require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should have_many(:commands_games).dependent(:destroy)  }
  it { should have_many(:crews).through(:commands_games)  }
  it { should have_many(:indicators)  }

  let!(:command1) { create(:command) }
  let!(:command2) { create(:command) }

  describe 'validate command persistence' do
    context 'with valid attributes' do
      it 'will create game' do
        expect{Game.create(commands: command1)}.to change(Game, :count).by(1)
        expect{Game.create(commands: [command1, command2])}.to change(Game, :count).by(1)
      end
      it 'will create commands_games' do
        expect{Game.create(commands: command1)}.to change(CommandsGame, :count).by(1)
        expect{Game.create(commands: [command1, command2])}.to change(CommandsGame, :count).by(2)
      end
    end

    context 'with invalid attributes' do
      it 'will not change db' do
        expect { Game.create(commands: ['a', 'b']) }.to_not change(Game, :count)
        expect { Game.create(commands: [{a: 'a'}, {b: 'b'}]) }.to_not change(Game, :count)
        expect { Game.create(commands: ['a']) }.to_not change(Game, :count)
        expect { Game.create(commands: []) }.to_not change(Game, :count)
        expect { Game.create(commands: '') }.to_not change(Game, :count)
        expect { Game.create(commands: nil) }.to_not change(Game, :count)
      end
    end
  end
end
