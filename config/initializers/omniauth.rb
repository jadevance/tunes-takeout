require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "SPOTIFY_CLIENT_ID", "SPOTIFY_CLIENT_SECRET", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end