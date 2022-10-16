# Immoscoutr

This is a Ruby wrapper library for the ImmoScout24 (immobilientscout24.de) API, found at https://api.immobilienscout24.de/. It supports instantiation of multiple clients and is heavily inspired by https://github.com/hausgold/immoscout.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'immoscoutr'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install immoscoutr

## Usage

If you are planning on calling the API for one user only you can configure Immoscoutr as a singleton:
```ruby
Immoscoutr.consumer_key = ""
Immoscoutr.consumer_secret = ""

# If you already have your access token & secret, you can configure it directly:
Immoscoutr.access_token = ""
Immoscoutr.access_secret = ""

# If not, you will need to walk through the OAuth flow (see below)
```

If you require authenticating different users, use the Immoscoutr::Client class:
```ruby
client = Immoscoutr::Client.new(
    consumer_key: nil, # mandatory - from https://api.immobilienscout24.de/
    consumer_secret: nil, # mandatory - from https://api.immobilienscout24.de/
    access_token: nil, # if you already have an access_token
    access_secret: nil, # if you already have an access_secret
    sandbox: false, # default: false
    username: "me", # default: me
    version: Immoscoutr::API_VERSION, # default: "1.0"
)
```

To perform the oauth dance in order to get an access token & secret, follow these steps:
```ruby
# The URL param determines where the user should be redirected back to after authenticating
request_token = client.get_request_token("https://yourapp.com/oauth/callback")

# Important: store request_token.secret in some form of session, e.g.:
session[:oauth_request_secret] = request_token.secret

# Next, redirect the user to request_token.authorize_url
redirect_to request_token.authorize_url

# Once the user comes back to https://yourapp.com/oauth/callback the following params will be
# attached to the URL:
# * oauth_token - the oauth token
# * oauth_verifier - the oauth verifier
# * state - should be "authorized"
# Using this information you can now continue:
access_token = client.get_access_token(params[:oauth_token], session[:oauth_request_secret], params[:oauth_verifier])

# You can now access the access token & secret like this:
access_token.token
access_token.secret

# Store them (encrypted ideally). From now on you can create an Immoscoutr::Client with them to access the API as this user.
```

### Realestate

The Realestate API is access via: `client.realestate`

The following methods are available:

* #all
    ```ruby
    realestates, paging = client.realestate.all(page: 1, per_page: 20) # defaults are shown
    realestates # Array of Immoscoutr::Realestate
    paging # { pageNumber: 1, pageSize: 20, numberOfPages: 0, numberOfHits: 0 }
    ```

* #find(id)
    ```ruby
    realestate = client.realestate.find(123)
    realestate # The Immoscoutr::Realestate object or nil
    ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/immoscoutr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/immoscoutr/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Immoscoutr project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/immoscoutr/blob/master/CODE_OF_CONDUCT.md).
