require 'httparty'
require 'json'

class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/v1/"
  attr_reader :suggestions, :href

  def initialize(data)
    @href        = data["href"]
    @suggestions = data["suggestions"]
  end

  def self.search(query, limit=10, seed=nil)
    data = HTTParty.get(BASE_URL + "suggestions/search?query=#{query}").parsed_response
    self.new(data)
  end

  def self.top_favorites(limit=10)
    data = HTTParty.get(BASE_URL + "suggestions/top?limit=#{limit}").parsed_response
    self.new(data)
  end 

  def self.each_favorite(id)
    data = HTTParty.get(BASE_URL + "suggestions/#{id}").parsed_response
    @suggestion  = data["suggestion"]
  end 

  def self.get_favorites(user_id)
    data = HTTParty.get(BASE_URL + "users/#{user_id}/favorites").parsed_response
    @favorites   = data["suggestions"]
  end 

 def self.favorite(user_id, suggestion_id)
    HTTParty.post(BASE_URL + "users/#{user_id}/favorites", { body: { "suggestion": suggestion_id }.to_json} )
  end

  def self.unfavorite(user_id, suggestion_id)
    HTTParty.delete(BASE_URL + "users/#{user_id}/favorites", { body: { "suggestion": suggestion_id }.to_json} )
  end
end 
