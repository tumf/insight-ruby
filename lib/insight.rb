require 'forwardable'
require 'rest-client'
require 'json' # TODO: replace json with oj (speed)
require_relative 'insight/api'
require_relative 'insight/connection'

module Insight

  extend Forwardable

  attr_writer :api

  MAIN_CHAIN = 'btc'
  TEST_CHAIN = 'btc-testnet'
  BCH_CHAIN  = 'bch'
  TEST_BCH_CHAIN = 'bch-testnet'

  def api(network: MAIN_CHAIN)
    @api ||= API.new network: network
  end

  def_delegators :@api, :url=, :network=, :blocks, :block, :block_raw, :block_hash, :transaction, :rawtx, :push_transaction, :address, :address_balance, :address_total_received, :address_total_sent, :address_unconfirmed_balance, :address_utxo, :estimatefee, :blocks_last, :chain_tip, :balance, :balance_unconfirmed, :estimate_fee

end
