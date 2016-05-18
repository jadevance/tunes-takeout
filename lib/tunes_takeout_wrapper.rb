require 'httparty'

module TunesTakeoutWrapper
    BASE_URL = "https://tunes-takeout-api.herokuapp.com/v1/"

  def initialize(data)
    @id = data["id"]
    @food_id = data["food_id"]
    @music_id = data["music_id"]
    @music_type = data["music_type"]
  end 

  # limit, seed as params?
  def self.find(suggestion)
    data = HTTParty.get(BASE_URL + "suggestions/search?#{suggestion}").parsed_response
    self.new(data)
  end
end 