OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], redirect_uri: ENV["GOOGLE_AUTH_REDIRECT_URI"] || "http://localhost:3000/auth/google_oauth2/callback"
end
