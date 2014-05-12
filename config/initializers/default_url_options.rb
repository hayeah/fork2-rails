if Rails.env.production?
  Rails.application.routes.default_url_options[:host] = "fork2.com"
else
  Rails.application.routes.default_url_options[:host] = "localhost:3000"
end