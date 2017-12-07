# ItunesSubscription

Ruby wrapper for iTunes Subscription [Apple doc](https://developer.apple.com/library/content/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itunes-subscription', git: 'https://github.com/SHabor/itunes-subscription.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itunes-subscription

## Usage

    receipt = ItunesSubscription.verify_receipt(base64_string, sandbox = true, password)

methods: 

    receipt.status
    
or

    receipt[:status]
    
other:

    receipt.status_info
    receipt.success?
    receipt.error?
    receipt.active_subscription

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/SHabor/itunes-subscription).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

