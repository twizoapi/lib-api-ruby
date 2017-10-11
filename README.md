![Twizo](http://www.twizo.com/online/logo/logo.png) 

# Twizo Ruby API

Connect to the Twizo API using the Ruby library. This API includes functions to send verifications (2FA), SMS and Number Lookup.

## Requirements ##
* Ruby >= 2.4

## Get application secret and api host ##
To use the Twizo API client, the following things are required:

* Create a [Twizo account](https://register.twizo.com/)
* Login on the Twizo portal
* Find your [application](https://portal.twizo.com/applications/) secret
* Find your nearest api [node](https://www.twizo.com/developers/documentation/#introduction_api-url)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twizo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twizo

## Usage

Require the Twizo gem first:

```ruby
require 'twizo'
```

Initializing the Twizo Api using your api secret and api host

```ruby
twizo = Twizo::Twizo.new('api_key', 'api_host')
```


Create a verification

```ruby
verification = twizo.create_verification('610123456789')
verification = verification.send
```

Verify token

```ruby
begin
  verify_token = twizo.verify_token(verification.messageId, '12345')
  puts verify_token
rescue Twizo::TwizoError => e
  puts e.body
end
```


Create a number lookup, you can specify a single number or multiple numbers 
in an array.

```ruby
number_lookup = twizo.create_number_lookup('610123456789')
number_lookup = number_lookup.send
```

Create an sms, you can specify a single recipient or multiple recipients 
in an array.

```ruby
sms = twizo.create_sms('body', '610123456789', 'Sender')
sms = sms.send_simple
```

When you want to configure the dcs or udh, simply use sms.send. For more information about sending concatenated messages, visit https://www.twizo.com/developers/tutorials/#concat.


Create a widget

```ruby
widget = twizo.create_widget('610123456789')
widget = widget.send
```

Get the status of a widget

```ruby
status = twizo.get_widget_status(widget.sessionToken, widget.recipient)
```


## Examples
In the examples directory you can find a collection of cli examples of how to use the api. When first running an example you will be asked for a host name and secret; this will be written to a credentials file.

## Testing
In the test directory you can find a collection of tests. When first running a test you will be asked for a host name and secret; this will be written to a credentials file.

## Development

After checking out the repo, run `bin/setup` to install dependencies. `bin/setup` requires the bundler gem to be installed. You can do this by running `gem install bundler` in the console.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/twizoapi/lib-api-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

You can also contact support@silverstreet.com for issues.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Twizo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/twizo/blob/master/CODE_OF_CONDUCT.md).
