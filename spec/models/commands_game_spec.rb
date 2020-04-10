require 'rails_helper'

RSpec.describe CommandsGame, type: :model do
  it { should belong_to :command }
  it { should belong_to :game }
  it { should validate_uniqueness_of(:command_id).scoped_to(:game_id) }
end
