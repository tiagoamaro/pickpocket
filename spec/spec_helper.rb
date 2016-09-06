$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pickpocket'

Pickpocket.configure do |config|
  config.home_folder              = File.expand_path('~/.pickpocket/test')
  config.authorization_token_file = File.expand_path('~/.pickpocket/test/authorization_token')
  config.oauth_token_file         = File.expand_path('~/.pickpocket/test/oauth_token')
  config.article_list_file        = File.expand_path('~/.pickpocket/test/article_list')
end
