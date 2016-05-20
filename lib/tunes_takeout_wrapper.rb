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

  def self.top_favorites(limit=10)
    data = HTTParty.get(BASE_URL + "/v1/suggestions/top?limit=#{limit}").parsed_response
    self.new(data)
  end 

  def self.each_favorite(id)
    data = HTTParty.get(BASE_URL + "/v1/suggestions/#{id}").parsed_response
    @suggestion  = data["suggestion"]
  end 
end 
