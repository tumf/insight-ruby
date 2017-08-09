class Coincap

  COINS = {
    btc:  "bitcoin",
    eth:  "ethereum",
    xrp:  "ripple",
    bch:  "bitcoin-cash",
    ltc:  "litecoin",
    dash: "dash",
    etc:  "ethereum-classic",
    doge: "dogecoin",
  }

  def initialize(currency: :btc)
    @url = "https://api.coinmarketcap.com/v1/ticker/#{ticker currency}/"
  end

  def price
    resp = get @url
    resp.select!{ |key, value| key.to_s =~ /^(price|percent)/ }
    resp.each{ |key, value| resp[key] = value.to_f }

    {
      price: resp[:price_usd],
      meta: {
        price_btc: resp[:price_btc],
        change: {
          "1h":  resp[:percent_change_1h],
          "24h": resp[:percent_change_24h],
          "7d":  resp[:percent_change_7d],
        },
      },
    }
  end

  private

  def get(url)
    uri = URI url
    resp = Net::HTTP.get_response uri
    resp = JSON.parse resp.body
    resp = resp.first # only 1 currency pair
    sym_keys resp
  end

  def ticker(currency)
    COINS.fetch currency
  end

  # symbolize keys - TODO: extract / pull from another module
  def sym_keys(hash)
    hash.map { |key, val| [key.to_sym, val] }.to_h
  end

end
