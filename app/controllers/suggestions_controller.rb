class SuggestionsController < ApplicationController
  skip_before_action :require_login, only: :index

  def index    
    if @suggestions.nil?
      redirect_to root_path, notice: "No matches for #{params["query"]}!"
    else
      render :index
    end
  end 

  def create
    @tunes_takeout      = TunesTakeoutWrapper.search(params["query"]) 
    @suggestions        = @tunes_takeout.suggestions
    
    @music_suggestions  = Music.suggested_music(@suggestions)
    @food_suggestions   = Food.suggested_food(@suggestions)
    # lol I heart zip
    @pairing_suggestions = @music_suggestions.zip(@food_suggestions) 
    render :index 
  end 

  def favorites
    # get the favorites, array of ids
    @top_favorites   = TunesTakeoutWrapper.top_favorites 
    list = []
    #look up each favorite 
    @top_favorites.each do |id|
      @tunes_takeout = TunesTakeoutWrapper.each_favorite(id) 
      # list of urls in an array 
      list << @tunes_takeout.href
    end 
  end

  def unfavorite
  end 

end

# favorites right now goes to a top ten list
# need to think about favorites by user 