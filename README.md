# Pickpocket

[![Build Status](https://travis-ci.org/tiagoamaro/pickpocket.svg?branch=master)](https://travis-ci.org/tiagoamaro/pickpocket)
[![Code Climate](https://codeclimate.com/github/tiagoamaro/pickpocket/badges/gpa.svg)](https://codeclimate.com/github/tiagoamaro/pickpocket)
[![Test Coverage](https://codeclimate.com/github/tiagoamaro/pickpocket/badges/coverage.svg)](https://codeclimate.com/github/tiagoamaro/pickpocket/coverage)

Pickpocket is a command line tool which will help you with your [Pocket](http://getpocket.com/) library. It selects a random article for you to read, opening your browser and marking it is deleted. 

## Usage

### Authentication

To use Pickpocket, you first need to go through Pocket's OAuth authentication process.

1. Execute the `pickpocket oauth` command
    1. This will open your web browser, asking you to approve Pickpocket's OAuth token
2. Execute the `pickpocket authorize` command
    1. This will authorize your OAuth token against Pocket, creating an authorization token
    
### Usage

- `pickpocket pick`
    - Selects a random article from your list, and open your browser with its resolved URL
- `pickpocket renew`
    - This will synchronize your local library with your remote. Keep in mind this will delete articles marked as read

## Don't Trust Me?

Pickpocket ships with its own consumer key, which will ask for access to modify/retrieve your articles.
 
If you don't like this idea, you can use your own consumer key, setting up the `POCKET_CONSUMER_KEY` environment variable before calling it.

Example:

`POCKET_CONSUMER_KEY="my-consumer-key" pickpocket oauth`
 
> To know more about consumer keys and how Pocket deals with third party applications, read more on [Pocket's Authentication API documentation](https://getpocket.com/developer/docs/authentication). 

## License

MIT
