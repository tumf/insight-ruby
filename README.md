# Insight

Ruby SDK for insight.bitpay.com - @makevoid's fork


## Install

Add this line to your application's Gemfile:

```ruby
gem 'insight_bitpay', git: "https://github.com/makevoid/insight-ruby"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install insight

## Usage

### Initialize the library

  ```ruby
    class Explorer
      extend Insight
    end

    explorer = Explorer.new network: 'btc'
  ```

You can also change the Blockchain using:
  ```ruby
    explorer.network = 'tbtc'
  ```

### Callable RPC Methods

You can use any of these methods with the initialized object or simply by calling:

  ```ruby
    Explorer.block hash
    Explorer.block_raw hash
    Explorer.transaction hash
    Explorer.push_transaction hex
    Explorer.address address
    Explorer.address_balance address
    Explorer.address_total_received address
    Explorer.address_total_sent address
    Explorer.address_unconfirmed_balance address
    Explorer.address_utxo address
    Explorer.estimatefee 2 # blocks
  ```

Responses are Ruby Hashes and Arrays serialized from the JSON data structures returned by the block explorer(s).

## Contributing

See the parent repo for instuctions on how to contribute to it, to contribute to this fork

1. Fork it ( https://github.com/makevoid/insight-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Contributors

- @makevoid - https://github.com/makevoid
- @jorge-aceves - https://github.com/jorge-aceves
