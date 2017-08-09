require_relative '../lib/insight'

RSpec.configure do |conf|
  conf.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
