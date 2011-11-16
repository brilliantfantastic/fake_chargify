fake_chargify
==============
fake_chargify is a helper for faking web requests and responses to and from the Chargify API. You can test Chargify within your application on a plane now. I am sure that happens all the time.

# Installation

	gem 'fake_chargify'
	require 'fake_chargify'

# The basics

Example, in spec_helper.rb

	FakeChargify.activate!
	RSpec.configure do |c|
	  c.before do
	    FakeChargify.clear!
	  end
	end

