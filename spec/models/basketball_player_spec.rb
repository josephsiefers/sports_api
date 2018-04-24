require 'rails_helper'

RSpec.describe BasketballPlayer, type: :model do
  describe "#name_brief" do
    it "returns the first name plus last initial" do
      basketball_player = create(:basketball_player)

      expect(basketball_player.name_brief).to eq("Kevin D.")
    end
  end
end
