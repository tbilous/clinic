require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick
  plugin :avatarmagick

  secret "4a801e881a9ae1b7491131cb758cfe8b741a76561def141de8ec14c9436c7807"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
