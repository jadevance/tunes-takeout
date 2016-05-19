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
    @tunes_takeout = TunesTakeoutWrapper.search(params["query"])
    @suggestions = @tunes_takeout.suggestions
    @music_suggestions = Music.suggested_music(@suggestions)
    @food_suggestions = Food.suggested_food(@suggestions)
    render :index 
  end 


  def show
    # individual restaurants / music 
    # don't forget a route
  end 

  def favorite
  end

  def unfavorite
  end 

end
