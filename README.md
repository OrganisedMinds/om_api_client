# OmApiClient

TODO: Write a gem description

## Installation

Once we publish this on RubyGems.org; Add this line to your application's Gemfile:

    gem 'om_api_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install om_api_client

## Usage

```
>> c = OM::Api::Client.new(
     endpoint: "http://localhost:3000/",
     client_id: "89e598...",
     client_secret: "10d06f..."
     scopes: %w[read write]
   )
>> c.me
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
