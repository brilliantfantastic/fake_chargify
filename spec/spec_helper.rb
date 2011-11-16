require 'rspec'
require 'fake_chargify'

#require 'chargify_api_ares'

RSpec.configure do |config|
  config.before { FakeChargify.clear! }
end