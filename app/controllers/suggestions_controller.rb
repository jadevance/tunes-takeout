class SuggestionsController < ApplicationController
  skip_before_action :require_login, only: :index

  def index    
    if @suggestions.nil?
      redirect_to root_path, notice: "Sorry, nothing was found for #{params["query"]}!"
    else
      render :index
    end
  end 

  def create
    @tunes_takeout      = TunesTakeoutWrapper.search(params["query"]) 
    @pairing_suggestions = gather_suggestions
    render :index 
  end 
  
  def favorites
    # get the favorites
    @tunes_takeout   = TunesTakeoutWrapper.top_favorites 
    
    @top_favorites =  @tunes_takeout.suggestions
    @list = []
    #look up each favorite 
    @top_favorites.each do |id|
      @list << TunesTakeoutWrapper.each_favorite(id)  
    end
    @music_suggestions  = Music.suggested_music(@list)
    @food_suggestions   = Food.suggested_food(@list)
    @pairing_suggestions = []
    @list.length.times do |index|
      @pairing_suggestions << [@music_suggestions[index], @food_suggestions[index], @top_favorites[index]]
    end
  end

  private 

  def gather_suggestions
    @suggestions        = @tunes_takeout.suggestions

    @ids = []
    @suggestions.each do |suggestion|
      @ids << suggestion["id"]
    end  

    @music_suggestions  = Music.suggested_music(@suggestions)
    @food_suggestions   = Food.suggested_food(@suggestions)

    pairing_suggestions = []
    
    @ids.length.times do |index|
      pairing_suggestions << [@music_suggestions[index], @food_suggestions[index], @ids[index]]
    end

    return pairing_suggestions
  end 
end


# Opportunity to dry up code between create and favorites methods
# I will try and get to this after I finish testing

