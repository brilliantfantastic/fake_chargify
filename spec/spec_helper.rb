require 'rspec'
require 'fake_chargify'

require 'chargify_api_ares'

Chargify.configure do |c|
  c.subdomain = 'test'
  c.api_key   = 'api'
end

FakeChargify.configure do |c|
  c.subdomain = Chargify.subdomain
  c.api_key = Chargify.api_key
end

RSpec.configure do |config|
  config.before { FakeChargify.clear! }
end