# CoinMarket

Ruby API client for crypto market statistics. Currently uses the [CoinMarketCap API](https://coinmarketcap.com/api/).

    Endpoints update every 5 minutes.
    Please limit requests to no more than 10 per minute.

See the link above for more information.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coin_market'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coin_market

## Usage

Fetch statistics about a specific token:

    res = CoinMarket::Ticker.get('bitcoin')
    puts "#{res.symbol}: #{res.price}"
    # => BTC: 15330.8
    puts "#{res.name}: #{res.market_cap}"
    # Bitcoin: 256933859710.0
    puts res.percent_change(period: '1h')
    # => -1.03
    puts res.percent_change(period: '24h')
    # => 6.42

Or fetch statistics for all of the top 100 currencies (based on market cap):

    res = CoinMarket::Ticker.all
    puts res[0..10].map(&:name).join(', ')
    # => Bitcoin, Ethereum, Bitcoin Cash, Ripple, Litecoin, Cardano, IOTA, Dash, NEM, Monero, Bitcoin Gold

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zapnap/coin_market. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to follow the [code of conduct](https://github.com/zapnap/coin_market/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

Copyright &copy; 2017 Nick Plante, released under the MIT license
