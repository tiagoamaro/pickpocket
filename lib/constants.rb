module Pickpocket
  CONSUMER_KEY = ENV.fetch('POCKET_CONSUMER_KEY', '58132-f824d5fbf935681e22e86a3c')
  VERSION      = '0.0.1'

  POCKET_HOMEPAGE            = 'https://getpocket.com'
  POCKET_OAUTH_AUTHORIZE_URL = 'https://getpocket.com/v3/oauth/authorize'
  POCKET_OAUTH_REQUEST_URL   = 'https://getpocket.com/v3/oauth/request'
  POCKET_RETRIEVE_URL        = 'https://getpocket.com/v3/get'
end
