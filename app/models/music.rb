class Music < ActiveRecord::Base
  attr_reader :id, :name, :type, :link, :image

  def initialize(spotify_object)
    @id       = spotify_object.id
    @name     = spotify_object.name
    @link     = spotify_object.external_urls["spotify"]
    @type     = spotify_object.type
    # track
    # @image    = spotify_object.images[0]["url"]
    # album
    # @image    = spotify_object.album.images[0]["url"]
    # artist 
    # @image    = spotify_object.artist.images[0]["url"]   
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
      @music     = RSpotify::Artist.find(music_id)
    when "album"
      @music     = RSpotify::Album.find(music_id)
    when "track"
      @music     = RSpotify::Track.find(music_id)
    else
      @music     = nil
    end 
      self.new(@music)
  end
end

