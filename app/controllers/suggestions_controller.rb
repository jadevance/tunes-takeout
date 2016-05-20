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
    
    #extract Tunes and Takeout ids from suggestions
    @ids = []
    @suggestions.each do |suggestion|
      @ids << suggestion["id"]
    end  

    @music_suggestions  = Music.suggested_music(@suggestions)
    @food_suggestions   = Food.suggested_food(@suggestions)
    
    # lol I heart doing janky zip stuff
    @pairing_suggestions = @music_suggestions.zip(@food_suggestions) 
    render :index 
  end 

  def favorites
    # get the favorites
    @tunes_takeout   = TunesTakeoutWrapper.top_favorites 
    # array of tunestakeout ids
    @top_favorites =  @tunes_takeout.suggestions
    
    @list = []
    #look up each favorite 
    @top_favorites.each do |id|
      # return a hash with each id, food_id and music_id
      @list << TunesTakeoutWrapper.each_favorite(id) 
    end 
  end

  def unfavorite
  end 

end

# favorites right now goes to a top ten list
# need to think about favorites by user 