require 'rails_helper'

RSpec.describe FootballPlayer, type: :model do
  describe "#name_brief" do
    it "returns the first name plus last initial" do
      football_player = create(:football_player)

      expect(football_player.name_brief).to eq("J. Elway")
    end
  end
end
