require 'rails_helper'

RSpec.describe Player, type: :model do
  describe ".import_players!" do
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


  describe ".average_position_age" do
    it "returns zero if no players match the specified type" do
      create_list(:baseball_player, 3)
      expect(Player.average_position_age("SoccerPlayer", "GK")).to eq(nil)
    end

    it "returns zero if no players match the specified position" do
      create_list(:baseball_player, 3)
      expect(Player.average_position_age("BaseballPlayer", "GK")).to eq(nil)
    end

    it "calculates an average from players belonging to the same sport and position" do
      create_list(:baseball_player, 3)
      create(:baseball_player, position: "SS", age: 22)
      create_list(:baseball_player, 3, position: "P")
      create_list(:basketball_player, 3, position: "SS")

      expect(Player.average_position_age("BaseballPlayer", "SS")).to eq(29.5)
    end
  end

  describe "#average_position_age_diff" do
    it "calculates the difference between the average and the player" do
      create(:basketball_player, age: 32)
      create(:basketball_player, age: 35)
      subject = create(:basketball_player, age: 20)

      expect(subject.average_position_age_diff).to eq(-9)
    end
  end
end