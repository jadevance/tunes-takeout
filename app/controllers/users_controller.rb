class UsersController < ApplicationController
  def favorites
    # get the favorites
    @tunes_takeout = TunesTakeoutWrapper.get_favorites(current_user.uid) 
    
    @list = []
    #look up each favorite 
    @tunes_takeout.each do |id|
      @list << TunesTakeoutWrapper.each_favorite(id)  
    end  

    @music_suggestions   = Music.suggested_music(@list)
    @food_suggestions    = Food.suggested_food(@list)
    @pairing_suggestions = @music_suggestions.zip(@food_suggestions) 
  end 
end
