class UsersController < ApplicationController
  def favorites
    @tunes_takeout = TunesTakeoutWrapper.get_favorites(current_user.uid) 
    @list = []
    @tunes_takeout.each do |id|
      @list << TunesTakeoutWrapper.each_favorite(id)  
    end  

    @music_suggestions   = Music.suggested_music(@list)
    @food_suggestions    = Food.suggested_food(@list) 
    @pairing_suggestions = []
    @list.length.times do |index|
      @pairing_suggestions << [@music_suggestions[index], @food_suggestions[index], @list[index]]
    end 
  end

  def favorite
    id = params.values.to_a
    suggestion_id = id[2]["id"]
    user_id = current_user.uid
    response = TunesTakeoutWrapper.favorite(user_id, suggestion_id)
    redirect_to my_favorites_path
  end

  def unfavorite
    id = params.values.to_a
    suggestion_id = id[3]["id"]
    user_id = current_user.uid
    response = TunesTakeoutWrapper.unfavorite(user_id, suggestion_id)
    redirect_to my_favorites_path
  end
end 