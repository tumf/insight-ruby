require 'pp'
require_relative '../lib/insight'

class Explorer
  extend Insight
end

EXP = Explorer.api network: Insight::BCH_CHAIN

puts "Hash:"
pp EXP.block_hash 0

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
