require 'rails_helper'

RSpec.describe Command, type: :model do
  it { should have_many(:players).dependent(:destroy) }
  it { should have_many(:commands_games).dependent(:destroy)  }
  it { should have_many(:games).through(:commands_games).dependent(:destroy) }
end
