module Insight
  class API

    attr_reader :network,
                :api_version

    def initialize(network: 'btc', url: nil, api_version: nil)
      @url          = url
      self.network  = network
      @api_version  = api_version
    end


    def url
      @url ||= case network
      when 'btc', 'btc-mainnet' then 'https://insight.bitpay.com/api'
      when 'btc-testnet'        then 'https://test-insight.bitpay.com/api'
      when 'bch'                then 'https://bch-insight.bitpay.com/api'
      when 'bch-testnet'        then 'https://test-bch-insight.bitpay.com/api'
      else
        raise "Network not found, please specify 'btc', 'btc-testnet' or 'bch'"
      end
    end

    def url=(other)
      @url = other
      @connection = Connection.new other
    end

    def network=(network)
      @network = network
      @connection = Connection.new url
    end

    def blocks
      blocks = @connection.get "/blocks"
      blocks = blocks[:blocks] if blocks
      parse_resp blocks
    end

    def block(hash)
      @connection.get "/block/#{hash}"
    end

    def block_raw(hash)
      @connection.get "/rawblock/#{hash}"
    end

    def transaction(hash)
      @connection.get "/tx/#{hash}"
    end

    def rawtx(hash)
      @connection.get "/rawtx/#{hash}"
    end

    def push_transaction(hex)
      @connection.post '/tx/send', rawtx: hex
    end

    def address(address)
      @connection.get "/addr/#{address}"
    end

    def address_balance(address)
      @connection.get "/addr/#{address}/balance"
    end

    def address_total_received(address)
      @connection.get "/addr/#{address}/totalReceived"
    end

    def address_total_sent(address)
      @connection.get "/addr/#{address}/totalSent"
    end

    def address_unconfirmed_balance(address)
      @connection.get "/addr/#{address}/unconfirmedBalance"
    end

    def address_utxo(address, params = nil)
      query = query_string params if params
      @connection.get "/addr/#{address}/utxo#{query}"
    end

    def estimatefee(nbBlocks = 2)
      resp = @connection.get "/utils/estimatefee?nbBlocks=#{nbBlocks}"
      resp.values.first
    end

    def block_hash(block_index)
      resp = @connection.get "/block-index/#{block_index}"
      resp.fetch :blockHash
    end

    def sync
      @connection.get "/sync"
    end

    def peer
      @connection.get "/peer"
    end

    def status(method_name="getInfo")
      @connection.get "/status?q=#{method_name}"
    end

    # extra methods

    def blocks_last
      blocks.first
    end

    def blocks_today
      blocks.select do |block|
        block[:time] > today
      end
    end

    def blocks_count_today
      blocks_today.size
    end

    def blocks_big
      blocks.select do |block|
        block[:size] > 1_000_000
      end
    end

    def blocks_details
      details blocks
    end

    def blocks_big_details
      details blocks_big
    end

    def blocks_big_last
      blocks_big.first
    end

    # blocks status, last 10 blocks
    def blocks_status
      blks = blocks[0..9]
      blocks_ideal = (Time.now - blks.last[:time]) / block_time
      {
        count:        blks.size,
        count_target: blocks_ideal.round(1),
      }
    end
    
    alias :chain_tip :blocks_last
    alias :balance :address_balance
    alias :balance_unconfirmed :address_unconfirmed_balance
    alias :estimate_fee :estimatefee

    private

    def details(blocks_source)
      keys = %i(height size_kb time)
      blocks_source.map do |block|
        block.select { |key, value| keys.include? key }
      end
    end

    # used for block_status, relative only for bitcoin chains
    def block_time
      60*10
    end

    def today
      Date.today.to_time
    end

    def query_string(params)
      '?' + params.map { |k, v| "#{k}=#{v}" } * '&'
    end

    def parse_resp(resp)
      return unless resp
      case resp
      when Hash
        resp = parse_time resp
        resp = parse_size_bytes resp
        resp
      when Array
        resp.map do |res|
          parse_resp res
        end
      else
        raise "Unexpected type to be parsed"
      end
    end

    def parse_time(resp)
      resp[:time] = Time.at resp[:time] if resp[:time]
      resp
    end

    # TODO: apply only to block responese
    def parse_size_bytes(resp)
      resp[:size_kb] = resp[:size] / 1000 if resp[:size]
      resp
    end

  end
end
