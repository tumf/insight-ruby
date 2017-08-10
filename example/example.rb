require 'pp'
require_relative '../lib/insight'

class Explorer
  extend Insight
end

EXP = Explorer.api network: Insight::BCH_CHAIN


# genesis block

# puts "Hash:"
# pp EXP.block_hash 0

# puts "Block:"
# pp EXP.block "000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f"
#
# puts "Block:"
# pp EXP.block EXP.block_hash 478860


puts "Address:"
pp EXP.address "1HQ5VfwwC2rXs5rG5tovjFg226fsvHRQWQ"
puts

# puts "Balance:"
# pp EXP.balance "1HQ5VfwwC2rXs5rG5tovjFg226fsvHRQWQ"
# puts
#
# puts "Balance (0 conf):"
# pp EXP.balance_unconfirmed "1HQ5VfwwC2rXs5rG5tovjFg226fsvHRQWQ"
# puts

# puts "UTXOs:"
# pp EXP.address_utxo "1HQ5VfwwC2rXs5rG5tovjFg226fsvHRQWQ"
# puts


# sendtx
#
# EXP.push_transaction

puts "Estimate Fee:"
pp EXP.estimate_fee
puts

#
# puts "Blocks:"
# pp EXP.blocks_details
# puts
#
# puts "Last block:"
# pp EXP.blocks_last
# puts
#
# puts "Last big block:"
# pp EXP.blocks_big_last
# puts
#
# puts "Latest big blocks:"
# pp EXP.blocks_big_details
# puts
#
# puts "BCH price:"
# pp price.price
# puts

# ------

# puts "Today's blocks:"
# pp EXP.blocks_count_today
# puts
#
# puts "Blocks status:"
# pp EXP.blocks_status
# puts

# Explorer.api = nil
#
# EXP = Explorer.api
# puts "Blocks status (main chain):"
# pp EXP.blocks_status
# puts
