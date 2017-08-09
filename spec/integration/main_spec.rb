require 'spec_helper'

describe Insight do

  class Explorer
    extend Insight
  end

  specify "init" do
    Explorer.api = nil

    # points to mainnet explorer url
    explorer = Explorer.api
    explorer.url.should == "https://insight.bitpay.com/api"
    Explorer.api = nil

    explorer = Explorer.api network: 'btc'
    explorer.url.should == "https://insight.bitpay.com/api"
    Explorer.api = nil

    # accepts switching to other insight networks (insight hosts / chain explorers, like testnet and bch)
    explorer = Explorer.api network: Insight::TEST_CHAIN
    explorer.url.should == "https://test-insight.bitpay.com/api"
    Explorer.api = nil

    # inits on BCH as well
    explorer = Explorer.api network: Insight::BCH_CHAIN
    explorer.url.should == "http://blockdozer.com/insight-api"
    Explorer.api = nil
  end

  # change network here to test different block explorer (insight hosts)
  EXP = Explorer.api network: Insight::BCH_CHAIN

  require 'pp'

  # NOTE: the spec from here is an integration spec, meaning that if the block explorer is currently failing (or your connection to it fails for some reason, the spec will inevitably fail too.)

  specify "blocks" do
    EXP.url.should == "http://blockdozer.com/insight-api"
    blocks = EXP.blocks
    blocks.should be_an Array
    blocks.should_not be_empty
    block = blocks.first
    block.should be_an Hash
    block.should have_key :height
    block.should have_key :size
    block.should have_key :hash
    block.should have_key :time
    block.should have_key :txlength
    block.should have_key :poolInfo
  end

  # TODO: add more integration specs

end
