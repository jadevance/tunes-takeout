class Food < ActiveRecord::Base
  attr_reader :id, :name, :link, :phone, :address, :image, :rating

  def initialize(yelp_object)
    @id       = yelp_object.id
    @name     = yelp_object.name
    @link     = yelp_object.url
    @image    = yelp_object.image_url
    @rating   = {
      stars:        yelp_object.rating,
      stars_image:  yelp_object.rating_img_url
    }   
  end


  def self.suggested_food(tunes_takeout_suggestion)
    tunes_takeout_suggestion.collect { |suggestion| 
      self.search(suggestion["food_id"])
    }
  end


  def self.search(food_id)
    # parameterize fixes accented business names 
    @food = Yelp.client.business(food_id.parameterize).business
    self.new(@food)
  end

end
