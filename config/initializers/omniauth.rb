Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, CONFIG['github']['key'], CONFIG['github']['secret']
end

if Rails.env.production?
  OmniAuth.config.full_host = "http://fork2.com"
end