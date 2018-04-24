require_relative "../config/environment"

data_source = CbsSports::FetchPlayers.new

Player.import_players!(data_source, ['basketball', 'football', 'baseball'])