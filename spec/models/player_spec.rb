require 'rails_helper'

RSpec.describe Player, type: :model do
  describe "import_players!" do
    it "creates basketball player models" do
      #by default, this is stubbed out to return 2 results
      player_data_source = PlayerDataSource.new

      expect {
        Player.import_players!(player_data_source, ['basketball'])
      }.to change { BasketballPlayer.count }.by(2)
    end

    it "creates football player models" do
      player_data_source = PlayerDataSource.new

      expect {
        Player.import_players!(player_data_source, ['football'])
      }.to change { FootballPlayer.count }.by(2)
    end

    it "creates basketball player models" do
      player_data_source = PlayerDataSource.new

      expect {
        Player.import_players!(player_data_source, ['baseball'])
      }.to change { BaseballPlayer.count }.by(2)
    end
  end
end