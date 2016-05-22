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
    @pairing_suggestions = []
    @list.length.times do |index|
      @pairing_suggestions << [@music_suggestions[index], @food_suggestions[index], @list[index]]
    end 
  end

  def favorite
    # pulling the id out of the params hash
    id = params.values.to_a
    suggestion_id = id[2]["id"]
    user_id = current_user.uid
    # response from Charles' API 
    response = TunesTakeoutWrapper.favorite(user_id, suggestion_id)
    redirect_to my_favorites_path
  end

  def unfavorite
    # pulling the id out of the params hash
    id = params.values.to_a
    suggestion_id = id[2]["id"]
    user_id = current_user.uid
    # response from Charles' API 
    response = TunesTakeoutWrapper.favorite(user_id, suggestion_id)
    redirect_to my_favorites_path
  end
end 