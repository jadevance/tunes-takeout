class Music < ActiveRecord::Base
  attr_reader :id, :name, :type, :link, :image, :embed 

  def initialize(spotify_object)
    @id      = spotify_object.id
    @name    = spotify_object.name
    @link    = spotify_object.external_urls["spotify"]
    @type    = spotify_object.type
    @embed   = spotify_object.uri 
    unless @type == "track" || spotify_object.images.empty?
      @image = check_for_images(spotify_object.images)
      @image = @image["url"]
    else 
      @image = nil
    end 
  end

  def self.suggested_music(tunes_takeout_suggestion)
    tunes_takeout_suggestion.collect { |suggestion| 
      self.search(suggestion["music_id"], 
      suggestion["music_type"])
    }
  end

  def self.search(music_id, music_type)
    case music_type
    when "artist"
      @music = RSpotify::Artist.find(music_id)
    when "album"
      @music = RSpotify::Album.find(music_id)
    when "track"
      @music = RSpotify::Track.find(music_id)
    else
      @music = nil
    end 
      self.new(@music)
  end

  def check_for_images(image_array)
    image_array.find {|image| image["url"] != nil }
  end 
end

# artist 
# @image    = spotify_object.artist.images[0]["url"]   
# album
# @image    = spotify_object.album.images[0]["url"]
# track
# @image    = spotify_object.images[0]["url"]