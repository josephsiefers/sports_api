require 'rails_helper'

RSpec.describe BaseballPlayer, type: :model do
  describe "#name_brief" do
    it "returns the first name plus last initial" do
      baseball_player = create(:baseball_player)

      expect(baseball_player.name_brief).to eq("B. R.")
    end
  end
end