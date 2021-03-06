# DEPRECATED

This CLI has been superseded by its Rust version: https://github.com/tiagoamaro/pickpocket-rust.

-----

# Pickpocket

[![Gem Version](https://badge.fury.io/rb/pick-pocket.svg)](https://badge.fury.io/rb/pick-pocket)
[![Build Status](https://travis-ci.org/tiagoamaro/pickpocket.svg?branch=master)](https://travis-ci.org/tiagoamaro/pickpocket)
[![Code Climate](https://codeclimate.com/github/tiagoamaro/pickpocket/badges/gpa.svg)](https://codeclimate.com/github/tiagoamaro/pickpocket)
[![Test Coverage](https://codeclimate.com/github/tiagoamaro/pickpocket/badges/coverage.svg)](https://codeclimate.com/github/tiagoamaro/pickpocket/coverage)

Pickpocket is a command line tool which will help you with your [Pocket](http://getpocket.com/) library. It selects a random article for you to read, opening your browser and marking it is deleted. 

## Installation

Pickpocket is packaged as a Ruby gem.

Install it by running `gem install pick-pocket`

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
    - Options: `--quantity, -q`: quantity of articles to open. Examples:
        - `pickpocket pick --quantity 5` (open 5 articles)
        - `pickpocket pick -q 10` (open 10 articles)
- `pickpocket renew`
    - This will synchronize your local library with your remote. Keep in mind: any article marked as read **WILL BE DELETED** from your remote library
- `pickpocket stats`
    - Show the number of read/unread articles you have on your local library

## Pickpocket Files

All Pickpocket files are stored at the `~/.pickpocket` folder.

- `library_file`
    - YAML file which stores your local library, marking articles as unread or read
- `authorization_token`
    - File which stores your authorization token
- `oauth_token`
    - File which stores your OAuth token

## Don't Trust Me?

Pickpocket ships with its own consumer key, which will ask for access to modify/retrieve your articles.
 
If you don't like this idea, you can use your own consumer key, setting up the `POCKET_CONSUMER_KEY` environment variable before calling it.

Example:

`POCKET_CONSUMER_KEY="my-consumer-key" pickpocket oauth`
 
> To know more about consumer keys and how Pocket deals with third party applications, read more on [Pocket's Authentication API documentation](https://getpocket.com/developer/docs/authentication). 

## License

MIT
