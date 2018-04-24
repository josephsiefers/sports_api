module CbsSports
  class FetchPlayers

    #def initialize()
      #authentication info stored for api here, if it was required
    #end

    #http://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=baseball&response_format=JSON
    def fetch(filters = { type: 'baseball'} )

      url = "http://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=#{filters[:type]}&response_format=JSON"

      resp = HTTParty.get(url)
      #todo: exception handling

      if !resp.present?
        raise"There was an error with the request - no response received for url: #{url}"
      elsif resp.code != 200
        raise "There was an error with the request - code: #{resp.code} for url: #{url}"
      elsif resp.code == 200
        JSON.parse(resp.parsed_response)["body"]["players"]
      end
    end
  end
end