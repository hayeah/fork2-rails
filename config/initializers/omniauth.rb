Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, CONFIG['github']['key'], CONFIG['github']['secret']
end