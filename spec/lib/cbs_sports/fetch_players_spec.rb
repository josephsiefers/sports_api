require 'rails_helper'

RSpec.describe CbsSports::FetchPlayers do
  describe "#fetch" do

    it "raises an error when given an invalid type" do
      VCR.use_cassette("invalid_request") do
        expect {
          CbsSports::FetchPlayers.new.fetch({type: 'basketweaving'})
        }.to raise_error(RuntimeError)
      end
    end

    it "fetches baseball players" do
      VCR.use_cassette("fetch_baseball_players") do
        players_json = CbsSports::FetchPlayers.new.fetch({type: 'baseball'})

        #simple sanity check that we got results back
        expect(players_json.first.keys.include?("id")).to be_truthy
      end
    end

    it "fetches football players" do
      VCR.use_cassette("fetch_football_players") do
        players_json = CbsSports::FetchPlayers.new.fetch({type: 'football'})

        #simple sanity check that we got results back
        expect(players_json.first.keys.include?("id")).to be_truthy
      end
    end

    it "fetches basketball players" do
      VCR.use_cassette("fetch_basketball_players") do
        players_json = CbsSports::FetchPlayers.new.fetch({type: 'basketball'})

        #simple sanity check that we got results back
        expect(players_json.first.keys.include?("id")).to be_truthy
      end
    end
  end
end
