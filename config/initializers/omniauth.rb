OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :runkeeper, ENV['RUNKEEPER_CLIENT_ID'], ENV['RUNKEEPER_CLIENT_SECRET']
end
