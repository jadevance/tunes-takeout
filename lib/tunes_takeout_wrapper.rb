require 'httparty'

class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"
  attr_reader :suggestions, :href

  def initialize(data)
    @href        = data["href"]
    @suggestions = data["suggestions"]
  end

  def self.search(query, limit=10, seed=nil)
    data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{query}").parsed_response
    self.new(data)
  end
end 
